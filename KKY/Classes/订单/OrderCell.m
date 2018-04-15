//
//  OrderCell.m
//  KKY
//
//  Created by Jason on 2018/4/6.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

-(void)setInfo:(OrderInfo *)info {
    
    if (_info!=info) {
        _info = info;
    }
    
    [_orderImgView sd_setImageWithURL:[NSURL URLWithString:_info.icon] placeholderImage:[UIImage imageNamed:@"app_icon"]];
    _courseNameLab.text = [NSString stringWithFormat:@"%@-%@",_info.course_name,_info.classroom_name];
    _teacherLab.text = [NSString stringWithFormat:@"老师：%@",_info.teacher];
    _timeLab.text = [NSString stringWithFormat:@"%@ %@ %@",_info.day_name,_info.week,_info.time_start];
    _statusLab.text = _info.status;
    
    if ([_info.status isEqualToString:@"已撤销"]) {
        _timeLab.textColor = BlackColor;
        _statusLab.textColor = BlackColor;
        _statusView.backgroundColor = Status_GrayColor;
    } else {
        _timeLab.textColor = WhiteColor;
        _statusLab.textColor = WhiteColor;
        
        if ([_info.status isEqualToString:@"已消费"]) {
            _statusView.backgroundColor = Status_GreenColor;
        }
        if ([_info.status isEqualToString:@"预约中"]) {
            _statusView.backgroundColor = Status_OrangeColor;
        }
        if ([_info.status isEqualToString:@"未消费"]) {
            _statusView.backgroundColor = Status_BlueColor;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
