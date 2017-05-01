//
//  myinvitationViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinvitationViewController.h"
#import "myinvitationCell.h"
#import "invitationView.h"
#import "mybonusViewController.h"
@interface myinvitationViewController ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate>
@property (nonatomic,strong) UITableView *myinvieatableview;
@property (nonatomic,strong) invitationView *invitview;
@end
static NSString *invitidentfid = @"invitidentfid";
@implementation myinvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.myinvieatableview addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"邀请码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myinvieatableview];
    self.myinvieatableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.invitview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    self.myinvieatableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.invitview.frame = CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH, 220);
}

#pragma mark - getters

-(UITableView *)myinvieatableview
{
    if(!_myinvieatableview)
    {
        _myinvieatableview = [[UITableView alloc] init];
        _myinvieatableview.dataSource = self;
        _myinvieatableview.delegate = self;
        _myinvieatableview.scrollEnabled = NO;
    }
    return _myinvieatableview;
}

-(invitationView *)invitview
{
    if(!_invitview)
    {
        _invitview = [[invitationView alloc] init];
        _invitview.layer.masksToBounds = YES;
        _invitview.layer.borderWidth = 0.3;
        _invitview.layer.cornerRadius = 20;
        [_invitview.firstbtn addTarget:self action:@selector(sinaclick) forControlEvents:UIControlEventTouchUpInside];
        [_invitview.secondbtn addTarget:self action:@selector(weichatclick) forControlEvents:UIControlEventTouchUpInside];
        [_invitview.thirdbtn addTarget:self action:@selector(tencentqqclick) forControlEvents:UIControlEventTouchUpInside];
        [_invitview.forthbtn addTarget:self action:@selector(Circlefriendclick) forControlEvents:UIControlEventTouchUpInside];
        [_invitview.lastbtn addTarget:self action:@selector(spaceclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _invitview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myinvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:invitidentfid];
    if (!cell) {
        cell = [[myinvitationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invitidentfid];
    }
    if (indexPath.row==0) {
        cell.leftimage.image = [UIImage imageNamed:@"yao"];
        cell.namelabel.text = @"直接邀请";
        [cell.rightbtn setTitle:@"直接邀请" forState:UIControlStateNormal];
        [cell.rightbtn setTitleColor:[UIColor wjColorFloat:@"90D6F3"] forState:normal];
    }
    if (indexPath.row==1) {
        cell.leftimage.image = [UIImage imageNamed:@"qian"];
        cell.namelabel.text = @"我的奖金";
        [cell.rightbtn setTitle:@"点击查看" forState:UIControlStateNormal];
        [cell.rightbtn setTitleColor:[UIColor wjColorFloat:@"90D6F3"] forState:normal];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 250*HEIGHT_SCALE)];
    UIImageView *headimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 250*HEIGHT_SCALE)];
    headimage.image = [UIImage imageNamed:@"邀请码_02"];
    [view addSubview:headimage];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-90*WIDTH_SCALE, 30*HEIGHT_SCALE, 180*WIDTH_SCALE, 20*HEIGHT_SCALE)];
    NSString *astring = @"0位好友为我赚取了";
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:astring];
    [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                                    value:[UIColor wjColorFloat:@"FFDF00"]
                                    range:NSMakeRange(0, 1)];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.attributedText = aAttributedString;
    [view addSubview:titlelabel];
    UILabel *numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-60*WIDTH_SCALE, 60*HEIGHT_SCALE, 120*WIDTH_SCALE, 50*HEIGHT_SCALE)];
    NSString *numstr = @"¥ 0.00";
    NSMutableAttributedString * aAttributedStringnum = [[NSMutableAttributedString alloc] initWithString:numstr];
    numberlabel.font = [UIFont systemFontOfSize:30];
    [aAttributedStringnum addAttribute:NSFontAttributeName             //文字字体
                                   value:[UIFont systemFontOfSize:14]
                                   range:NSMakeRange(0, 1)];
    numberlabel.attributedText = aAttributedStringnum;
    numberlabel.textAlignment = NSTextAlignmentCenter;
    numberlabel.textColor = [UIColor wjColorFloat:@"FFDF00"];
    [view addSubview:numberlabel];
    UILabel *infolabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-150, 130, 300, 20)];
    infolabel.text = @"邀请好友注册申请最高可得到100元奖励";
    infolabel.font = [UIFont systemFontOfSize:14];
    infolabel.textColor = [UIColor whiteColor];
    infolabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:infolabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    return 250*HEIGHT_SCALE;
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.myinvieatableview indexPathForCell:cell];
    NSLog(@"333===%ld",index.row);
    if (index.row==0) {
        NSLog(@"1111111");
        [UIView animateWithDuration:0.3 animations:^{
            self.invitview.transform = CGAffineTransformMakeTranslation(0, -200);
            [self.view bringSubviewToFront:self.invitview];
            self.myinvieatableview.alpha = 0.4;
        }completion:^(BOOL finished) {
            
        }];
    }
    if (index.row==1) {
        NSLog(@"2222222");
        mybonusViewController *mybounsVC = [[mybonusViewController alloc] init];
        [self.navigationController pushViewController:mybounsVC animated:YES];
    }
}

-(void)keyboardHide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.invitview.transform = CGAffineTransformIdentity;
        self.myinvieatableview.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark -  分享按钮

-(void)sinaclick
{
    NSLog(@"新浪微博");
}
-(void)weichatclick
{
    NSLog(@"微信好友");
}
-(void)tencentqqclick
{
    NSLog(@"qq好友");
}
-(void)Circlefriendclick
{
    NSLog(@"朋友圈");
}
-(void)spaceclick
{
    NSLog(@"qq空间");
}
@end
