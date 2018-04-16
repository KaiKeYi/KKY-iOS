//
//  MineVC.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "MineVC.h"
#import "BaseNC.h"
#import "LoginVC.h"

@interface MineVC ()

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的";
    
    self.headImgView.image = [UIImage imageNamed:@"head_img"];
    self.namePhoneLab.text = [NSString stringWithFormat:@"%@-%@",[UserInfo share].bbname,[UserInfo share].mobile];
    self.otherInfoLab.text = [NSString stringWithFormat:@"生日：%@ 性别：%@ 所在小区：%@",[UserInfo share].birthday,[UserInfo share].sex,[UserInfo share].dizhi];
    [self.shopBtn setTitle:[UserInfo share].shopname forState:UIControlStateNormal];
    
    if ([Utils isBlankString:[UserInfo share].shopphone]) {
        self.phoneView.hidden = YES;
        self.shopView.frame = CGRectMake(20, self.otherInfoLab.maxY+25, WIDTH-40, 44);
        self.exitBtn.frame = CGRectMake(80, self.shopView.maxY+36, WIDTH-160, 40);
    } else {
        [self.phoneView setBorderWithView:self.phoneView top:YES left:NO bottom:NO right:NO borderColor:LineColor borderWidth:1];
        [self.phoneBtn setTitle:[UserInfo share].shopphone forState:UIControlStateNormal];
        self.phoneBtn.imageView.contentMode = UIViewContentModeScaleToFill;;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//退出登录
- (IBAction)logoutAction:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"要退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [UserInfo share].token, @"token",
                             nil];
        [[NetworkManager sharedManager] postJSON:URL_Logout parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
            
            if (status == Request_Success) {
                
            } else {
                [Utils showToast:@"退出失败"];
            }
            
            [[UserInfo share] setUserInfo:nil]; //清除用户信息
            
            //跳转到登录页作为根视图
            BaseNC *nc = [[BaseNC alloc] initWithRootViewController:[self setLoginController]];
            [UIApplication sharedApplication].keyWindow.rootViewController = nc;
        }];
    }])];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - 主页

- (UITabBarController *)setTabBarController {
    
    //第一步：要获取单独控制器所在的UIStoryboard
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //第二步：获取该控制器的Identifier并赋给你的单独控制器
    UITabBarController *tabBarController = [story instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    return tabBarController;
}

#pragma mark - 登录页

- (UIViewController *)setLoginController {
    //第一步：要获取单独控制器所在的UIStoryboard
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //第二步：获取该控制器的Identifier并赋给你的单独控制器
    LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginController"];
    
    [loginVC setButtonBlock:^(){
        //进入应用主界面
        [UIApplication sharedApplication].keyWindow.rootViewController = [self setTabBarController];
    }];
    
    return loginVC;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
