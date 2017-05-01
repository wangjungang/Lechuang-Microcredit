//
//  registeredViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "registeredViewController.h"
#import "registeredCell0.h"
#import "registeredCell1.h"

@interface registeredViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *registeredtableview;
@property (nonatomic,strong) UIButton *regisbtn;
@end
static NSString *regisidentfid0 = @"regisidentfid0";
static NSString *regisidentfid1 = @"regisidentfid1";
static NSString *regisidentfid2 = @"regisidentfid2";
@implementation registeredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"注册"];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view addSubview:customNavView];
    
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.registeredtableview addGestureRecognizer:TapGestureTecognizer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.registeredtableview];
    [self.view addSubview:self.regisbtn];
    self.registeredtableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.registeredtableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    
    self.regisbtn.frame = CGRectMake(40*WIDTH_SCALE, 64+240*HEIGHT_SCALE, DEVICE_WIDTH-80*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

#pragma mark - getters


-(UITableView *)registeredtableview
{
    if(!_registeredtableview)
    {
        _registeredtableview = [[UITableView alloc] init];
        _registeredtableview.dataSource = self;
        _registeredtableview.delegate = self;
        _registeredtableview.scrollEnabled = NO;
    }
    return _registeredtableview;
}

-(UIButton *)regisbtn
{
    if(!_regisbtn)
    {
        _regisbtn = [[UIButton alloc] init];
        [_regisbtn setTitle:@"登录" forState:normal];
        _regisbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        _regisbtn.layer.masksToBounds = YES;
        _regisbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_regisbtn addTarget:self action:@selector(regisbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regisbtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        registeredCell0 *cell = [tableView dequeueReusableCellWithIdentifier:regisidentfid0];
        if (!cell) {
            cell = [[registeredCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:regisidentfid0];
        }
        cell.messagetext.placeholder = @"手机号";
        cell.messagetext.delegate = self;
        cell.messagetext.tag = 1;
        cell.timebtn.tag = 100;
        [cell.timebtn addTarget:self action:@selector(getvalid) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        return cell;
    }
    else
    {
        registeredCell1 *cell = [tableView dequeueReusableCellWithIdentifier:regisidentfid1];
        if (!cell) {
            cell = [[registeredCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:regisidentfid1];
        }
        if (indexPath.row==1) {
            cell.messagetext.placeholder = @"验证码";
            cell.messagetext.tag = 2;
        }
        if (indexPath.row==2) {
            cell.messagetext.placeholder = @"新密码";
            cell.messagetext.tag = 3;
            cell.messagetext.secureTextEntry = YES;
        }
        if (indexPath.row==3) {
            cell.messagetext.placeholder = @"被邀请码，选填";
            cell.messagetext.tag = 4;
        }
        cell.messagetext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)startTime{
    UIButton *getbtn = [self.registeredtableview viewWithTag:100];
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [getbtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                getbtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [getbtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                getbtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)keyboardHide
{
    UITextField *text1 = [self.registeredtableview viewWithTag:1];
    UITextField *text2 = [self.registeredtableview viewWithTag:2];
    UITextField *text3 = [self.registeredtableview viewWithTag:3];
    UITextField *text4 = [self.registeredtableview viewWithTag:4];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
}

-(void)getvalid
{
    UITextField *text1 = [self.registeredtableview viewWithTag:1];
    [AFManager getReqURL:[NSString stringWithFormat:getCode,text1.text] block:^(id infor) {
        NSLog(@"info = %@",infor);
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             NSLog(@"成功");
             [self startTime];
         }
         if ([[infor objectForKey:@"code"]integerValue]==201)
         {
             NSLog(@"请检查输入");
         }
    } errorblock:^(NSError *error) {
        
    }];
}

//注册登录

-(void)regisbtnclick
{
    UITextField *text1 = [self.registeredtableview viewWithTag:1];
    UITextField *text2 = [self.registeredtableview viewWithTag:2];
    UITextField *text3 = [self.registeredtableview viewWithTag:3];
    UITextField *text4 = [self.registeredtableview viewWithTag:4];
    
    NSDictionary *dic = @{@"code":text2.text,@"phone":text1.text,@"password":text3.text,@"BInviteCode":text4.text};
    NSDictionary *dic2 = @{@"phone":text1.text,@"password":text3.text};
    [AFManager postReqURL:reg reqBody:dic block:^(id infor) {
        NSLog(@"info=%@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [AFManager postReqURL:login reqBody:dic2 block:^(id infor) {
                if ([[infor objectForKey:@"code"]integerValue]==200)
                {
                    [USERID setValue:infor[@"id"] forKey:@"uid"];
                    [USERID synchronize];
                    
                    NSLog(@"uid===%@",UID);
                    [self hudshowstr:@"注册成功"];
                    [self dismissViewControllerAnimated:NO completion:nil];  
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"regisien" object:nil];
                }
            }];

        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            NSLog(@"请检查输入");
           [self hudshowstr:@"请检查输入"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==202)
        {
            NSLog(@"用户已经注册");
            [self hudshowstr:@"用户已经注册"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==203)
        {
            [self hudshowstr:@"请检查输入"];
        }
    }];
    
}

-(void)hudshowstr:(NSString *)showstr
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = showstr;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}

@end
