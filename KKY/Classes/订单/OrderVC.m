//
//  OrderVC.m
//  KKY
//
//  Created by Jason on 2018/3/29.
//  Copyright © 2018年 hzb. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"
#import <MJRefresh.h>

@interface OrderVC ()<RefreshDelegate>
{
    NSMutableArray *_dataArr;
    NSInteger _currentPage;
}

@property (nonatomic,retain) DefaultView *defaultView; //默认视图

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单";
    
    _dataArr = [NSMutableArray array];
    _currentPage = 1;
    
    [self blankView];
    [self getData:_currentPage];
    
    //动画下拉刷新
    [self tableView:_orderTableView gifHeaderWithRefreshingBlock:^{
        [self refreshData];
    }];
    
    //动画加载更多
    [self tableView:_orderTableView gifFooterWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

//刷新数据
- (void)refreshData {
    _currentPage = 1;
    [self getData:_currentPage];
}

//加载更多数据
- (void)loadMoreData {
    _currentPage++;
    [self getData:_currentPage];
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
    [self refreshData];
}

- (void)getData:(NSInteger)currPage {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%ld",(long)currPage], @"page",
                         [UserInfo share].token, @"token",
                         [UserInfo share].dealerno, @"dealerno",
                         nil];
    [[NetworkManager sharedManager] postJSON:URL_OrderList parameters:dic imageDataArr:nil imageName:nil completion:^(id responseData, RequestState status, NSError *error) {
        
        [self.orderTableView.mj_header endRefreshing];
        [self.orderTableView.mj_footer endRefreshing];
        
        if (status == Request_Success) {
            
            if (currPage == 1) {
                [_dataArr removeAllObjects];
            }

            NSMutableArray *array = [OrderInfo mj_objectArrayWithKeyValuesArray:(NSArray *)responseData];
            [_dataArr addObjectsFromArray:array];
            
            if (_dataArr.count>0) {
            
                if (array.count>0) {
                    [self tableView:_orderTableView gifFooterWithRefreshingBlock:^{
                        [self loadMoreData];
                    }];
                } else {
                    _orderTableView.mj_footer = nil;
                }
                
                _orderTableView.hidden = NO;
                _defaultView.hidden = YES;
                [_orderTableView reloadData];
                
            } else {
                _orderTableView.hidden = YES;
                _defaultView.hidden = NO;
                _defaultView.delegate = nil;
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
