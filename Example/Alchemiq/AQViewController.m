//
//  AQViewController.m
//  Alchemiq
//
//  Created by Aleksey Getman on 12/10/2016.
//  Copyright (c) 2016 Aleksey Getman. All rights reserved.
//

#import "AQViewController.h"
#import <objc/runtime.h>

@interface AQViewController ()

@end

@implementation AQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textToShow = @"Mixin was injected successfully!";
        
    [self setupTableView];
}

- (IBAction)callMixinMethod:(id)sender {
    [self showDefaultAlert];
}


@end
