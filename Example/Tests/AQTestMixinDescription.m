//
//  AQTestMixinDescription.m
//  Alchemiq
//
//  Created by Alexey Getman on 10/12/2016.
//  Copyright © 2016 Aleksey Getman. All rights reserved.
//

#import "AQTestMixinDescription.h"

NSString * const testString = @"AQtestString";

@implementation AQTestMixinDescription

@synthesize testRequiredProperty;
@synthesize testOptionalProperty;

- (NSString *)testInstanceRequiredMethod {
    return testString;
}

+ (NSString *)testClassRequiredMethod {
    return testString;
}

- (NSString *)testInstanceOptionalMethod {
    return testString;
}

+ (NSString *)testClassOptionalMethod {
    return testString;
}


@end
