//
//  OrderVC.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"

@interface OrderVC ()<RefreshDelegate>
{
    NSMutableArray *_dataArr;
}

@property (nonatomic,retain) DefaultView *defaultView; //默认视图

@end

@implementation OrderVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self blankView];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单";
    
    _dataArr = [NSMutableArray array];
}

//无订单
- (void)blankView {
    _defaultView = [[DefaultView alloc] initWithFrame:CGRectMake(0, kNavBarH, WIDTH, HEIGHT-kNavBarH-kTabBarH)];
    _defaultView.delegate = self;
    _defaultView.hidden = YES;
    [self.view addSubview:_defaultView];
}

#pragma mark - RefreshDelegate

- (void)refresh {
    _defaultView.hidden = YES;
    [self getData];
}

- (void)getData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"1", @"page",
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_OrderList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        if (status == Request_Success) {
            
            _dataArr = [OrderInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            
            if (_dataArr.count>0) {
                _defaultView.hidden = YES;
                [_orderTableView reloadData];
            } else {
                _defaultView.hidden = NO;
                _defaultView.imgView.image = [UIImage imageNamed:@"null-page-draw"];
                _defaultView.lab.text = @"您还没有订单";
            }
        }
    }];
}

#pragma mark - UITableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"OrderCell";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:nil options:nil] firstObject];
    }
    
    OrderInfo *info = _dataArr[indexPath.row];
    
    cell.info = info;
    
    return cell;
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
