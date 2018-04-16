//
//  UITabBar+ZBExtension.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (ZBExtension)

/**
 * 显示小红点附带数字
 */
- (void)showBadgeOnItemIndex:(NSInteger)index andCount:(NSString *)count;

/**
 * 显示小红点
 */
- (void)showBadgeOnItemIndex:(NSInteger)index;

/**
 * 隐藏小红点
 */
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end
