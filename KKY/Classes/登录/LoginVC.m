//
//  LoginVC.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "LoginVC.h"
#import "ShopInfo.h"
#import "HZBPickerView.h"

@interface LoginVC ()
{
    ShopInfo *_shopInfo;
    NSMutableArray *_dataArr;
    NSMutableArray *_pickerArr; //选择数据源
    NSString *_dealerno; //门店编号
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _dataArr = [NSMutableArray array];
    _pickerArr = [NSMutableArray array];
    
    [self getShopData];
    
//    手机号：13121811508
//    密码：811508
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    _accountTF.text = [defaults objectForKey:@"UserAccount"];
//    _pswTF.text = [defaults objectForKey:@"UserPsw"];
}

//获取门店数据
- (void)getShopData {
    NSDictionary *dic = [NSDictionary dictionary];
    [[NetworkManager sharedManager] postJSON:URL_ShopList parameters:dic completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _dataArr = [ShopInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            
            for (int i = 0; i<_dataArr.count; i++) {
                ShopInfo *info = _dataArr[i];
                [_pickerArr addObject:info.shopname];
                
                if (i==0) {
                    [_shopBtn setTitle:info.shopname forState:UIControlStateNormal];
                    _dealerno = info.dealerno;
                }
            }
        }
    }];
}

- (IBAction)selectStoreAction:(UIButton *)sender {

    HZBPickerView *pickerView = [[HZBPickerView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) andDataSource:_pickerArr baseView:self.view];
    pickerView.cancelBlock = ^()
    {
        NSLog(@"取消");
    };
    pickerView.doneBlock = ^(NSString *dataStr,NSInteger index) {
        [_shopBtn setTitle:dataStr forState:UIControlStateNormal];
        ShopInfo *info = _dataArr[index];
        _dealerno = info.dealerno;
    };
    [pickerView show];
}

- (IBAction)loginAction:(UIButton *)sender {

    if ([Utils isBlankString:_accountTF.text]) {
        [Utils showToast:@"请输入手机号码"];
        return;
    }
    
    if ([Utils isBlankString:_pswTF.text]) {
        [Utils showToast:@"请输入密码"];
        return;
    }
    
    if ([Utils isBlankString:_dealerno]) {
        [Utils showToast:@"请选择门店"];
        return;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _accountTF.text, @"mobile",
                         _pswTF.text, @"password",
                         _dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_Login parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            [Utils showToast:@"登录成功"];
            
            NSMutableDictionary *dic = [(NSDictionary *)responseData mutableCopy];
            [dic setObject:_dealerno forKey:@"dealerno"];
            [[UserInfo share] setUserInfo:dic];
            [[NSUserDefaults standardUserDefaults] setObject:_accountTF.text forKey:@"UserAccount"];
            [[NSUserDefaults standardUserDefaults] setObject:_pswTF.text forKey:@"UserPsw"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccNotification object:nil];
            
            if (self.buttonBlock) {
                self.buttonBlock();
            }
        } else {
            [Utils showToast:@"登录失败"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
