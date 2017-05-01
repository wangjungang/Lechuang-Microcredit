//
//  mymoreViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "mymoreViewController.h"
#import "mymoreCell.h"
@interface mymoreViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UITableView *mymoretableview;
@end
static NSString *mymoreidentfid = @"mymoreidentfid";
@implementation mymoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.mymoretableview addGestureRecognizer:TapGestureTecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"更多认证"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self saveclick];
    };
    [self.view addSubview:self.mymoretableview];
    self.mymoretableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mymoretableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    
}


#pragma mark - getters

-(UITableView *)mymoretableview
{
    if(!_mymoretableview)
    {
        _mymoretableview = [[UITableView alloc] init];
        _mymoretableview.dataSource = self;
        _mymoretableview.delegate = self;
    }
    return _mymoretableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mymoreCell *cell = [tableView dequeueReusableCellWithIdentifier:mymoreidentfid];
    if (!cell) {
        cell = [[mymoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mymoreidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.messagetext.delegate = self;
    if (indexPath.row==0) {
        cell.leftlabel.text = @"淘宝账号";
        cell.messagetext.placeholder = @"请输入个人淘宝账号";
        cell.messagetext.tag = 1;
    }
    if (indexPath.row==1) {
        cell.leftlabel.text = @"常用邮箱";
        cell.messagetext.placeholder = @"请输入常用邮箱";
        cell.messagetext.keyboardType = UIKeyboardTypeEmailAddress;
        cell.messagetext.tag = 2;
    }
    if (indexPath.row==2) {
        cell.leftlabel.text = @"QQ账号";
        cell.messagetext.placeholder = @"请输入QQ账户";
        cell.messagetext.tag = 3;
    }
    if (indexPath.row==3) {
        cell.leftlabel.text = @"微信账号";
        cell.messagetext.placeholder = @"请输入微信账号";
        cell.messagetext.tag = 4;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}
#pragma mark - 实现方法

-(void)keyboardHide
{
    UITextField *text1 = [self.mymoretableview viewWithTag:1];
    UITextField *text2 = [self.mymoretableview viewWithTag:2];
    UITextField *text3 = [self.mymoretableview viewWithTag:3];
    UITextField *text4 = [self.mymoretableview viewWithTag:4];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
}

-(void)saveclick
{
    NSLog(@"保存");
    UITextField *text1 = [self.mymoretableview viewWithTag:1];
    UITextField *text2 = [self.mymoretableview viewWithTag:2];
    UITextField *text3 = [self.mymoretableview viewWithTag:3];
    UITextField *text4 = [self.mymoretableview viewWithTag:4];
    
    NSDictionary *dic = @{@"uid":UID,@"QQ":text1.text,@"email":text2.text,@"taobao":text3.text,@"WeChat":text4.text};
    [AFManager postReqURL:addmore reqBody:dic block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"设置成功"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
