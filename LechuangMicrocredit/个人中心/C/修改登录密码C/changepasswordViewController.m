//
//  changepasswordViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "changepasswordViewController.h"
#import "changepasswordCell.h"
#import "forgetpassViewController.h"
@interface changepasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *changetableview;
@property (nonatomic,strong) UIButton *finishbtn;
@property (nonatomic,strong) UILabel *promptlabel;
@end
static NSString *changepasswordidentfid = @"changepasswordidentfid";
@implementation changepasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.changetableview addGestureRecognizer:TapGestureTecognizer];
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"忘记" title:@"修改登录密码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self forgetpassword];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.changetableview];
    [self.view addSubview:self.finishbtn];
    [self.view addSubview:self.promptlabel];
    self.changetableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.changetableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    
    self.promptlabel.frame = CGRectMake(DEVICE_WIDTH/2-110*HEIGHT_SCALE, 64+200*HEIGHT_SCALE, 220*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.finishbtn.frame = CGRectMake(40, 64+230*HEIGHT_SCALE, DEVICE_WIDTH-80, 50);
}

#pragma mark - getters

-(UITableView *)changetableview
{
    if(!_changetableview)
    {
        _changetableview = [[UITableView alloc] init];
        _changetableview.dataSource = self;
        _changetableview.delegate = self;
    }
    return _changetableview;
}

-(UIButton *)finishbtn
{
    if(!_finishbtn)
    {
        _finishbtn = [[UIButton alloc] init];
        _finishbtn.backgroundColor = [UIColor wjColorFloat:@"168DCC"];
        _finishbtn.layer.masksToBounds = YES;
        _finishbtn.layer.cornerRadius = 25;
        [_finishbtn setTitle:@"完成" forState:normal];
        [_finishbtn addTarget:self action:@selector(finishbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishbtn;
}

-(UILabel *)promptlabel
{
    if(!_promptlabel)
    {
        _promptlabel = [[UILabel alloc] init];
        _promptlabel.text = @"登录密码为6～16位字符，区分大小写";
        _promptlabel.font = [UIFont systemFontOfSize:12];
        _promptlabel.textColor = [UIColor wjColorFloat:@"C5C5C5"];
        _promptlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _promptlabel;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    changepasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:changepasswordidentfid];
    if (!cell) {
        cell = [[changepasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changepasswordidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messagetext.delegate = self;
    if (indexPath.row==0) {
        cell.messagetext.placeholder = @"请输入原始密码";
        cell.messagetext.tag = 1;
    }
    if (indexPath.row==1) {
        cell.messagetext.placeholder = @"请输入新密码";
        cell.messagetext.tag = 2;
    }
    if (indexPath.row==2) {
        cell.messagetext.placeholder = @"请输入新密码";
        cell.messagetext.tag = 3;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 实现方法

-(void)keyboardHide
{
    UITextField *text1 = [self.changetableview viewWithTag:1];
    UITextField *text2 = [self.changetableview viewWithTag:2];
    UITextField *text3 = [self.changetableview viewWithTag:3];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

-(void)forgetpassword
{
    NSLog(@"忘记");
    forgetpassViewController *forgetVC = [[forgetpassViewController alloc] init];
    forgetVC.type = @"set";
    [self.navigationController pushViewController:forgetVC animated:YES];
}

-(void)finishbtnclick
{
    NSLog(@"完成");
    UITextField *text1 = [self.changetableview viewWithTag:1];
    UITextField *text2 = [self.changetableview viewWithTag:2];
    UITextField *text3 = [self.changetableview viewWithTag:3];
    if ([text2.text isEqualToString:text3.text]&&text1.text!=nil) {
        NSDictionary *dic = @{@"oldPass":text1.text,@"newPass":text2.text,@"uid":UID};
        [AFManager postReqURL:userPassUpdate reqBody:dic block:^(id infor) {
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                [NSObject wj_showHUDWithTip:@"修改成功"];
                
            }
            if ([[infor objectForKey:@"code"]integerValue]==201)
            {
                [NSObject wj_showHUDWithTip:@"旧密码不正确"];
                
            }
            if ([[infor objectForKey:@"code"]integerValue]==203)
            {
                [NSObject wj_showHUDWithTip:@"新密码与原密码不能相同"];
                
            }
            if ([[infor objectForKey:@"code"]integerValue]==204)
            {
                [NSObject wj_showHUDWithTip:@"用户不存在"];
                
            }
            if ([[infor objectForKey:@"code"]integerValue]==205)
            {
                [NSObject wj_showHUDWithTip:@"新密码不能为空"];
                
            }
            
        }];

    }
    else if(text1.text==nil)
    {
        [NSObject wj_showHUDWithTip:@"原始密码不能为空"];
    }
    else if (text2.text!=text3.text)
    {
        [NSObject wj_showHUDWithTip:@"两次输入的新密码不一致"];
    }
    
   
}
@end
