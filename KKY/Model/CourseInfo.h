//
//  CourseInfo.h
//  KKY
//
//  Created by Jason on 2018/3/30.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseInfo : NSObject

@property (nonatomic,copy) NSString *icon; //图片
@property (nonatomic,copy) NSString *course; //课程编号
@property (nonatomic,copy) NSString *course_name; //课程名称
@property (nonatomic,copy) NSString *classroom; //班级编号
@property (nonatomic,copy) NSString *classroom_name; //班级名称
@property (nonatomic,copy) NSString *teachers; //教师s
@property (nonatomic,copy) NSString *yy_cnt; //预约成功人次

@end
