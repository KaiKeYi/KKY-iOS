//
//  AppDelegate.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "BaseNC.h"
#import <IQKeyboardManager.h>
#import "NetworkUtil.h"
#import "AEFilePath.h"

@interface AppDelegate ()
{
    UITabBarController *myTabBarController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //键盘事件处理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    [[UserInfo share] getUserInfo];
    [AEFilePath createDirPath];
    [[NetworkUtil sharedInstance] listening]; //监测网络
    if ([Utils isUserLogin]) {
        //进入应用主界面
        self.window.rootViewController = [self setTabBarController];
    } else {
        BaseNC *nc = [[BaseNC alloc] initWithRootViewController:[self setLoginController]];
        self.window.rootViewController = nc;
    }

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    [self.window makeKeyAndVisible];

    return YES;
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
        self.window.rootViewController = [self setTabBarController];
    }];
    
    return loginVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
