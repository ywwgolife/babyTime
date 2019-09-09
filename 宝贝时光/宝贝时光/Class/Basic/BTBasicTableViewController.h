//
//  BTBasicTableViewController.h
//  宝贝时光
//
//  Created by yww on 2019/9/8.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BTBasicTableViewController;
@protocol BTBasicTableViewControllerRefreshDelegate <NSObject>

@optional
/**
 下拉刷新
 
 @param tableView tableView
 */
-(void)refreshDropDownWith:(UITableView *)tableView;

/**
 上拉刷新
 
 @param tableView tableView
 */
-(void)refreshDropUpWith:(UITableView *)tableView;
@end


@interface BTBasicTableViewController : UITableViewController
@property (nonatomic, assign) BOOL isNeedRefresh;//是否需要刷新
@property (nonatomic, strong)  MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong)  MJRefreshAutoNormalFooter *refreshFooter;
//指向FNPbasicTableViewController的代理
@property (nonatomic,weak) id<BTBasicTableViewControllerRefreshDelegate> myRefreshDelegate;
@end

NS_ASSUME_NONNULL_END
