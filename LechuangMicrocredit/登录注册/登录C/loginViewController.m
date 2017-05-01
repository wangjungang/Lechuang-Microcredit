//
//  loginViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "loginViewController.h"
#import "topimage.h"
#import "loginCell.h"
#import "registeredViewController.h"
#import "forgetpassViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#import "jiexiViewController.h"
@interface loginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) topimage *topimageview;
@property (nonatomic,strong) UITableView *logintableview;
@property (nonatomic,strong) UIButton *loginbtn;
@property (nonatomic,strong) UIButton *registeredbtn;
@property (nonatomic,strong) UIButton *forgetbtn;
@end
static NSString *loginidentfid0 = @"loginidentfid0";
static NSString *loginidentfid1 = @"loginidentfid1";
@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:nil];
    [self.view addSubview:customNavView];
    
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.topimageview addGestureRecognizer:TapGestureTecognizer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topimageview];
    [self.view addSubview:self.logintableview];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.registeredbtn];
    [self.view addSubview:self.forgetbtn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sigenasd:) name:@"regisien" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topimageview.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT/2-60*HEIGHT_SCALE);
    self.logintableview.frame = CGRectMake(0, DEVICE_HEIGHT/2-60*HEIGHT_SCALE, DEVICE_WIDTH, 120*WIDTH_SCALE);
    self.forgetbtn.frame = CGRectMake(DEVICE_WIDTH-100, DEVICE_HEIGHT/2+70*HEIGHT_SCALE, 80, 20);
    self.loginbtn.frame = CGRectMake(40*WIDTH_SCALE, DEVICE_HEIGHT/2+90*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
    self.registeredbtn.frame = CGRectMake(40*WIDTH_SCALE, DEVICE_HEIGHT/2+150*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

#pragma mark - getters

-(topimage *)topimageview
{
    if(!_topimageview)
    {
        _topimageview = [[topimage alloc] init];
        _topimageview.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
    }
    return _topimageview;
}

-(UITableView *)logintableview
{
    if(!_logintableview)
    {
        _logintableview = [[UITableView alloc] init];
        _logintableview.dataSource = self;
        _logintableview.delegate = self;
        _logintableview.scrollEnabled = NO;
    }
    return _logintableview;
}

-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        _loginbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_loginbtn setTitle:@"登录" forState:normal];
        _loginbtn.layer.masksToBounds = YES;
        _loginbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_loginbtn addTarget:self action:@selector(loginbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginbtn;
}

-(UIButton *)registeredbtn
{
    if(!_registeredbtn)
    {
        _registeredbtn = [[UIButton alloc] init];
        [_registeredbtn setTitle:@"注册" forState:normal];
        _registeredbtn.backgroundColor = [UIColor wjColorFloat:@"8A8A8A"];
        _registeredbtn.layer.masksToBounds = YES;
        _registeredbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_registeredbtn addTarget:self action:@selector(regisbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registeredbtn;
}

-(UIButton *)forgetbtn
{
    if(!_forgetbtn)
    {
        _forgetbtn = [[UIButton alloc] init];
        [_forgetbtn setTitle:@"忘记密码 ?" forState:normal];
        [_forgetbtn setTitleColor:[UIColor wjColorFloat:@"686868"] forState:normal];
        _forgetbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetbtn addTarget:self action:@selector(forgetbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetbtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        loginCell *cell = [tableView dequeueReusableCellWithIdentifier:loginidentfid0];
        if (!cell) {
            cell = [[loginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginidentfid0];
        }
        cell.messagetext.placeholder = @"用户名/手机号";
        cell.messagetext.tag = 1;
        cell.messagetext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        return cell;
    }
    if (indexPath.section==1) {
        loginCell *cell = [tableView dequeueReusableCellWithIdentifier:loginidentfid1];
        if (!cell) {
            cell = [[loginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginidentfid1];
        }
        cell.messagetext.placeholder = @"密码";
        cell.messagetext.tag = 2;
        cell.messagetext.delegate = self;
        cell.messagetext.secureTextEntry = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    UITextField *text1 = [self.logintableview viewWithTag:1];
    UITextField *text2 = [self.logintableview viewWithTag:2];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}

#pragma mark - 实现方法

-(void)loginbtnclick
{
    NSLog(@"登录");
//    UITextField *text1 = [self.logintableview viewWithTag:1];
//    UITextField *text2 = [self.logintableview viewWithTag:2];
//    
//    NSDictionary *dic = @{@"phone":text1.text,@"password":text2.text};
//    NSLog(@"dic=======%@",dic);
//    [AFManager postReqURL:login reqBody:dic block:^(id infor) {
//        NSLog(@"info = %@",infor);
//        if ([[infor objectForKey:@"code"]integerValue]==200)
//        {
//            NSLog(@"成功");
//            [USERID setValue:infor[@"id"] forKey:@"uid"];
//            [USERID synchronize];
//            
//            NSLog(@"uid===%@",UID);
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//        if ([[infor objectForKey:@"code"]integerValue]==201)
//        {
//            [NSObject wj_showHUDWithTip:@"用户名不正确"];
//            NSLog(@"用户名不正确");
//            // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        }
//        if ([[infor objectForKey:@"code"]integerValue]==202)
//        {
//            [NSString wj_showHUDWithTip:@"密码不正确"];
//            NSLog(@"密码不正确");
//             //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        }
//
//    }];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)regisbtnclick
{
    NSLog(@"注册");
    registeredViewController *regisVC = [[registeredViewController alloc] init];
    [self presentViewController:regisVC animated:YES completion:nil];

}

-(void)sigenasd:(NSNotification *)notifocation
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)forgetbtnclick
{
    NSLog(@"忘记密码");
    forgetpassViewController *forgetVC = [[forgetpassViewController alloc] init];
    forgetVC.type = @"login";
    [self presentViewController:forgetVC animated:YES completion:nil];
}

@end
