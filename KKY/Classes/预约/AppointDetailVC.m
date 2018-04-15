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

@interface AppointDetailVC ()
{
    NSMutableArray *_controllersArr;
    NSMutableArray *_categoryArr;
    DateInfo *_selectDateInfo;
}
@end

@implementation AppointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约详情";
    
    _controllersArr = [NSMutableArray array];
    _categoryArr = [NSMutableArray array];
    
    [self getData];
    
    [self initData];
}

- (void)initData {
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_info.icon] placeholderImage:[UIImage imageNamed:@"app_icon"]];
    _courseLab.text = [NSString stringWithFormat:@"%@-%@",_info.course_name,_info.classroom_name];
    _teacherLab.text = [NSString stringWithFormat:@"老师：%@",_info.teachers];
    _countLab.text = [NSString stringWithFormat:@"预约成功：%@人次",_info.yy_cnt];
}

#pragma mark - get data

- (void)getData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.info.course, @"course",
                         self.info.classroom, @"classroom",
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_AvaliableDateList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _categoryArr = [DateInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            _dateCountLab.text = [NSString stringWithFormat:@"仅显示%lu天内的预约信息",(unsigned long)_categoryArr.count];
            CGFloat itemWidth =self.dateScrollView.width/5;
            self.dateScrollView.contentSize = CGSizeMake(itemWidth*_categoryArr.count, 50);
            
            for (int i = 0; i<_categoryArr.count; i++) {
                DateInfo *info = _categoryArr[i];
                UIButton *dateBtn = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth*i, 0, itemWidth, 45)];
                dateBtn.tag = 1000+i;
                [dateBtn setTitle:[NSString stringWithFormat:@"%@\n%@",info.week_name,info.date_name] forState:UIControlStateNormal];
                [dateBtn setTitleColor:BlackColor forState:UIControlStateNormal];
                dateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
                dateBtn.titleLabel.numberOfLines=0;
                dateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                [dateBtn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
                [self.dateScrollView addSubview:dateBtn];
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(dateBtn.x, 45, itemWidth, 1)];
                lineView.tag = 2000+i;
                lineView.backgroundColor = GreenColor;
                [self.dateScrollView addSubview:lineView];
                
                if (i==0) {
                    _selectDateInfo = info;
                    [dateBtn setTitleColor:GreenColor forState:UIControlStateNormal];
                    lineView.hidden = NO;
                } else {
                    lineView.hidden = YES;
                }
            }
        }
    }];
}

#pragma mark - methods

- (void)selectDate:(UIButton *)btn {
    NSInteger index = btn.tag-1000;
    for (int i = 0; i<_categoryArr.count; i++) {
        UIButton *btn = [self.view viewWithTag:1000+i];
        UIView *lineView = [self.view viewWithTag:2000+i];
        if (i==index) {
            lineView.hidden = NO;
            [btn setTitleColor:GreenColor forState:UIControlStateNormal];
        } else {
            lineView.hidden = YES;
            [btn setTitleColor:BlackColor forState:UIControlStateNormal];
        }
    }
    
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
