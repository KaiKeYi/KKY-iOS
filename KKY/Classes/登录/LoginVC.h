//
//  LoginVC.h
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "BaseVC.h"
#import "RegularView.h"

@interface LoginVC : BaseVC

@property (nonatomic,copy) dispatch_block_t buttonBlock;

@property (weak, nonatomic) IBOutlet RegularView *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

- (IBAction)selectStoreAction:(UIButton *)sender;
- (IBAction)loginAction:(UIButton *)sender;

@end
