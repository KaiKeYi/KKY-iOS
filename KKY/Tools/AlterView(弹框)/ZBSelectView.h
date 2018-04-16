//
//  ZBSelectView.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBSelectView : UIView

typedef void(^DoneBlock)(NSInteger index);

@property (nonatomic,copy) DoneBlock doneBlock;
@property (nonatomic,copy) dispatch_block_t dismissBlock; //点击背景视图会触发该消失的block

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSMutableArray *contentArr;
@property (nonatomic,retain) UIView *baseView;

@property (nonatomic,assign)AShowAnimationStyle animationStyle;

/**
 *  构造方法
 *
 *  @param title      标题
 *  @param contentArr    内容
 *  @param bView      self.view
 *
 *  @return id
 */
- (id)initWithTitle:(NSString *)title
        contentText:(NSMutableArray *)contentArr
           baseView:(UIView *)bView;

@end
