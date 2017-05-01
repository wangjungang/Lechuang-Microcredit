//
//  phoneregisViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "phoneregisViewController.h"
#import "phoneregisCell0.h"
#import "phoneregisCell1.h"
#import "forgetwaitViewController.h"
#import "leftView.h"
@interface phoneregisViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *phoneregisTableView;
@property (nonatomic,strong) UIButton *submitbtn;
@property (nonatomic,strong) UIButton *waitbtn;
@property (nonatomic,strong) leftView *leftview;

@property (nonatomic,strong) UIImageView *viewimg;
@end
static NSString *phoneregisidengfid0 = @"phoneregisidengfid0";
static NSString *phoneregisidentfid1 = @"phoneregisidentfid1";
@implementation phoneregisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.phoneregisTableView addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"手机号认证"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    self.viewimg = [[UIImageView alloc] init];
    self.viewimg.frame = CGRectMake(DEVICE_WIDTH/2-40*WIDTH_SCALE, 30*HEIGHT_SCALE, 80*WIDTH_SCALE, 90*HEIGHT_SCALE);
    [self loaddatafromweb];
    
    [self.view addSubview:self.phoneregisTableView];
    self.phoneregisTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.submitbtn];
    [self.view addSubview:self.waitbtn];
    [self.view addSubview:self.leftview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.submitbtn.frame = CGRectMake(40*WIDTH_SCALE, 64+300*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
    self.waitbtn.frame = CGRectMake(DEVICE_WIDTH-120*WIDTH_SCALE, 64+260*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.leftview.frame = CGRectMake(0, DEVICE_HEIGHT-150*HEIGHT_SCALE, DEVICE_WIDTH, 150*HEIGHT_SCALE);
}

-(void)loaddatafromweb
{
    [AFManager getReqURL:[NSString stringWithFormat:phonetype,UID] block:^(id infor) {
         if ([[infor objectForKey:@"code"] integerValue]==200)
         {
             NSDictionary *dic = [infor objectForKey:@"data"];
             NSString *type = [dic objectForKey:@"type"];
             NSString *phonestr = [dic objectForKey:@"phone"];
             
             NSLog(@"type==========%@",type);
             NSLog(@"phonestr===========%@",phonestr);
             UILabel *label = [self.phoneregisTableView viewWithTag:100];
             label.text = phonestr;

             if ([type isEqualToString:@"0"]) {
                 self.viewimg.image =  [UIImage imageNamed:@"移动183x208"];
             }
             if ([type isEqualToString:@"1"]) {
                 self.viewimg.image =  [UIImage imageNamed:@"联通183x208"];
             }
             if ([type isEqualToString:@"2"]) {
                 self.viewimg.image =  [UIImage imageNamed:@"电信183x208"];
             }
             [self.phoneregisTableView reloadData];
         }
         if ([[infor objectForKey:@"code"] integerValue]==201)
         {
             [NSObject wj_showHUDWithTip:@"请求失败"];
         }
    } errorblock:^(NSError *error) {
        [NSObject wj_showHUDWithTip:@"请检查网络"];
    }];
}

#pragma mark - getters

-(UITableView *)phoneregisTableView
{
    if(!_phoneregisTableView)
    {
        _phoneregisTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        _phoneregisTableView.dataSource = self;
        _phoneregisTableView.delegate = self;
        _phoneregisTableView.scrollEnabled = NO;
        _phoneregisTableView.backgroundColor = [UIColor wjColorFloat:@"F4F6F5"];
    }
    return _phoneregisTableView;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc]init];
        [_submitbtn setTitle:@"提交" forState:normal];
        _submitbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _submitbtn.layer.masksToBounds = YES;
        _submitbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _submitbtn;
}


-(UIButton *)waitbtn
{
    if(!_waitbtn)
    {
        _waitbtn = [[UIButton alloc] init];
        [_waitbtn addTarget:self action:@selector(waitbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_waitbtn setTitle:@"忘记或重制密码" forState:normal];
        _waitbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_waitbtn setTitleColor:[UIColor wjColorFloat:@"8C9A9F"] forState:normal];
    }
    return _waitbtn;
}

-(leftView *)leftview
{
    if(!_leftview)
    {
        _leftview = [[leftView alloc] init];
        _leftview.backgroundColor = [UIColor wjColorFloat:@"F4F6F5"];
        
    }
    return _leftview;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        phoneregisCell0 *cell = [tableView dequeueReusableCellWithIdentifier:phoneregisidengfid0];
        if (!cell) {
            cell = [[phoneregisCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneregisidengfid0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.phonelabel.tag = 100;
        return cell;
    }
    if (indexPath.row==1) {
        phoneregisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:phoneregisidentfid1];
        if (!cell) {
            cell = [[phoneregisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneregisidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.messagetext.delegate = self;
        cell.messagetext.tag = 101;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 140*HEIGHT_SCALE;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 140*HEIGHT_SCALE)];

    [view addSubview:self.viewimg];
    return view;
}

#pragma mark -UITextFieldDelegate

-(void)keyboardHide
{
    UITextField *text = [self.phoneregisTableView viewWithTag:101];
    [text resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 实现方法

-(void)submitbtnclick
{
    NSLog(@"提交");
    
}

-(void)waitbtnclick
{
    forgetwaitViewController *forgetwaitVC = [[forgetwaitViewController alloc] init];
    [self.navigationController pushViewController:forgetwaitVC animated:YES];
}
@end
