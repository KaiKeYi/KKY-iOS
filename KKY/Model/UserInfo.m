//
//  UserInfo.m
//  ArtEast
//
//  Created by yibao on 16/9/30.
//  Copyright © 2016年 北京艺宝网络文化有限公司. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *_userInfo = nil;
static NSUserDefaults *_defaults = nil;

@implementation UserInfo

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[UserInfo alloc] init];
        _defaults = [NSUserDefaults standardUserDefaults];
    });
    return _userInfo;
}

- (NSDictionary *)getUserInfo {
    
    NSDictionary *userDic = [_defaults objectForKey:@"UserInfo"];
    
    NSLog(@"%@",userDic);
    if (userDic) {
        [self loadUserDic:userDic];
    }
    
    return userDic;
}

- (void)setUserInfo:(NSDictionary *)userDic {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userDic forKey:@"UserInfo"];
    [defaults synchronize];
    
    [self loadUserDic:userDic];
}

- (void)loadUserDic:(NSDictionary *)userDic {
    
    self.cid = userDic[@"cid"];
    self.mobile = userDic[@"mobile"];
    self.password = userDic[@"password"];
    self.vip = userDic[@"vip"];
    self.jinzhan = userDic[@"jinzhan"];
    self.bbname = userDic[@"bbname"];
    self.parent = userDic[@"parent"];
    self.dizhi = userDic[@"dizhi"];
    
    self.nickname = userDic[@"nickname"];
    self.birthday = userDic[@"birthday"];
    self.sex = userDic[@"sex"];
    self.baby_number = userDic[@"baby_number"];
    
    self.shopname = userDic[@"shopname"];
    self.shopphone = userDic[@"shopphone"];
    self.shopaddress = userDic[@"shopaddress"];
    self.token = userDic[@"token"];
    self.dealerno = userDic[@"dealerno"];
}

@end
