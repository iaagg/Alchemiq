//
//  AQViewController.h
//  Alchemiq
//
//  Created by Aleksey Getman on 12/10/2016.
//  Copyright (c) 2016 Aleksey Getman. All rights reserved.
//

@import UIKit;
#import "AlertMixin.h"

@interface AQViewController : UIViewController <AlertMixin>

@property (weak, nonatomic) IBOutlet UIView *tableContainer;

@end
