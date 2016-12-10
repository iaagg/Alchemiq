//
//  AQTestMixinDescription.h
//  Alchemiq
//
//  Created by Alexey Getman on 10/12/2016.
//  Copyright © 2016 Aleksey Getman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQTestMixin.h"
#import "AQMixinDescription.h"

extern NSString * const testString;

@interface AQTestMixinDescription : AQMixinDescription <AQTestMixin>

@end
