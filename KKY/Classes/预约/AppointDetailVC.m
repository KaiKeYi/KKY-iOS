//
//  AppointDetailVC.m
//  KKY
//
//  Created by Jason on 2018/4/7.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "AppointDetailVC.h"
#import "OptionBarController.h"
#import "DateInfo.h"
#import "TimeInfo.h"

@interface AppointDetailVC ()
{
    NSMutableArray *_dateArr;
    NSMutableArray *_timeArr;
    DateInfo *_selectDateInfo;
    TimeInfo *_selectTimeInfo;
    CGFloat itemDateWidth;
    NSInteger lastIndex;
    UIView *lineView;
}
@end

@implementation AppointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约详情";
    itemDateWidth = self.dateScrollView.width/5;

    _dateArr = [NSMutableArray array];
    _timeArr = [NSMutableArray array];
    self.scrollView.frame = CGRectMake(0, kNavBarH, WIDTH, HEIGHT-kNavBarH);
    
    [self getDateList];
    
    [self initData];
}

- (void)initData {
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_info.icon] placeholderImage:[UIImage imageNamed:@"app_icon"]];
    _courseLab.text = [NSString stringWithFormat:@"%@-%@",_info.course_name,_info.classroom_name];
    _teacherLab.text = [NSString stringWithFormat:@"老师：%@",_info.teachers];
    _countLab.text = [NSString stringWithFormat:@"预约成功：%@人次",_info.yy_cnt];
}

#pragma mark - get data

//获取日期列表
- (void)getDateList {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.info.course, @"course",
                         self.info.classroom, @"classroom",
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_AvaliableDateList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _dateArr = [DateInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            _dateCountLab.text = [NSString stringWithFormat:@"仅显示%lu天内的预约信息",(unsigned long)_dateArr.count];
            self.dateScrollView.contentSize = CGSizeMake(itemDateWidth*_dateArr.count, 50);
            
            for (int i = 0; i<_dateArr.count; i++) {
                DateInfo *info = _dateArr[i];
                UIButton *dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemDateWidth*i, 0, itemDateWidth, 45)];
                dateBtn.tag = 1000+i;
                [dateBtn setTitle:[NSString stringWithFormat:@"%@\n%@",info.week_name,info.date_name] forState:UIControlStateNormal];
                [dateBtn setTitleColor:BlackColor forState:UIControlStateNormal];
                dateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
                dateBtn.titleLabel.numberOfLines=0;
                dateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                [dateBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
                [self.dateScrollView addSubview:dateBtn];
                
                
                if (i==0) {
                    [dateBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    _selectDateInfo = info;
                    [self getTimeList]; //获取时间列表
                    lineView = [[UIView alloc] initWithFrame:CGRectMake(dateBtn.x, 45, itemDateWidth, 1)];
                    lineView.backgroundColor = BlueColor;
                    [self.dateScrollView addSubview:lineView];
                }
            }
        }
    }];
}

//获取时间列表
- (void)getTimeList {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.info.course, @"course",
                         self.info.classroom, @"classroom",
                         _selectDateInfo.date, @"date",
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_AvaliableTimeList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _timeArr = [TimeInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            
            //移除所有子视图
            [self.timeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            if (_timeArr.count==0) {
                self.courseView.frame = CGRectMake(10, 155, WIDTH-20, 80);
            } else {
                CGFloat itemTimeWidth = self.dateScrollView.width/2;
                CGFloat itemTimeHeight = 50;
                for (int i = 0; i<_timeArr.count; i++) {
                    
                    TimeInfo *info = _timeArr[i];
                    
                    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*itemTimeWidth, (i/2)*itemTimeHeight, itemTimeWidth, itemTimeHeight)];
                    [self.timeView addSubview:bgView];
                    
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, itemTimeWidth-20, itemTimeHeight-10)];
                    btn.layer.cornerRadius = 5;
                    btn.layer.borderWidth = 1;
                    btn.layer.borderColor = BorderGrayColor.CGColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@ 请选择",info.time_start] forState:UIControlStateNormal];
                    [btn setTitleColor:BlackColor forState:UIControlStateNormal];
                    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                    btn.titleLabel.font = [UIFont systemFontOfSize:12];
                    [btn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 10000+i;
                    [bgView addSubview:btn];

                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(itemTimeWidth-42, 18, 32, 32)];
                    imgView.tag = 20000+i;
                    imgView.hidden = YES;
                    imgView.image = [UIImage imageNamed:@"select"];
                    [bgView addSubview:imgView];
                    
                    if (i == _timeArr.count-1) {
                        self.timeView.frame = CGRectMake(0, 61, WIDTH-20, (i/2+1)*itemTimeHeight);
                        self.courseView.frame = CGRectMake(10, 155, WIDTH-20, 80+(i/2+1)*itemTimeHeight);
                        self.scrollView.contentSize = CGSizeMake(WIDTH, 155+self.courseView.height+55);
                    }
                }
            }
        }
    }];
}

#pragma mark - methods

//选择日期
- (void)selectDate:(UIButton *)btn {
    NSInteger index = btn.tag-1000;
    for (int i = 0; i<_dateArr.count; i++) {
        UIButton *btn = [self.view viewWithTag:1000+i];
        if (i==index) {
            [btn setTitleColor:BlueColor forState:UIControlStateNormal];
            _selectDateInfo = _dateArr[index];
            [self getTimeList]; //获取时间列表
        } else {
            [btn setTitleColor:BlackColor forState:UIControlStateNormal];
        }
    }
    
    NSInteger count = btn.tag-lastIndex;
    lastIndex = btn.tag;

    CGFloat offX = _dateScrollView.contentSize.width-_dateScrollView.width;
    if (count>0) {
        [_dateScrollView setContentOffset:CGPointMake(MIN(offX, _dateScrollView.contentOffset.x+itemDateWidth), 0) animated:YES];
    }
    if (count<0) {
          [_dateScrollView setContentOffset:CGPointMake(MAX(MIN(offX, btn.x-itemDateWidth), 0), 0) animated:YES];
    }
    [UIView animateWithDuration:0.3 animations:^{
        lineView.centerX = btn.centerX;
    }];
}

//选择时间
- (void)selectTime:(UIButton *)btn {
    NSInteger index = btn.tag-10000;
    for (int i = 0; i<_timeArr.count; i++) {
        UIButton *btn = [self.view viewWithTag:10000+i];
        UIImageView *imgView = [self.view viewWithTag:20000+i];
        if (i==index) {
            imgView.hidden = NO;
            btn.layer.borderColor = GreenColor.CGColor;
        } else {
            imgView.hidden = YES;
            btn.layer.borderColor = BorderGrayColor.CGColor;
        }
    }
}

#pragma mark - methods

//立即预约
- (IBAction)orderAction:(id)sender {
    
}

//清空
- (IBAction)clearAction:(id)sender {
    
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
