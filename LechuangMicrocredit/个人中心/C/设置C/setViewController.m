//
//  setViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "setViewController.h"
#import "setCell.h"
#import "aboutusViewController.h"
#import "feedbackViewController.h"
#import "changepasswordViewController.h"
#import "TradingpasswordViewController.h"

#import "loginViewController.h"
@interface setViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *settableview;
@property (nonatomic,strong) UIButton *exitbtn;
@end
static NSString *setidentfid = @"setidentfid";
@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"设置"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.settableview];
    self.settableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.exitbtn];
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
    self.settableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.exitbtn.frame = CGRectMake(DEVICE_WIDTH/2-80, DEVICE_HEIGHT/3*2, 160, 40);
}

#pragma mark - getters


-(UITableView *)settableview
{
    if(!_settableview)
    {
        _settableview = [[UITableView alloc] init];
        _settableview.dataSource = self;
        _settableview.delegate = self;
        _settableview.scrollEnabled = NO;
    }
    return _settableview;
}


-(UIButton *)exitbtn
{
    if(!_exitbtn)
    {
        _exitbtn = [[UIButton alloc] init];
        [_exitbtn setTitle:@"退出登录" forState:normal];
        [_exitbtn setTitleColor:[UIColor wjColorFloat:@"008CCF"] forState:normal];
        _exitbtn.layer.masksToBounds = YES;
        _exitbtn.layer.cornerRadius = 20;
        _exitbtn.layer.borderWidth = 2;
        _exitbtn.layer.borderColor = [UIColor wjColorFloat:@"008CCF"].CGColor;
        [_exitbtn addTarget:self action:@selector(exitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitbtn;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else
    {
       return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    setCell *cell = [tableView dequeueReusableCellWithIdentifier:setidentfid];
    if (!cell) {
        cell = [[setCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setidentfid];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.leftimage.image = [UIImage imageNamed:@"shehzi"];
            cell.namelabel.text = @"关于我们";
        }
        if (indexPath.row==1) {
            cell.leftimage.image = [UIImage imageNamed:@"shezih"];
            cell.namelabel.text = @"意见反馈";
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.leftimage.image = [UIImage imageNamed:@"xiugia"];
            cell.namelabel.text = @"修改登录密码";
        }
        if (indexPath.row==1) {
            cell.leftimage.image = [UIImage imageNamed:@"suo"];
            cell.namelabel.text = @"设置交易密码";
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

//点击cell方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //关于我们
            aboutusViewController *aboutVC = [[aboutusViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        if (indexPath.row==1) {
            //意见反馈
            feedbackViewController *feedbackVC = [[feedbackViewController alloc] init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            //修改登录密码
            changepasswordViewController *changeVC = [[changepasswordViewController alloc] init];
            [self.navigationController pushViewController:changeVC animated:YES];
        }
        if (indexPath.row==1) {
            //设置交易密码
            TradingpasswordViewController *tradingVC = [[TradingpasswordViewController alloc] init];
            [self.navigationController pushViewController:tradingVC animated:YES];
        }
    }
}

#pragma mark - 实现方法

-(void)exitbtnclick
{
    NSLog(@"退出登录");
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"uid"];
    [defaults synchronize];
    loginViewController *loginVC = [[loginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
