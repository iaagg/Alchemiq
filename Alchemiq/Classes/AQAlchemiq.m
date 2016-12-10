//
//  AQAlchemiq.m
//  Pods
//
//  Created by Alexey Getman on 10/12/2016.
//
//

#import "AQAlchemiq.h"
#import "AQMixinCooker.h"

@implementation AQAlchemiq

+ (void)addMixins {
    [AQMixinCooker startCooking];
}

@end
