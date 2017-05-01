//
//  RepaymentMoneyViewController.m
//  LechuangMicrocredit
//
//  Created by 张婷 on 16/12/5.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "RepaymentMoneyViewController.h"
#import "repaymentCell.h"
#import "repaymentCell2.h"
#import "repayView.h"
#import "repayModel.h"
#import "helpViewController.h"
#import "WechatViewController.h"
#import "PaytreasureViewController.h"
@interface RepaymentMoneyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *repaymenttableview;
@property (nonatomic,strong) UITableView *repaysettableview;
@property (nonatomic,strong) repayView *repayview;

@property (nonatomic,strong) NSString *notify_url;
@property (nonatomic,strong) NSString *moneystr;

@property (nonatomic,strong) NSMutableArray *repayarray;
@property (nonatomic,strong) repayModel *repaymodel;
@end
static NSString *repayident1 = @"repayident1";
static NSString *repayident2 = @"repayident2";
@implementation RepaymentMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"帮助" title:@"还款"];
    
    customNavView.CustomNavRightBtnClickBlock = ^{
        NSLog(@"帮助");
        helpViewController *helpVC = [[helpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
    };
    [self.view addSubview:customNavView];
    self.repayarray = [NSMutableArray array];
    [self.view addSubview:self.repaymenttableview];
     //[self refresh];
    [self loaddatafromweb];
    [self.view addSubview:self.repaysettableview];
    [self.view addSubview:self.repayview];
    self.repaymenttableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    self.repaymenttableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT/2-64);
    self.repaysettableview.frame = CGRectMake(0, DEVICE_HEIGHT/2, DEVICE_WIDTH, DEVICE_HEIGHT/2-55);
    self.repayview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT/2-64);
}

-(void)refresh
{
    self.repaymenttableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.repaymenttableview.mj_header endRefreshing];
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.repaymenttableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loaddatafromweb)];
    
    // 马上进入刷新状态
    [self.repaymenttableview.mj_header beginRefreshing];
}

-(void)loaddatafromweb
{
   [AFManager getReqURL:[NSString stringWithFormat:refundList,UID] block:^(id infor) {
       NSLog(@"info==%@",infor);
       if ([[infor objectForKey:@"code"]integerValue]==200)
       {
           NSArray *dit = [infor objectForKey:@"data"];
           if (dit==nil||dit==NULL)
           {
               [self.repayview setHidden:NO];
           }
           else
           {
               for (int i = 0; i<dit.count; i++)
               {
                   NSDictionary *dicarr = [dit objectAtIndex:i];
                   self.repaymodel = [[repayModel alloc] init];
                   self.repaymodel.timestr = dicarr[@"addtime"];
                   self.repaymodel.money = dicarr[@"money"];
                   [self.repayarray addObject:self.repaymodel];
               }
               NSLog(@"array=======%@",self.repayarray);
               [self.repayview setHidden:YES];
               [self.repaymenttableview.mj_header endRefreshing];
               [self.repaymenttableview reloadData];
           }
           
       }
       if ([[infor objectForKey:@"code"]integerValue]==201)
       {
           [self.repaymenttableview.mj_header endRefreshing];
           [NSObject wj_showHUDWithTip:@"您没有还款记录"];
       }
   } errorblock:^(NSError *error) {
       
   }];
    
}

#pragma mark - getters

-(UITableView *)repaymenttableview
{
    if(!_repaymenttableview)
    {
        _repaymenttableview = [[UITableView alloc] init];
        _repaymenttableview.dataSource = self;
        _repaymenttableview.delegate = self;
    }
    return _repaymenttableview;
}

-(UITableView *)repaysettableview
{
    if(!_repaysettableview)
    {
        _repaysettableview = [[UITableView alloc] init];
        _repaysettableview.dataSource = self;
        _repaysettableview.delegate = self;
    }
    return _repaysettableview;
}

-(repayView *)repayview
{
    if(!_repayview)
    {
        _repayview = [[repayView alloc] init];
        [_repayview.repaybtn addTarget:self action:@selector(repaybtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _repayview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.repaymenttableview) {
        return self.repayarray.count;
    }
    else
    {
       return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.repaymenttableview) {
        repaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:repayident1];
        if (!cell) {
            cell = [[repaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:repayident1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setcelldata:self.repayarray[indexPath.row]];
        return cell;
    }
    if (tableView==self.repaysettableview) {
        repaymentCell2 *cell = [tableView dequeueReusableCellWithIdentifier:repayident2];
        if (!cell) {
            cell = [[repaymentCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:repayident2];
        }
        if (indexPath.row==0) {
            cell.leftimage.image = [UIImage imageNamed:@"个人_07.22"];
            cell.namelabel.text = @"主动还款(银行卡)";
        }
        if (indexPath.row==1) {
            cell.leftimage.image = [UIImage imageNamed:@"个人_07.22"];
            cell.namelabel.text = @"到期自动扣款(银行卡)";
        }
        if (indexPath.row==2) {
            cell.leftimage.image = [UIImage imageNamed:@"支付宝"];
            cell.namelabel.text = @"支付宝转账";
        }
        if (indexPath.row==3) {
            cell.leftimage.image = [UIImage imageNamed:@"weixin"];
            cell.namelabel.text = @"微信转账";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        return cell;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.repaysettableview)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60*HEIGHT_SCALE)];
        view.backgroundColor = [UIColor wjColorFloat:@"EFF3F5"];
        UILabel *titlalabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15*HEIGHT_SCALE, DEVICE_WIDTH-20, 30*HEIGHT_SCALE)];
        titlalabel.text = @"支持多种还款方式，方便快捷";
        titlalabel.textColor = [UIColor wjColorFloat:@"686868"];
        [view addSubview:titlalabel];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (tableView==self.repaysettableview)
     {
         return 60*HEIGHT_SCALE;
     }else
     {
         return 0;
     }
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.repaysettableview) {
        if (indexPath.row==0) {
            NSLog(@"主动还款");
        }
        if (indexPath.row==1) {
            NSLog(@"到期自动扣款");
        }
        if (indexPath.row==2) {
            NSLog(@"支付宝转账");
            
            
            PaytreasureViewController *paysureVC = [[PaytreasureViewController alloc] init];
            [self.navigationController pushViewController:paysureVC animated:YES];
        }
        if (indexPath.row==3) {
            NSLog(@"微信转账");
            WechatViewController *wechatVC = [[WechatViewController alloc] init];
            [self.navigationController pushViewController:wechatVC animated:YES];

        }
    }
}

#pragma mark - 点击事件

-(void)repaybtnclick
{
    NSLog(@"马上申请");
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    
}

@end
