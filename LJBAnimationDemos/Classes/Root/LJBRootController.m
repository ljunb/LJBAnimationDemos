//
//  LJBRootController.m
//  LJBAnimationDemos
//
//  Created by CookieJ on 16/1/20.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBRootController.h"

static NSString * const kDemoCellIdentifier = @"AnimationDemoCell";

@interface LJBRootController ()

@property (nonatomic, copy) NSArray * demoNames;

@end

@implementation LJBRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDemoCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kDemoCellIdentifier
                                                             forIndexPath:indexPath];
    
    cell.textLabel.text    = self.demoNames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * clsString = [NSString stringWithFormat:@"LJB%@Controller", self.demoNames[indexPath.row]];
    
    Class controllerCls = NSClassFromString(clsString);
    
    UIViewController * nextController = [[controllerCls alloc] init];
    
    nextController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - Getter / Setter
- (NSArray *)demoNames {
    
    if (!_demoNames) {
        _demoNames = @[@"LoadingAnimation", @"TextDemo"];
    }
    return _demoNames;
}
@end
