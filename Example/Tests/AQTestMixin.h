//
//  AQTestMixin.h
//  Alchemiq
//
//  Created by Alexey Getman on 10/12/2016.
//  Copyright © 2016 Aleksey Getman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQMixin.h"

@protocol AQTestMixin <AQMixin>

@required
@property (strong, nonatomic) NSString *testRequiredProperty;
- (NSString *)testInstanceRequiredMethod;
+ (NSString *)testClassRequiredMethod;


@optional
@property (strong, nonatomic) NSString *testOptionalProperty;
- (NSString *)testInstanceOptionalMethod;
+ (NSString *)testClassOptionalMethod;

@end
