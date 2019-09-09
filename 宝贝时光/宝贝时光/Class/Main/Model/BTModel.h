//
//  BTModel.h
//  宝贝时光
//
//  Created by yww on 2019/9/9.
//  Copyright © 2019 yww.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BTUrlModel : NSObject
@property(nonatomic,copy)NSString *full;
@property(nonatomic,copy)NSString *raw;
@property(nonatomic,copy)NSString *regular;
@property(nonatomic,copy)NSString *small;
@property(nonatomic,copy)NSString *thumb;
@end

@interface BTModel : NSObject
@property(nonatomic,copy)NSString *alt_description;
@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,copy)NSString *color;
@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,strong)NSArray *current_user_collections;
@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *width;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,assign)NSInteger liked_by_user;
@property(nonatomic,assign)NSInteger likes;
@property(nonatomic,copy)NSString *links;
@property(nonatomic,copy)NSString *updated_at;
@property(nonatomic,strong)BTUrlModel *urls;
@property(nonatomic,copy)NSString *user;
@end


NS_ASSUME_NONNULL_END
