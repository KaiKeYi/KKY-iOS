//
//  AppointmentVC.h
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "BaseVC.h"

@interface AppointmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *courseLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@interface AppointmentVC : BaseVC

@property (weak, nonatomic) IBOutlet UITableView *appointTableView;

@end
