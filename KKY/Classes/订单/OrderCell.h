//
//  OrderCell.h
//  KKY
//
//  Created by Jason on 2018/4/6.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *orderImgView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (nonatomic,retain) OrderInfo *info;

@end
