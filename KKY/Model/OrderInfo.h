//
//  OrderInfo.h
//  KKY
//
//  Created by Jason on 2018/4/6.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject

@property (nonatomic,copy) NSString *tid;
@property (nonatomic,copy) NSString *course; //课程编号
@property (nonatomic,copy) NSString *course_name; //课程名称
@property (nonatomic,copy) NSString *classroom; //班级编号
@property (nonatomic,copy) NSString *classroom_name; //班级名称
@property (nonatomic,copy) NSString *teacher; //教师
@property (nonatomic,copy) NSString *icon; //课程图片https://yy.kaikeyi.cn/Public/images/course/1.png
@property (nonatomic,copy) NSString *day; //2018-04-02
@property (nonatomic,copy) NSString *time_start; //10:30
@property (nonatomic,copy) NSString *day_name; //4月2日
@property (nonatomic,copy) NSString *status; //预约中
@property (nonatomic,copy) NSString *week; //周一
@property (nonatomic,copy) NSString *usetime;
@property (nonatomic,copy) NSString *updatetime;

@end
