//
//  WechatViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/23.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "WechatViewController.h"
#import "payCell0.h"
#import "payCell1.h"
@interface WechatViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *wechattableView;
@property (nonatomic,strong) UIButton *wechatbtn;
@end
static NSString *wechatpay0 = @"wechatpay0";
static NSString *wechatpay1 = @"wechatpay1";
@implementation WechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"微信支付"];
    [self.view addSubview:customNavView];
    
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.wechattableView];
    [self.view addSubview:self.wechatbtn];
    self.wechattableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.wechattableView.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.wechatbtn.frame = CGRectMake(40*WIDTH_SCALE, 240*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

#pragma mark - getters

-(UITableView *)wechattableView
{
    if(!_wechattableView)
    {
        _wechattableView = [[UITableView alloc] init];
        _wechattableView.dataSource = self;
        _wechattableView.delegate = self;
        _wechattableView.scrollEnabled = NO;
    }
    return _wechattableView;
}

-(UIButton *)wechatbtn
{
    if(!_wechatbtn)
    {
        _wechatbtn = [[UIButton alloc] init];
        [_wechatbtn setTitle:@"确认支付" forState:normal];
        _wechatbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_wechatbtn addTarget:self action:@selector(wechatbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _wechatbtn.layer.masksToBounds = YES;
        _wechatbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _wechatbtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        payCell0 *cell = [tableView dequeueReusableCellWithIdentifier:wechatpay0];
        if (!cell) {
            cell = [[payCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wechatpay0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftlabel.text = @"支付";
        cell.moneylabel.text = @"2000";
        return cell;
    }
    else
    {
        payCell1 *cell = [tableView dequeueReusableCellWithIdentifier:wechatpay1];
        if (!cell) {
            cell = [[payCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wechatpay1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftimage.image = [UIImage imageNamed:@"weixinbig"];
        cell.namelabel.text = @"微信支付";
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 50*HEIGHT_SCALE;
    }
    else
    {
        return 70*HEIGHT_SCALE;
    }

}

#pragma mark - 实现方法

-(void)wechatbtnclick
{
    
}

@end
