//
//  BaseScrollView.m
//  KKY
//
//  Created by Jason on 2018/4/15.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    [super touchesShouldCancelInContentView:view];
    //NO UIScrollView不可以滚动, YES UIScrollView可以滚动
    return YES;
}

@end
