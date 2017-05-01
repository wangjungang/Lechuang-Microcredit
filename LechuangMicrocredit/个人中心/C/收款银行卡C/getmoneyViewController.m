//
//  getmoneyViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "getmoneyViewController.h"
#import "getmoneyCell.h"
@interface getmoneyViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *bankcardtableview;
@property (nonatomic,strong) NSMutableArray *namearr;
@end
static NSString *getcellidentfid = @"getcellidentfid";
@implementation getmoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.bankcardtableview addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"收款银行卡"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        NSLog(@"保存");
        [self saveclick];
    };
    self.namearr = [NSMutableArray arrayWithObjects:@"用户名",@"卡号", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bankcardtableview];
    self.bankcardtableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    self.bankcardtableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}

#pragma mark - getters


-(UITableView *)bankcardtableview
{
    if(!_bankcardtableview)
    {
        _bankcardtableview = [[UITableView alloc] init];
        _bankcardtableview.dataSource = self;
        _bankcardtableview.delegate = self;
        _bankcardtableview.scrollEnabled = NO;
    }
    return _bankcardtableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    getmoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:getcellidentfid];
    if (!cell) {
        cell = [[getmoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:getcellidentfid];
    }
    cell.bankcardtextfiled.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.leftlabel.text = self.namearr[indexPath.row];
    if (indexPath.row==0) {
        cell.bankcardtextfiled.tag = 2;
    }
    if (indexPath.row==1) {
        cell.bankcardtextfiled.tag = 1;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60*HEIGHT_SCALE)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15*HEIGHT_SCALE, 200*WIDTH_SCALE, 30*HEIGHT_SCALE)];
    label.text = @"所借款项将发到该卡";
    [view addSubview:label];
    label.textColor = [UIColor wjColorFloat:@"6F6F6F"];
    view.backgroundColor = [UIColor wjColorFloat:@"EBEEF0"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    return 60*HEIGHT_SCALE;
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    UITextField *text0 = [self.bankcardtableview viewWithTag:2];
    UITextField *text1 = [self.bankcardtableview viewWithTag:1];
    [text0 resignFirstResponder];
    [text1 resignFirstResponder];
}


#pragma mark - 实现方法
-(void)saveclick
{
    UITextField *text0 = [self.bankcardtableview viewWithTag:2];
    UITextField *text1 = [self.bankcardtableview viewWithTag:1];
    NSLog(@"text0====%@",text0.text);
    NSLog(@"text1====%@",text1.text);
}
@end
