//
//  AppointDetailVC.h
//  KKY
//
//  Created by Jason on 2018/4/7.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "BaseVC.h"
#import "CourseInfo.h"
#import "BaseScrollView.h"

@interface AppointDetailVC : BaseVC

@property (nonatomic,retain) CourseInfo *info;

@property (weak, nonatomic) IBOutlet BaseScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *courseLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *dateCountLab;
@property (weak, nonatomic) IBOutlet UIView *courseView;
@property (weak, nonatomic) IBOutlet BaseScrollView *dateScrollView;
@property (weak, nonatomic) IBOutlet UIView *dividerView;
@property (weak, nonatomic) IBOutlet UIView *timeView;

- (IBAction)orderAction:(id)sender;
- (IBAction)clearAction:(id)sender;

@end
