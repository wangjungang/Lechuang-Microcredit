//
//  PaytreasureViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/23.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "PaytreasureViewController.h"
#import "payCell0.h"
#import "payCell1.h"

#import "AlipayModel.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Apipayclick.h"
@interface PaytreasureViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *paytreasureTableview;
@property (nonatomic,strong) UIButton *paybtn;
@end
static NSString *payidentfid0 = @"payidentfid0";
static NSString *payidentfid1 = @"payidentfid1";
@implementation PaytreasureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"支付宝支付"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self loaddatafromweb];
    [self.view addSubview:self.paytreasureTableview];
    self.paytreasureTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.paybtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.paytreasureTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.paybtn.frame = CGRectMake(40*WIDTH_SCALE, 240*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

-(void)loaddatafromweb
{
    [AFManager getReqURL:[NSString stringWithFormat:moneys,UID] block:^(id infor) {
        NSLog(@"infor=======%@",infor);
        NSString *moneystr = [infor objectForKey:@"data"];
        UILabel *moneylabel = [self.paytreasureTableview viewWithTag:2000];
        moneylabel.text = moneystr;
        [self.paytreasureTableview reloadData];
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark - getters

-(UITableView *)paytreasureTableview
{
    if(!_paytreasureTableview)
    {
        _paytreasureTableview = [[UITableView alloc] init];
        _paytreasureTableview.dataSource = self;
        _paytreasureTableview.delegate = self;
        _paytreasureTableview.scrollEnabled = NO;
    }
    return _paytreasureTableview;
}

-(UIButton *)paybtn
{
    if(!_paybtn)
    {
        _paybtn = [[UIButton alloc]init];
        [_paybtn setTitle:@"确认支付" forState:normal];
        _paybtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_paybtn addTarget:self action:@selector(paybtnclick) forControlEvents:UIControlEventTouchUpInside];
        _paybtn.layer.masksToBounds = YES;
        _paybtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _paybtn;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        payCell0 *cell = [tableView dequeueReusableCellWithIdentifier:payidentfid0];
        if (!cell) {
            cell = [[payCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payidentfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftlabel.text = @"还款";
        cell.moneylabel.tag = 2000 ;
        return cell;
    }
    else
    {
        payCell1 *cell = [tableView dequeueReusableCellWithIdentifier:payidentfid1];
        if (!cell) {
            cell = [[payCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftimage.image = [UIImage imageNamed:@"zhifubaobig"];
        cell.namelabel.text = @"支付宝支付";
        return cell;
    }
    return  nil;
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

-(void)paybtnclick
{
    UILabel *moneylabel = [self.paytreasureTableview viewWithTag:2000];
    NSString *moneystr = moneylabel.text;
    NSDictionary *dit = @{@"uid":UID,@"money":moneystr};
    [AFManager postReqURL:refundZhifubao reqBody:dit block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"还款成功"];
            
            NSDictionary *dic = [[NSDictionary alloc] init];
            dic = [infor objectForKey:@"data"];
            NSString *order = [dic objectForKey:@"order"];
            NSLog(@"order=====%@",order);
            
            NSString *notify_url = [dic objectForKey:@"notify_url"];
            NSLog(@"notify_url======%@",notify_url);
            NSString *moner = [NSString stringWithFormat:@"%.2f",0.01];
            [Apipayclick alipayModelWithOrderid:order withName:@"还款" withMoney:moner withNotify:notify_url withViewcontroller:self];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"还款错误"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==203)
        {
            [NSObject wj_showHUDWithTip:@"还款金额不对"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==202)
        {
            [NSObject wj_showHUDWithTip:@"没有借款记录"];
        }
    }];

}
@end
