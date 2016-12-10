//
//  AlertMixin.h
//  Alchemiq
//
//  Created by Alexey Getman on 10/12/2016.
//  Copyright © 2016 Aleksey Getman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQMixin.h"

@protocol AlertMixin <AQMixin, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *textToShow;
@property (strong, nonatomic) UITableView *tableView;

- (void)showDefaultAlert;
- (void)setupTableView;

@end
