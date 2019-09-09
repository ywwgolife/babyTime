//
//  BTGlobalTool.m
//  宝贝时光
//
//  Created by yww on 2019/9/9.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import "BTGlobalTool.h"

@implementation BTGlobalTool
static id _instace;
+ (instancetype)sharedGlobalTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}
- (id)copyWithZone:(NSZone *)zone{
    return _instace;
}
+ (IDMPhotoBrowser *)photoBrowserTool:(NSArray *)photos InitialPageIndex:(NSInteger)InitialPageIndex{
    IDMPhotoBrowser *photoBrower = [[IDMPhotoBrowser alloc]initWithPhotos:photos];
    [photoBrower setInitialPageIndex:InitialPageIndex];
    photoBrower.dismissOnTouch = YES;
    photoBrower.displayDoneButton = YES;
    photoBrower.displayToolbar = YES;
    photoBrower.displayCounterLabel = YES;
    photoBrower.displayArrowButton = YES;
    photoBrower.displayActionButton = YES;
    return photoBrower;
}

@end
