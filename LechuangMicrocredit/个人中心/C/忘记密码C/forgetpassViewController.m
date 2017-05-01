//
//  forgetpassViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/19.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "forgetpassViewController.h"
#import "registeredCell0.h"
#import "registeredCell1.h"
@interface forgetpassViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *forgetTableview;
@property (nonatomic,strong) UIButton *postbtn;
@end
static NSString *forgetidentfid0 = @"forgetidentfid0";
static NSString *forgetidentfid1 = @"forgetidentfid1";
@implementation forgetpassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.forgetTableview addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"忘记登录密码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        if ([self.type isEqualToString:@"set"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.forgetTableview];
    [self.view addSubview:self.postbtn];
    self.forgetTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.forgetTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    self.postbtn.frame = CGRectMake(40, 64+210*HEIGHT_SCALE, DEVICE_WIDTH-80, 50*HEIGHT_SCALE);
}

#pragma mark - getters

-(UITableView *)forgetTableview
{
    if(!_forgetTableview)
    {
        _forgetTableview = [[UITableView alloc] init];
        _forgetTableview.dataSource = self;
        _forgetTableview.delegate = self;
        _forgetTableview.scrollEnabled = NO;
    }
    return _forgetTableview;
}

-(UIButton *)postbtn
{
    if(!_postbtn)
    {
        _postbtn = [[UIButton alloc] init];
        [_postbtn setTitle:@"提交" forState:normal];
        _postbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        _postbtn.layer.masksToBounds = YES;
        _postbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_postbtn addTarget:self action:@selector(getupdatapassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postbtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        registeredCell0 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid0];
        if (!cell) {
            cell = [[registeredCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid0];
        }
        cell.messagetext.tag = 1;
        cell.timebtn.tag = 100;
        [cell.timebtn addTarget:self action:@selector(yanzhengma) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.messagetext.delegate = self;
        cell.messagetext.placeholder = @"请输入手机号";
        return cell;
    }
    else
    {
        registeredCell1 *cell = [tableView dequeueReusableCellWithIdentifier:forgetidentfid1];
        if (!cell) {
            cell = [[registeredCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forgetidentfid1];
        }
        if (indexPath.row==1) {
            cell.messagetext.tag = 2;
            cell.messagetext.placeholder = @"请输入验证码";
        }
        if (indexPath.row==2) {
            cell.messagetext.tag = 3;
            cell.messagetext.placeholder = @"新密码";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.messagetext.delegate = self;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

#pragma mark - 实现方法

-(void)yanzhengma
{
    UITextField *text1 = [self.forgetTableview viewWithTag:1];

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

-(void)startTime{
    UIButton *getbtn = [self.forgetTableview viewWithTag:100];
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

-(void)getupdatapassword
{
    NSLog(@"修改提交");
    UITextField *text1 = [self.forgetTableview viewWithTag:1];
    UITextField *text2 = [self.forgetTableview viewWithTag:2];
    UITextField *text3 = [self.forgetTableview viewWithTag:3];
    
    NSDictionary *dic = @{@"phone":text1.text,@"code":text2.text,@"newPass":text3.text};
    [AFManager postReqURL:updatePassword reqBody:dic block:^(id infor) {
        NSLog(@"info = %@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"修改成功"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"验证码不正确"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==203)
        {
            [NSObject wj_showHUDWithTip:@"用户不存在"];
        }
        
    }];
}


-(void)keyboardHide
{
    UITextField *text1 = [self.forgetTableview viewWithTag:1];
    UITextField *text2 = [self.forgetTableview viewWithTag:2];
    UITextField *text3 = [self.forgetTableview viewWithTag:3];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
