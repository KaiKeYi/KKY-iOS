//
//  UIColor+ZBExtension.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZBExtension)

+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (UIColor *) colorWithHexString:(NSString *)color;
+ (UIColor *) colorWithHexString:(NSString *)color alpha:(float)alpha;
+ (UIColor *) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

@end
