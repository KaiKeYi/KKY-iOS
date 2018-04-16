//
//  UIView+ZBExtension.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * IB_DESIGNABLE：让你的自定义 UIView 可以在 IB 中预览。
 * IBInspectable：让你的自定义 UIView 的属性出现在 IB 中 Attributes inspector。
 */

IB_DESIGNABLE
@interface UIView (ZBExtension)

//扩展frame属性
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

//扩展layer属性
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;

/**
 * 显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/**
 * UIView动画样式
 */
- (void)setShowAnimationWithStyle:(AShowAnimationStyle)animationStyle;

/**
 * 单独显示某一侧的边框线
 */
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@end
