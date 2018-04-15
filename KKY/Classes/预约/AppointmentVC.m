//
//  AppointmentVC.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "AppointmentVC.h"
#import "CourseInfo.h"
#import "AppointDetailVC.h"

@implementation AppointmentCell

@end

@interface AppointmentVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr; //列表数组
}
@end

@implementation AppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约";
    
    _dataArr = [NSMutableArray array];
    
    self.appointTableView.tableFooterView = [UIView new];
    
    [self getData];
}

- (void)getData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_CourseList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _dataArr = [CourseInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            
            [self.appointTableView reloadData];
        }
    }];
}

#pragma mark - UITableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppointCell"];
    
    CourseInfo *info = _dataArr[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:[UIImage imageNamed:@"app_icon"]];
    cell.courseLab.text = [NSString stringWithFormat:@"%@-%@",info.course_name,info.classroom_name];
    cell.teacherLab.text = [NSString stringWithFormat:@"老师：%@",info.teachers];
    cell.countLab.text = [NSString stringWithFormat:@"预约成功：%@人次",info.yy_cnt];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //取消选择状态
    
    CourseInfo *info = _dataArr[indexPath.row];
    AppointDetailVC *vc = (AppointDetailVC *)[Utils GetStordyVC:@"Main" WithStordyID:@"AppointDetailVC"];
    vc.info = info;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
