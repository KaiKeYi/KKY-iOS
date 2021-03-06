//
//  UIImage+ZBExtension.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZBExtension)

/**
 * 颜色转换成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 颜色渐变
 */
+ (UIImage *)gradientFromColor:(UIColor *)c1 toColor:(UIColor *)c2 withHeight:(int)height;

/**
 * 纠正图片的方向
 */
- (UIImage *)fixOrientation;

/**
 * 按给定的方向旋转图片
 */
- (UIImage*)rotate:(UIImageOrientation)orient;

/**
 * 垂直翻转
 */
- (UIImage *)flipVertical;

/**
 * 水平翻转
 */
- (UIImage *)flipHorizontal;

/**
 * 将图片旋转degrees角度
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 * 将图片旋转radians弧度
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 * UIImage缩放到固定的尺寸，新图片通过返回值返回
 */
- (UIImage *)imageScaledToSize:(CGSize)newSize;

/**
 * UIImage按比例将宽度高度差异小的一方缩放到指定的大小，然后截取另一方，使其跟newSize一样大
 */
- (UIImage *)imageScaledInterceptToSize:(CGSize)newSize withNeed2x:(BOOL)need2x;

/**
 * UIImage缩放到固定的尺寸，高度宽度按照大的一边算
 */
- (UIImage *)imageScaledToBigFixedSize:(CGSize)newSize;

/**
 * UIImage尺寸不足添黑边处理
 */
- (UIImage *)imageBlackBackGroundToSize:(CGSize)newSize;

/**
 * UIImage图案填充到指定size
 */
- (UIImage *)imageFillToSize:(CGSize)newSize;

/**
 * UIImage左右两点拉伸
 */
- (UIImage *)imageStretchToSize:(CGSize)newSize withX1:(float)x1 withX2:(float)x2 y:(float)y;

@end
