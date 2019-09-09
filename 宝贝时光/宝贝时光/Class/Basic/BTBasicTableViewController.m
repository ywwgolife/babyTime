//
//  BTBasicTableViewController.m
//  宝贝时光
//
//  Created by yww on 2019/9/8.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import "BTBasicTableViewController.h"

@interface BTBasicTableViewController ()

@end

@implementation BTBasicTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.isNeedRefresh) {
        self.tableView.mj_header = self.refreshHeader;
        self.tableView.mj_footer = self.refreshFooter;
    }
}
#pragma mark - 刷新
- (MJRefreshNormalHeader *)refreshHeader{
    if (!_refreshHeader) {
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginDropDownRefresh)];
        [_refreshHeader setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
        [_refreshHeader setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        [_refreshHeader setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    }
    return _refreshHeader;
}

- (MJRefreshAutoNormalFooter *)refreshFooter{
    if (!_refreshFooter) {
        _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginDropUpRefresh)];
        [_refreshFooter setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [_refreshFooter setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        [_refreshFooter setTitle:@"到底了" forState:MJRefreshStateNoMoreData];
    }
    return _refreshFooter;
}

- (void)beginDropDownRefresh {
    NSLog(@"下拉刷新");
    if ([self.myRefreshDelegate respondsToSelector:@selector(refreshDropDownWith:)]) {
        [self.myRefreshDelegate refreshDropDownWith:self.tableView];
    }
}

- (void)beginDropUpRefresh{
    NSLog(@"上拉刷新");
    if ([self.refreshFooter isRefreshing] ) {
        if ([self.myRefreshDelegate respondsToSelector:@selector(refreshDropUpWith:)]) {
            [self.myRefreshDelegate refreshDropUpWith:self.tableView];
        }
    }
}
@end
