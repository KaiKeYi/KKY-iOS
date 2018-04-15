//
//  UserInfo.h
//  ArtEast
//
//  Created by yibao on 16/9/30.
//  Copyright © 2016年 北京艺宝网络文化有限公司. All rights reserved.
//

/**
 *  用户Modle
 *
 */

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic,copy) NSString *cid; //课程ID
@property (nonatomic,copy) NSString *mobile; //手机号
@property (nonatomic,copy) NSString *password; //密码
@property (nonatomic,copy) NSString *vip; //VIP号
@property (nonatomic,copy) NSString *jinzhan; //状态(已办卡)
@property (nonatomic,copy) NSString *bbname; //宋梦婷
@property (nonatomic,copy) NSString *parent; //宋梦婷
@property (nonatomic,copy) NSString *dizhi; //地址

@property (nonatomic,copy) NSString *nickname; //昵称
@property (nonatomic,copy) NSString *birthday; //生日
@property (nonatomic,copy) NSString *sex; //性别
@property (nonatomic,copy) NSString *baby_number; //宝宝编号5

@property (nonatomic,copy) NSString *shopname; //店铺名称
@property (nonatomic,copy) NSString *shopphone; //店铺手机号
@property (nonatomic,copy) NSString *shopaddress; //店铺地址
@property (nonatomic,copy) NSString *token; //token
@property (nonatomic,copy) NSString *dealerno; //店铺编号

+ (UserInfo *)share;

- (NSDictionary *)getUserInfo;

- (void)setUserInfo:(NSDictionary *)userDic;

@end
