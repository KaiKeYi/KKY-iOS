//
//  MineVC.h
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "BaseVC.h"

@interface MineVC : BaseVC

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *namePhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *otherInfoLab;
@property (weak, nonatomic) IBOutlet UIButton *shopLab;

- (IBAction)logoutAction:(id)sender;

@end
