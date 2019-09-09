//
//  BTGlobalTool.h
//  宝贝时光
//
//  Created by yww on 2019/9/9.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTGlobalTool : NSObject
@property (nonatomic , assign) AFNetworkReachabilityStatus networkStatus;
+ (instancetype)sharedGlobalTool;
+ (IDMPhotoBrowser *)photoBrowserTool:(NSArray *)photos InitialPageIndex:(NSInteger)InitialPageIndex;
@end

NS_ASSUME_NONNULL_END
