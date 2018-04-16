//
//  ZBSelectView.m
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "ZBSelectView.h"

@interface ZBSelectView () {
    UIView *bgView; //弹框背景视图
}
@end

@implementation ZBSelectView

- (id)initWithTitle:(NSString *)title
        contentText:(NSMutableArray *)contentArr
           baseView:(UIView *)bView {
    
    CGRect frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        
        self.title = title;
        self.contentArr = contentArr;
        self.baseView = bView;
        
        [self.baseView addSubview:self];
        [self initView]; //初始化视图
        
        //点击背景视图页面消失
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - 初始化视图
- (void)initView {
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-40, 0)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [bgView.layer setMasksToBounds:YES];
    [self.baseView addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgView.width, 40)];
    titleLab.text = self.title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = BlackColor;
    titleLab.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:titleLab];
    
    [titleLab setBorderWithView:titleLab top:NO left:NO bottom:YES right:NO borderColor:LineColor borderWidth:1];
    
    if (_contentArr.count==0) {
        bgView.frame = CGRectMake(0, 0, WIDTH-40, 60);
    } else {
        CGFloat itemTimeWidth = bgView.width/2;
        CGFloat itemTimeHeight = 50;
        for (int i = 0; i<_contentArr.count; i++) {
            
            UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*itemTimeWidth, 45+(i/2)*itemTimeHeight, itemTimeWidth, itemTimeHeight)];
            [bgView addSubview:itemView];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, itemTimeWidth-20, itemTimeHeight-10)];
            btn.layer.cornerRadius = 5;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = BorderGrayColor.CGColor;
            [btn setTitle:_contentArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:BlackColor forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100+i;
            [itemView addSubview:btn];
            
            if (i == _contentArr.count-1) {
                bgView.frame = CGRectMake(0, 0, WIDTH-40, 60+(i/2+1)*itemTimeHeight);
            }
        }
    }
    
    bgView.center = self.center;
}



#pragma mark - 确定点击
- (void)doneAction:(UIButton *)btn {
    
    NSInteger index = btn.tag-100;
    if (self.doneBlock) {
        self.doneBlock(index);
    }
    
    [self dismissAlert];
}

#pragma mark - 页面消失
- (void)dismissAlert
{
    [self removeFromSuperview];
    bgView.hidden = YES;
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

#pragma mark - 设置弹框动画效果
-(void)setAnimationStyle:(AShowAnimationStyle)animationStyle{
    [bgView setShowAnimationWithStyle:animationStyle];
}

@end
