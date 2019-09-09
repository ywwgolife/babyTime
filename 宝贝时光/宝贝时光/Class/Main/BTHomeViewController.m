//
//  BTHomeViewController.m
//  宝贝时光
//
//  Created by yww on 2019/9/8.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import "BTHomeViewController.h"
static NSString *tableImageCellId = @"tableImageCellIdentifier";
@interface BTHomeViewController ()<BTBasicTableViewControllerRefreshDelegate>
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger size;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation BTHomeViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.refreshHeader setState:MJRefreshStateRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myRefreshDelegate = self;
    self.size = 10;
    self.currentPage = 1;
}
- (void)getPhotos{
    if ([BTGlobalTool sharedGlobalTool].networkStatus <= 0) {
        [MBProgressHUD showError:@"请检查您的网络了连接" toView:self.view];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"https://api.unsplash.com/photos/curated?client_id=%@",accessKey];
    NSDictionary *params = @{
                              @"page":@(self.currentPage),
                              @"per_page":@(self.size),
                              @"order_by":@"latest"
                              };
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:params error:nil];
    request.timeoutInterval = 20.f;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSArray *result = (NSArray *)responseObject;
            NSLog(@"返回===%@",result);
            [self.refreshHeader setState:MJRefreshStateIdle];
            if (self.currentPage == 1) {
                [self.dataArray removeAllObjects];
            }
            if (result.count > 0) {
                [self.refreshFooter setState:MJRefreshStateIdle];
                for (NSDictionary *dic in result) {
                    BTModel *model = [BTModel mj_objectWithKeyValues:dic];
                    [self.dataArray addObject:model];
                }
                self.currentPage ++;
            }else{
                [self.refreshFooter setState:MJRefreshStateNoMoreData];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            [self.refreshHeader setState:MJRefreshStateIdle];
            NSLog(@"请求失败error=%@", error);
        }
    }];
    [task resume];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为了赶时间 这里没有自定义cell这样可能内存消耗多些
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableImageCellId];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    BTModel *model;
    if (indexPath.row < self.dataArray.count-1){
        model = self.dataArray[indexPath.row];
    }
    CGFloat scale = 1;
    if (model.height.length > 0 && model.width.length > 0) {
        scale = [model.height floatValue]/[model.width floatValue];
    }
    CGFloat h = (KdeviceWidth-40) *scale;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, KdeviceWidth-40, h)];
    if (model.urls.small.length > 0) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.urls.small]];
    }
    [cell addSubview:imageView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BTModel *model;
    if (indexPath.row < self.dataArray.count-1){
        model = self.dataArray[indexPath.row];
    }
    CGFloat scale = 1;
    if (model.height.length > 0 && model.width.length > 0) {
        scale = [model.height floatValue]/[model.width floatValue];
    }
    CGFloat h = (KdeviceWidth-40) *scale;
    return 20 + h;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //图片
    BTModel *initModel;
    if (indexPath.row < self.dataArray.count-1){
        initModel = self.dataArray[indexPath.row];
    }
    NSInteger initIndex = 0;
    NSMutableArray *photos = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        BTModel *model = self.dataArray[i];
        if (model.urls.regular.length > 0) {
            IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:model.urls.regular]];
            [photos addObject:photo];
            if ([initModel.id isEqualToString:model.id]) {
                initIndex = i;
            }
        }
    }
    
    if (photos.count > 0) {
        //浏览
        IDMPhotoBrowser *browser = [BTGlobalTool photoBrowserTool:photos InitialPageIndex:initIndex];
        [self presentViewController:browser animated:YES completion:nil];
    }
}
#pragma mark - BTBasicTableViewControllerRefreshDelegate
- (void)refreshDropUpWith:(UITableView *)tableView{
    NSLog(@"上拉");
    [self getPhotos];
}
- (void)refreshDropDownWith:(UITableView *)tableView{
    NSLog(@"下拉");
    self.currentPage = 1;
    [self getPhotos];
}
@end
