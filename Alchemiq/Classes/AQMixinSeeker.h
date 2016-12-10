//
//  AQMixinSeeker.h
//  Pods
//
//  Created by Alexey Getman on 10/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AQMixinSeeker : NSObject

+ (NSArray<Protocol *> *)getMixins;
+ (NSArray<Class> *)getMixinDescriptions;
+ (NSArray<Class> *)getClassesToInjectMixin:(Protocol *)mixin;

@end
