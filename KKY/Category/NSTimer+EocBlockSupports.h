//
//  NSTimer+EocBlockSupports.h
//  KKY
//
//  Created by Jason on 2018/4/16.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (EocBlockSupports)

+ (NSTimer *)eocScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void(^)()) block repeats:(BOOL)repeat;

@end
