//
//  TradingpasswordViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/19.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "TradingpasswordViewController.h"
#import "TradingCell.h"
@interface TradingpasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *tradingTableview;
@property (nonatomic,strong) UIButton *submitbtn;
@end
static NSString *tradingidentfid = @"tradingidentfid";
@implementation TradingpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.tradingTableview addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"交易密码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self.view addSubview:self.tradingTableview];
    [self.view addSubview:self.submitbtn];
    self.tradingTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tradingTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.submitbtn.frame = CGRectMake(40, 64+210*HEIGHT_SCALE, DEVICE_WIDTH-80, 50*HEIGHT_SCALE);
}

#pragma mark - getters

-(UITableView *)tradingTableview
{
    if(!_tradingTableview)
    {
        _tradingTableview = [[UITableView alloc] init];
        _tradingTableview.dataSource = self;
        _tradingTableview.delegate = self;
    }
    return _tradingTableview;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        [_submitbtn setTitle:@"提交" forState:normal];
        _submitbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitbtn.layer.masksToBounds = YES;
        _submitbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _submitbtn;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradingCell *cell = [tableView dequeueReusableCellWithIdentifier:tradingidentfid];
    if (!cell) {
        cell = [[TradingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tradingidentfid];
    }
    if (indexPath.row==0) {
        cell.messagetext.tag = 1;
        cell.messagetext.placeholder = @"请输入交易密码";
    }
    if (indexPath.row==1) {
        cell.messagetext.tag = 2;
        cell.messagetext.placeholder = @"请再次确认密码";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.messagetext.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

#pragma mark - 实现方法

-(void)keyboardHide
{
    UITextField *text1 = [self.tradingTableview viewWithTag:1];
    UITextField *text2 = [self.tradingTableview viewWithTag:2];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)submitbtnclick
{
    NSLog(@"提交");
    UITextField *text1 = [self.tradingTableview viewWithTag:1];
    UITextField *text2 = [self.tradingTableview viewWithTag:2];
    
    if ([text1.text isEqualToString:text2.text]) {
        NSDictionary *dic = @{@"id":UID,@"payPassword":text1.text};
        [AFManager postReqURL:paypassword reqBody:dic block:^(id infor) {
            NSLog(@"info====%@",infor);
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                [NSObject wj_showHUDWithTip:@"设置成功"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==201)
            {
                [NSObject wj_showHUDWithTip:@"密码已存在"];
            }
        }];

    }
    else
    {
        [NSObject wj_showHUDWithTip:@"密码前后设置应保持一致"];
    }
    
}

@end
