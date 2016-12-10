//
//  AQMixinCooker.m
//  Pods
//
//  Created by Alexey Getman on 10/12/2016.
//
//

#import "AQMixinCooker.h"
#import "AQMixinSeeker.h"
#import <objc/runtime.h>

static NSString * const description =       @"Description";
static NSString * const mixinKey =          @"mixin";
static NSString * const descriptionKey =    @"description";

@implementation AQMixinCooker

+ (void)startCooking {
    NSArray<Class> *mixinDescriptions = [AQMixinSeeker getMixinDescriptions];
    NSArray<Protocol *> *mixins = [AQMixinSeeker getMixins];
    NSArray<NSDictionary *> *mixinsWithDescriptions = [self p_matchMixins:mixins withDescriptions:mixinDescriptions];
    [self p_injectMixins:mixinsWithDescriptions];
}

+ (NSArray<NSDictionary *> *)p_matchMixins:(NSArray<Protocol *> *)mixins withDescriptions:(NSArray<Class> *)descriptions {
    NSMutableArray *mixinsWithDescriptions = [NSMutableArray new];
    
    for (Protocol *mixin in mixins) {
        
        for (int i = 0; i < descriptions.count; i++) {
            Class description = descriptions[i];
            
            if ([self p_description:description matchesMixin:mixin]) {
                NSDictionary *dict = @{mixinKey : mixin, descriptionKey : description};
                [mixinsWithDescriptions addObject:dict];
            }
        }
    }
    
    return [mixinsWithDescriptions copy];
}

+ (BOOL)p_description:(Class)description matchesMixin:(Protocol *)mixin {
    NSString *descriptionName = [[NSString alloc] initWithUTF8String:class_getName(description)];
    NSString *mixinName = [[NSString alloc] initWithUTF8String:protocol_getName(mixin)];
    NSString *expectingDescriptionName = [self p_descriptionNameForMixin:mixinName];
    if ([descriptionName isEqualToString:expectingDescriptionName]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)p_descriptionNameForMixin:(NSString *)mixinName {
    NSString *name = [NSString stringWithFormat:@"%@%@", mixinName, description];
    return name;
}

+ (void)p_injectMixins:(NSArray<NSDictionary *> *)mixins {
    if (mixins.count > 0) {
        
        for (NSDictionary *mixinWithDescription in mixins) {
            
            Protocol *mixin = mixinWithDescription[mixinKey];
            Class description = mixinWithDescription[descriptionKey];
            
            NSArray<Class> *classesForInjection = [AQMixinSeeker getClassesToInjectMixin:mixin];
            
            for (int i = 0; i < classesForInjection.count; i++) {
                
                Class classForInjection = classesForInjection[i];
                [self p_injectMixin:mixin withDescription:description inClass:classForInjection];
            }
        }
    }
}

+ (void)p_injectMixin:(Protocol *)mixin withDescription:(Class)description inClass:(Class)class {
    [self p_injectMethodsFromMixin:mixin withDescription:description inClass:class];
    
    unsigned int protocolCount;
    Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(mixin, &protocolCount);
    
    if (protocolCount > 0) {
        
        for (int i = 0; i < protocolCount; i++) {
            Protocol *innerMixin = protocols[i];
            
            if (innerMixin == @protocol(NSObject)) {
                continue;
            }
            
            [self p_injectMixin:innerMixin withDescription:description inClass:class];
        }
    }
    
    return;
}


+ (const char *)p_makeSetterSelectorWithPropertyName:(const char*)propertyName {
    NSString *propertyNameString = [[NSString alloc] initWithUTF8String:propertyName];
    NSString *firstCharacter = [propertyNameString substringWithRange:NSMakeRange(0, 1)].capitalizedString;
    NSString *theRestName = [propertyNameString substringWithRange:NSMakeRange(1, propertyNameString.length - 1)];
    NSString *setter = [NSString stringWithFormat:@"%@%@%@%@", @"set", firstCharacter, theRestName, @":"];
    const char *setterChar = [setter UTF8String];
    return setterChar;
}

+ (void)p_injectMethodsFromMixin:(Protocol *)mixin withDescription:(Class)description inClass:(Class)class {
    unsigned int mixinOptionalInstanceMethodsCount;
    struct objc_method_description *optionalInstanceMethods = protocol_copyMethodDescriptionList(mixin, NO, YES, &mixinOptionalInstanceMethodsCount);
    [self p_injectMethods:optionalInstanceMethods methodsCount:mixinOptionalInstanceMethodsCount withDescription:description inClass:class];
    free(optionalInstanceMethods);
    
    unsigned int mixinRequiredInstanceMethodsCount;
    struct objc_method_description *requiredInstanceMethods = protocol_copyMethodDescriptionList(mixin, YES, YES, &mixinRequiredInstanceMethodsCount);
    [self p_injectMethods:requiredInstanceMethods methodsCount:mixinRequiredInstanceMethodsCount withDescription:description inClass:class];
    free(requiredInstanceMethods);
    
    unsigned int mixinOptionalClassMethodsCount;
    struct objc_method_description *optionalClassMethods = protocol_copyMethodDescriptionList(mixin, NO, NO, &mixinOptionalClassMethodsCount);
    [self p_injectMethods:optionalClassMethods methodsCount:mixinOptionalClassMethodsCount withDescription:description inClass:class];
    free(optionalClassMethods);
    
    unsigned int mixinRequiredClassMethodsCount;
    struct objc_method_description *requiredClassMethods = protocol_copyMethodDescriptionList(mixin, YES, NO, &mixinRequiredClassMethodsCount);
    [self p_injectMethods:requiredClassMethods methodsCount:mixinRequiredClassMethodsCount withDescription:description inClass:class];
    free(requiredClassMethods);
}

+ (void)p_injectMethods:(struct objc_method_description *)methods methodsCount:(int)count withDescription:(Class)description inClass:(Class)class {
    if (count > 0) {
        
        for (int i = 0; i < count; i++) {
            
            struct objc_method_description method = methods[i];
            [self p_getMethodImplementation:method.name fromMixinDescription:description completion:^(IMP implementation, BOOL classMethod) {
                
                if (implementation) {
                    
                    if (classMethod) {
                        Class metaClass = [self p_getMetaclassFromClass:class];
                        class_addMethod(metaClass, method.name, implementation, method.types);
                    } else {
                        class_addMethod(class, method.name, implementation, method.types);
                    }
                }
            }];
        }
    }
}

+ (void)p_getMethodImplementation:(SEL)methodName fromMixinDescription:(Class)description completion:(void(^)(IMP implementation, BOOL classMethod))completion {
    if (methodName == @selector(debugDescription)) {
        completion(nil, NO);
    }
    
    if ([description instancesRespondToSelector:methodName]) {
        IMP methodImplementation = class_getMethodImplementation_stret(description, methodName);
        completion(methodImplementation, NO);
    }
    
    if ([description respondsToSelector:methodName]) {
        Class metaClass = [self p_getMetaclassFromClass:description];
        IMP methodImplementation = class_getMethodImplementation_stret(metaClass, methodName);
        completion(methodImplementation, YES);
    }
    
    completion(nil, NO);
}

+ (Class)p_getMetaclassFromClass:(Class)class {
    const char *className = class_getName(class);
    Class metaClass = objc_getMetaClass(className);
    return metaClass;
}

@end
