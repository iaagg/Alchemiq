//
//  AlchemiqTests.m
//  AlchemiqTests
//
//  Created by Aleksey Getman on 12/10/2016.
//  Copyright (c) 2016 Aleksey Getman. All rights reserved.
//

@import XCTest;
#import "AQAlchemiq.h"
#import "AQSomeTestClass.h"
#import "AQTestMixinDescription.h"

@interface AQAlchemiqTests : XCTestCase

@property (strong, nonatomic) AQSomeTestClass *someClassWithMixin;

@end

@implementation AQAlchemiqTests


- (void)setUp
{
    [super setUp];
    [AQAlchemiq addMixins];
    self.someClassWithMixin = [AQSomeTestClass new];
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Properties

- (void)testClassWithMixinHasSetterForRequiredProperty {
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(setTestRequiredProperty:)], "Required property wasn't added to class");
    self.someClassWithMixin.testRequiredProperty = testString;
}

- (void)testClassWithMixinHasGetterForRequiredProperty {
    self.someClassWithMixin.testRequiredProperty = testString;
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(testRequiredProperty)], "Required property wasn't added to class");
    XCTAssertEqualObjects(self.someClassWithMixin.testRequiredProperty, testString, "Getter for required property returns wrong value");
}

- (void)testClassWithMixinHasSetterForOptionalProperty {
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(setTestOptionalProperty:)], "Required property wasn't added to class");
    self.someClassWithMixin.testOptionalProperty = testString;
}

- (void)testClassWithMixinHasGetterForOptionalProperty {
    self.someClassWithMixin.testOptionalProperty = testString;
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(testOptionalProperty)], "Required property wasn't added to class");
    XCTAssertEqualObjects(self.someClassWithMixin.testOptionalProperty, testString, "Getter for optional property returns wrong value");
}

#pragma mark - Methods

- (void)testClassWithMixinHasRequiredMethod {
    XCTAssertTrue([AQSomeTestClass respondsToSelector:@selector(testClassRequiredMethod)], "Required class method wasn't added to class");
    XCTAssertEqualObjects([AQSomeTestClass testClassRequiredMethod], testString, "Required class method returns wrong value");
}

- (void)testClassWithMixinHasOptionalMethod {
    XCTAssertTrue([AQSomeTestClass respondsToSelector:@selector(testClassRequiredMethod)], "Optional class method wasn't added to class");
    XCTAssertEqualObjects([AQSomeTestClass testClassRequiredMethod], testString, "Optional class method returns wrong value");
}

- (void)testClassInstanceWithMixinHasRequiredMethod {
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(testInstanceRequiredMethod)], "Required instance method wasn't added to class");
    XCTAssertEqualObjects([self.someClassWithMixin testInstanceRequiredMethod], testString, "Required instance method returns wrong value");
}

- (void)testClassInstanceWithMixinHasOptionalMethod {
    XCTAssertTrue([self.someClassWithMixin respondsToSelector:@selector(testInstanceRequiredMethod)], "Optional instance method wasn't added to class");
    XCTAssertEqualObjects([self.someClassWithMixin testInstanceRequiredMethod], testString, "Optional instance method returns wrong value");
}

@end

