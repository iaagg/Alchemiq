
#import "AlertMixinDescription.h"
#import "AQViewController.h"

@implementation AlertMixinDescription

@synthesize textToShow;
@synthesize tableView;

- (void)showDefaultAlert {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:self.textToShow preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:okAction];
        UIViewController *controller = (UIViewController *)(self);
        [controller presentViewController:alert animated:YES completion:nil];
    }
}

- (void)setupTableView {
    if ([self isKindOfClass:[AQViewController class]]) {
        AQViewController<UITableViewDataSource, UITableViewDelegate> *controller = (AQViewController<UITableViewDataSource, UITableViewDelegate> *)(self);
        tableView = [UITableView new];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.delegate = controller;
        tableView.dataSource = controller;
        [controller.tableContainer addSubview:tableView];
        [controller.tableContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"tableView" : tableView}]];
        [controller.tableContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"tableView" : tableView}]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"Cell created from mixin";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

@end
