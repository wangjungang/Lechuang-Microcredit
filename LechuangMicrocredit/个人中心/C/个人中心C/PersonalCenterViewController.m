//
//  PersonalCenterViewController.m
//  LechuangMicrocredit
//
//  Created by 张婷 on 16/12/5.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "personalCell.h"
#import "borrowingrecordViewController.h"
#import "helpViewController.h"
#import "certificationViewController.h"
#import "mypreferentialViewController.h"
#import "getmoneyViewController.h"
#import "myinvitationViewController.h"
#import "setViewController.h"
@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *infotableview;
@property (nonatomic,strong) NSMutableArray *infoarray;
@property (nonatomic,strong) NSMutableArray *infoimagearray;
@property (nonatomic,strong) CustomNavigation *customNavView;
@property (nonatomic,strong) UIImageView *pointimage;
@end
static NSString *infotableviewcell = @"infocell";
@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor purpleColor];
    self.customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [self.customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"个人中心"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.infoarray = [NSMutableArray array];
    self.infoimagearray = [NSMutableArray array];
    [self loaddataformweb];
    [self.view addSubview:self.customNavView];
    [self.view addSubview:self.infotableview];
    self.infotableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.customNavView setHidden:YES];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
}

-(void)loaddataformweb
{
    self.infoarray = [NSMutableArray arrayWithObjects:@"借款记录",@"完善资料",@"收款银行卡",@"帮助",@"我的优惠",@"我的邀请码",@"推荐给好友",@"设置", nil];
    self.infoimagearray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"个人_07"],[UIImage imageNamed:@"个人_07.1"],[UIImage imageNamed:@"个人_07.2"],[UIImage imageNamed:@"个人_07.3"],[UIImage imageNamed:@"个人_07.4"],[UIImage imageNamed:@"个人_07.5"],[UIImage imageNamed:@"个人_07.6"],[UIImage imageNamed:@"个人_07.7"], nil];
}

-(UITableView *)infotableview
{
    if(!_infotableview)
    {
        _infotableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-49) style:UITableViewStyleGrouped];
        _infotableview.dataSource = self;
        _infotableview.delegate = self;
    }
    return _infotableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    personalCell *cell = [tableView dequeueReusableCellWithIdentifier:infotableviewcell];
    if (!cell) {
        cell = [[personalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infotableviewcell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.infolabel.text = self.infoarray[indexPath.row];
    cell.infoimage.image = self.infoimagearray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90/2*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 628.f/2*HEIGHT_SCALE;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 628/2*HEIGHT_SCALE)];
    view0.image = [UIImage imageNamed:@"个人_01"];
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 628.f/2*HEIGHT_SCALE)];
    view1.image = [UIImage imageNamed:@"表盘"];
    [view0 addSubview:view1];
    self.pointimage = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-60, view1.frame.size.height/2+50, 60, 40)];
    
    //self.pointimage.backgroundColor = [UIColor greenColor];
    self.pointimage.image = [UIImage imageNamed:@"针"];
    self.pointimage.tag = 101;
    [view0 addSubview:self.pointimage];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-40, 20, 80, 30)];
    titlelabel.text = @"个人中心";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    [view0 addSubview:titlelabel];
    return view0;
}//点击cell方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        //借款记录
        borrowingrecordViewController *borwVC = [[borrowingrecordViewController alloc] init];
        [self.navigationController pushViewController:borwVC animated:YES];
        
    }
    if (indexPath.row==1) {
        //完善资料
        certificationViewController *certiVC = [[certificationViewController alloc] init];
        [self.navigationController pushViewController:certiVC animated:YES];
    }
    if (indexPath.row==2) {
        //收款银行卡
        getmoneyViewController *getmoneyVC = [[getmoneyViewController alloc] init];
        [self.navigationController pushViewController:getmoneyVC animated:YES];
    }
    if (indexPath.row==3) {
        //帮助
        helpViewController *helpVC = [[helpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
    }
    if (indexPath.row==4) {
        //我的优惠
        mypreferentialViewController *mypreVC = [[mypreferentialViewController alloc] init];
        [self.navigationController pushViewController:mypreVC animated:YES];
    }
    if (indexPath.row==5) {
        //我的邀请码
        myinvitationViewController *myinvitaVC = [[myinvitationViewController alloc] init];
        [self.navigationController pushViewController:myinvitaVC animated:YES];
    }
    if (indexPath.row==6) {
        //推荐给好友
        
    }
    if (indexPath.row==7) {
        //设置
        setViewController *setVC = [[setViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
}


-(void)xuanzhuanjiaodu:(NSString *)jiaodu
{
    UIImageView *view = [self.infotableview viewWithTag:101];
    view.layer.anchorPoint = CGPointMake(1, 1);
    
    if ([jiaodu isEqualToString:@"1000"]) {
        view.transform = CGAffineTransformMakeRotation(M_PI/10);
        view.transform=CGAffineTransformTranslate(view.transform, 30*WIDTH_SCALE, 0);
    }
    if ([jiaodu isEqualToString:@"2000"]) {
        view.transform =CGAffineTransformMakeRotation(M_PI/3.2);
    }
    if ([jiaodu isEqualToString:@"3000"]) {
        view.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    if ([jiaodu isEqualToString:@"4000"]) {
        view.transform=CGAffineTransformMakeRotation(M_PI/1.6);
    }
    if ([jiaodu isEqualToString:@"5000"]) {
        view.transform = CGAffineTransformMakeRotation(M_PI/1.3);
        view.transform=CGAffineTransformTranslate(view.transform, -30*WIDTH_SCALE, 20*HEIGHT_SCALE);
    }
    if ([jiaodu isEqualToString:@"6000"]) {
        view.transform=CGAffineTransformMakeRotation(M_PI*0.95);
        view.transform=CGAffineTransformTranslate(view.transform, -30*WIDTH_SCALE, 40*HEIGHT_SCALE);
    }
    if ([jiaodu isEqualToString:@"7000"]) {
        view.transform = CGAffineTransformMakeRotation(M_PI*1.14);
        view.transform=CGAffineTransformTranslate(view.transform, -20*WIDTH_SCALE, 70*HEIGHT_SCALE);
    }
    if ([jiaodu isEqualToString:@"8000"]) {
        view.transform = CGAffineTransformMakeRotation(M_PI*1.25);
        view.transform=CGAffineTransformTranslate(view.transform, -15*WIDTH_SCALE, 70*HEIGHT_SCALE);
    }
}

@end
