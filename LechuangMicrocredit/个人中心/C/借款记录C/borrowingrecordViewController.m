//
//  borrowingrecordViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "borrowingrecordViewController.h"
#import "borrowCell.h"
#import "helpViewController.h"
#import "BorrowModel.h"
#import "placeholderView.h"
@interface borrowingrecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *borrowtableview;
@property (nonatomic,strong) BorrowModel *borrowmodel;
@property (nonatomic,strong) NSMutableArray *borrowArray;
@property (nonatomic,strong) placeholderView *placeView;
@end
static NSString *borrowcell = @"borrowcell";
@implementation borrowingrecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"帮助" title:@"借款记录"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        NSLog(@"帮助");
        helpViewController *helpVC = [[helpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
    };
    self.borrowArray = [NSMutableArray array];
    [self loaddatafromweb];
   // [self refresh];
    [self.view addSubview:self.borrowtableview];
    self.borrowtableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.placeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    self.borrowtableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.placeView.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}

-(void)refresh
{
    self.borrowtableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.borrowtableview.mj_header endRefreshing];
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.borrowtableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loaddatafromweb)];
    
    // 马上进入刷新状态
    [self.borrowtableview.mj_header beginRefreshing];
}

-(void)loaddatafromweb
{
    
    [AFManager getReqURL:[NSString stringWithFormat:historyborr,UID] block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            NSArray *dit = [infor objectForKey:@"data"];
            if (dit==nil||dit==NULL) {
                [self.placeView setHidden:NO];
            }else
            {
                for (int i = 0; i<dit.count; i++) {
                    NSDictionary *dicarr = [dit objectAtIndex:i];
                    self.borrowmodel = [[BorrowModel alloc] init];
                    self.borrowmodel.timestr = dicarr[@"time"];
                    self.borrowmodel.amountstr = dicarr[@"amount"];
                    [self.borrowArray addObject:self.borrowmodel];
                }
                [self.placeView setHidden:YES];
                [self.borrowtableview reloadData];
            }
            [self.borrowtableview.mj_header endRefreshing];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"没有借款记录"];
            [self.borrowtableview.mj_header endRefreshing];
        }
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark - getters

-(UITableView *)borrowtableview
{
    if(!_borrowtableview)
    {
        _borrowtableview = [[UITableView alloc] init];
        _borrowtableview.dataSource = self;
        _borrowtableview.delegate = self;
    }
    return _borrowtableview;
}

-(placeholderView *)placeView
{
    if(!_placeView)
    {
        _placeView = [[placeholderView alloc] init];
        
    }
    return _placeView;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.borrowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    borrowCell *cell = [[borrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:borrowcell];
    if (!cell) {
        cell = [[borrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:borrowcell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setcelldata:self.borrowArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90/2*HEIGHT_SCALE;
}


@end
