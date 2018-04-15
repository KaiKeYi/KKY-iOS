//
//  ServerUrl.h
//  ArtEast
//
//  Created by yibao on 16/9/30.
//  Copyright © 2016年 北京艺宝网络文化有限公司. All rights reserved.
//

#ifndef ServerUrl_h
#define ServerUrl_h

#pragma mark - ---------------接口地址---------------

#define ProductUrl @"https://yy.kaikeyi.cn/api/"
#define WebUrl @"http://www.cydf.com/"
#define PictureUrl @"https://yy.kaikeyi.cn/Public/images/"


#pragma mark - ---------------接口名称---------------

#define URL_Login @"public/login.json" //登录
#define URL_Logout @"public/logout.json" //退出登录
#define URL_ShopList @"dealer/list.json" //店铺列表
#define URL_CourseList @"course/list.json" //课程列表
#define URL_OrderList @"yuyue/my.json" //订单列表
#define URL_OrderAdd @"yuyue/add.json" //预约报名
#define URL_AvaliableDateList @"course/avaliableDate.json" //日期列表
#define URL_AvaliableTimeList @"course/avaliableTime.json" //时间列表
#define URL_AvaliableTeachersList @"course/avaliableTeachers.json" //教师列表
#define URL_UploadAvatar @"user.php?m=uploadAvatar" //上传头像

#endif /* ServerUrl_h */
