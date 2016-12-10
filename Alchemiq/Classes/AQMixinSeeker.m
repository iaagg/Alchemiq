//
//  AQMixinSeeker.m
//  Pods
//
//  Created by Alexey Getman on 10/12/2016.
//
//

#import "AQMixinSeeker.h"
#import "AQMixin.h"
#import "AQMixinDescription.h"

@implementation AQMixinSeeker

+ (NSArray<Protocol *> *)getMixins {
    NSMutableSet *foundMixins = [NSMutableSet new];
    
    Protocol *mixins = NULL;
    int totalProtocolsCount;
    Protocol * __unsafe_unretained *foundProtocols = objc_copyProtocolList(&totalProtocolsCount);
    
    if (totalProtocolsCount > 0) {
        
        for (int i = 0; i < totalProtocolsCount; i++) {
            
            Protocol *foundProtocol = foundProtocols[i];
            
            if ([self p_protocolIsMixin:foundProtocol]) {
                [foundMixins addObject:foundProtocol];
            }
        }
    }
    
    return [foundMixins allObjects];
}

+ (BOOL)p_protocolIsMixin:(Protocol *)protocol {
    if (protocol) {
        
        if (protocol_conformsToProtocol(protocol, @protocol(AQMixin))) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

+ (NSArray<Class> *)getMixinDescriptions {
    NSMutableSet *foundDescriptions = [NSMutableSet new];
    
    Class *classes = NULL;
    int totalClassesCount = objc_getClassList(classes, 0);
    
    if (totalClassesCount > 0) {
        classes = (__unsafe_unretained Class *)(malloc(sizeof(Class *) * totalClassesCount));
        objc_getClassList(classes, &totalClassesCount);
        
        for (int i = 0; i < totalClassesCount; i++) {
            Class foundClass = classes[i];
            
            if ([self p_classIsKindOfMixinDescription:foundClass]) {
                [foundDescriptions addObject:foundClass];
            }
        }
    }
    
    free(classes);
    
    return [foundDescriptions allObjects];
}

+ (BOOL)p_classIsKindOfMixinDescription:(Class)class {
    
    if (class) {
        
        if (class_conformsToProtocol(class, @protocol(AQMixin))) {
            
            Class superclass = class_getSuperclass(class);
            
            if (superclass == [AQMixinDescription class]) {
                return YES;
            }
        }
    }
    
    return NO;
}

+ (NSArray<Class> *)getClassesToInjectMixin:(Protocol *)mixin {
    NSMutableSet *foundClasses = [NSMutableSet new];
    
    Class *classes = NULL;
    int totalClassesCount = objc_getClassList(classes, 0);
    
    if (totalClassesCount > 0) {
        classes = (__unsafe_unretained Class *)(malloc(sizeof(Class *) * totalClassesCount));
        objc_getClassList(classes, &totalClassesCount);
        
        for (int i = 0; i < totalClassesCount; i++) {
            Class foundClass = classes[i];
            
            if (class_conformsToProtocol(foundClass, mixin) &&
                ![foundClass isSubclassOfClass:[AQMixinDescription class]]) {
                [foundClasses addObject:foundClass];
            }
        }
    }
    
    free(classes);
    
    return [foundClasses allObjects];
}

@end
