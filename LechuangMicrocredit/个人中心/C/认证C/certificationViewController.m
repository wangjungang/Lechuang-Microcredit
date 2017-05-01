//
//  certificationViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "certificationViewController.h"
#import "certicationCell.h"
#import "myinfoViewController.h"
#import "contactViewController.h"
#import "myjobViewController.h"
#import "mymoreViewController.h"
#import "certifocaModel.h"
#import "phoneregisViewController.h"
@interface certificationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *certificationTableview;
@property (nonatomic,strong) NSMutableArray *leftimagearr;
@property (nonatomic,strong) NSMutableArray *namearray;
@property (nonatomic,strong) NSMutableArray *certifoarr;

@property (nonatomic,strong) NSString *cardstr;
@property (nonatomic,strong) NSString *contactstr;
@property (nonatomic,strong) NSString *morestr;
@property (nonatomic,strong) NSString *phonestr;
@property (nonatomic,strong) NSString *userinfostr;
@property (nonatomic,strong) NSString *workstr;
@property (nonatomic,strong) NSString *zfbstr;

@end
static NSString *certifocacell = @"certifocacell";
@implementation certificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"认证"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    self.certifoarr = [NSMutableArray array];
    [self loaddatafromweb];
    [self.view addSubview:self.certificationTableview];
    self.certificationTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    self.certificationTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}

-(void)loaddatafromweb
{
    self.leftimagearr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"个人"],[UIImage imageNamed:@"0"],[UIImage imageNamed:@"个人_07.21"],[UIImage imageNamed:@"支付宝"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"],nil];
    self.namearray = [NSMutableArray arrayWithObjects:@"个人信息(必填)",@"紧急联系人(必填)",@"收款银行卡(必填)",@"支付宝验证(必填)",@"工作信息(必填)",@"手机号认证(必填)",@"更多认证(必填)", nil];
    [AFManager getReqURL:[NSString stringWithFormat:authStatus,UID] block:^(id infor) {
        AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
        NSLog(@"info=======%@",infor);
        NSDictionary *status = [infor objectForKey:@"status"];
        NSLog(@"status=====%@",status);
        self.cardstr = [status objectForKey:@"card"];
        self.contactstr = [status objectForKey:@"contact"];
        self.morestr = [status objectForKey:@"more"];
        self.phonestr = [status objectForKey:@"phone"];
        self.userinfostr = [status objectForKey:@"userinfo"];
        self.workstr = [status objectForKey:@"work"];
        self.zfbstr = [status objectForKey:@"zfb"];
        
        [self.certificationTableview reloadData];
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark - getters

-(UITableView *)certificationTableview
{
    if(!_certificationTableview)
    {
        _certificationTableview = [[UITableView alloc] init];
        _certificationTableview.dataSource = self;
        _certificationTableview.delegate = self;
    }
    return _certificationTableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    certicationCell *cell = [tableView dequeueReusableCellWithIdentifier:certifocacell];
    if (!cell) {
        cell = [[certicationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:certifocacell];
    }
    if (indexPath.row==0) {
        if ([self.cardstr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.cardstr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.cardstr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.cardstr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
     
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 4)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 4)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==1) {
        if ([self.contactstr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.contactstr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.contactstr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.contactstr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 5)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 5)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==2) {
        if ([self.morestr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.morestr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.morestr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.morestr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 5)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 5)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==3) {
        if ([self.phonestr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.phonestr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.phonestr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.phonestr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 5)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 5)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==4) {
        if ([self.userinfostr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.userinfostr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.userinfostr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.userinfostr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 4)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 4)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==5) {
        if ([self.workstr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.workstr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.workstr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.workstr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 5)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 5)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    if (indexPath.row==6) {
        if ([self.zfbstr isEqualToString:@"0"]) {
            cell.typelabel.text = @"正在认证";
        }
        if ([self.zfbstr isEqualToString:@"1"]) {
            cell.typelabel.text = @"认证通过";
        }
        if ([self.zfbstr isEqualToString:@"2"]) {
            cell.typelabel.text = @"认证未通过";
        }
        if ([self.zfbstr isEqualToString:@"3"]) {
            cell.typelabel.text = @"未完善";
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.namearray[indexPath.row]];
        
        [str addAttribute:NSForegroundColorAttributeName  //文字颜色
                    value:[UIColor wjColorFloat:@"727272"]
                    range:NSMakeRange(0, 4)];
        [str addAttribute:NSFontAttributeName             //文字字体
                    value:[UIFont systemFontOfSize:18]
                    range:NSMakeRange(0, 4)];
        cell.namelabel.textColor = [UIColor wjColorFloat:@"FDA800"];
        cell.namelabel.font = [UIFont systemFontOfSize:13];
        cell.namelabel.attributedText = str;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.leftimage.image = self.leftimagearr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
    if (indexPath.row==0) {
        myinfoViewController *myinfoVC = [[myinfoViewController alloc] init];
        [self.navigationController pushViewController:myinfoVC animated:YES];
    }
    if (indexPath.row==1) {
        contactViewController *contactVC = [[contactViewController alloc] init];
        [self.navigationController pushViewController:contactVC animated:YES];
    }
    if (indexPath.row==2) {
        
    }
    if (indexPath.row==3) {
        NSLog(@"支付宝认证");
        [self doVerify:@""];
    }
    if (indexPath.row==4) {
        myjobViewController *myjobVC = [[myjobViewController alloc] init];
        [self.navigationController pushViewController:myjobVC animated:YES];
    }
    if (indexPath.row==5) {
        phoneregisViewController *phoneregisVC = [[phoneregisViewController alloc] init];
        [self.navigationController pushViewController:phoneregisVC animated:YES];
    }
    if (indexPath.row==6) {
        mymoreViewController *mymoreVC = [[mymoreViewController alloc] init];
        [self.navigationController pushViewController:mymoreVC animated:YES];
    }
}

//支付宝认证
- (void)doVerify:(NSString *)url {
    NSString *alipayUrl = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&url=%@", url];
    if ([self canOpenAlipay]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:alipayUrl] options:@{} completionHandler:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"是否下载并安装支付宝完成认证?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *appstoreUrl = @"itms-apps://itunes.apple.com/app/id333206289";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appstoreUrl] options:@{} completionHandler:nil];
    }
}

- (BOOL)canOpenAlipay {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]];
}
@end
