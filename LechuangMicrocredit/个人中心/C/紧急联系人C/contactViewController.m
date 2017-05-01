//
//  contactViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "contactViewController.h"
#import "contactCell0.h"
#import "contactCell1.h"
@interface contactViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,contactdelegate>
@property (nonatomic,strong) UITableView *contacttableview;
@property (nonatomic,strong) NSMutableArray *firstarr;
@property (nonatomic,strong) NSMutableArray *secondarr;
@property (nonatomic,strong) NSString *familyid;
@property (nonatomic,strong) NSString *friendid;
@end
static NSString *contactidentfid = @"contactidentfid";
static NSString *contactidentfid1 = @"contactidentfid1";
static NSString *contactidentfid2 = @"contactidentfid2";
static NSString *contactidentfid3 = @"contactidentfid3";
@implementation contactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.contacttableview addGestureRecognizer:TapGestureTecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"紧急联系人"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self saveclick];
    };
    self.firstarr = [NSMutableArray arrayWithObjects:@"父母",@"朋友", nil];
    self.secondarr = [NSMutableArray arrayWithObjects:@"姐/弟妹",@"同学", nil];
    [self.view addSubview:self.contacttableview];
    self.contacttableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.contacttableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}

#pragma mark - getters

-(UITableView *)contacttableview
{
    if(!_contacttableview)
    {
        _contacttableview = [[UITableView alloc] init];
        _contacttableview.dataSource = self;
        _contacttableview.delegate = self;
        _contacttableview.scrollEnabled = NO;
    }
    return _contacttableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else
    {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            contactCell0 *cell = [tableView dequeueReusableCellWithIdentifier:contactidentfid];
            if (!cell) {
                cell = [[contactCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactidentfid];
            }
            cell.leftlabel.text = @"与本人关系";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell.firstbtn setTitle:self.firstarr[indexPath.section] forState:normal];
            [cell.secondbtn setTitle:self.secondarr[indexPath.section] forState:normal];
            cell.firstbtn.tag = 11;
            cell.secondbtn.tag = 12;
            cell.delegate = self;
            return cell;
        }
        if (indexPath.row==1) {
            contactCell1 *cell = [tableView dequeueReusableCellWithIdentifier:contactidentfid1];
            if (!cell) {
                cell = [[contactCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactidentfid1];
            }
            cell.leftlabel.text = @"紧急联系人";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            cell.mobiletext.delegate = self;
            cell.mobiletext.tag = 1;
            return cell;
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            contactCell0 *cell = [tableView dequeueReusableCellWithIdentifier:contactidentfid3];
            if (!cell) {
                cell = [[contactCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactidentfid3];
            }
            cell.leftlabel.text = @"与本人关系";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell.firstbtn setTitle:self.firstarr[indexPath.section] forState:normal];
            [cell.secondbtn setTitle:self.secondarr[indexPath.section] forState:normal];
            cell.firstbtn.tag = 13;
            cell.secondbtn.tag = 14;
            cell.delegate = self;
            return cell;
        }
        if (indexPath.row==1) {
            contactCell1 *cell = [tableView dequeueReusableCellWithIdentifier:contactidentfid3];
            if (!cell) {
                cell = [[contactCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contactidentfid3];
            }
            cell.leftlabel.text = @"紧急联系人";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            cell.mobiletext.delegate = self;
            cell.mobiletext.tag = 2;
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

#pragma mark - 实现方法

-(void)firstClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.contacttableview indexPathForCell:cell];
    UIButton *firstbtn0 = [self.contacttableview viewWithTag:11];
    UIButton *secontbtn0 = [self.contacttableview viewWithTag:12];
    UIButton *firsetbtn1 = [self.contacttableview viewWithTag:13];
    UIButton *secontbtn1 = [self.contacttableview viewWithTag:14];
    if (index.section==0) {
        firstbtn0.backgroundColor = [UIColor wjColorFloat:@"FD8C31"];
        secontbtn0.backgroundColor = [UIColor wjColorFloat:@"3AA0DB"];
        self.familyid = @"1";
        NSLog(@"id=========%@",self.familyid);
    }
    if (index.section==1) {
        firsetbtn1.backgroundColor = [UIColor wjColorFloat:@"FD8C31"];
        secontbtn1.backgroundColor = [UIColor wjColorFloat:@"3AA0DB"];
        self.friendid = @"3";
        NSLog(@"id==========%@",self.friendid);
    }
}

-(void)secondClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.contacttableview indexPathForCell:cell];
    UIButton *firstbtn0 = [self.contacttableview viewWithTag:11];
    UIButton *secontbtn0 = [self.contacttableview viewWithTag:12];
    UIButton *firsetbtn1 = [self.contacttableview viewWithTag:13];
    UIButton *secontbtn1 = [self.contacttableview viewWithTag:14];
    if (index.section==0) {
        secontbtn0.backgroundColor = [UIColor wjColorFloat:@"FD8C31"];
        firstbtn0.backgroundColor =[UIColor wjColorFloat:@"3AA0DB"];
        self.familyid = @"2";
        NSLog(@"id=========%@",self.familyid);
    }
    if (index.section==1) {
        secontbtn1.backgroundColor = [UIColor wjColorFloat:@"FD8C31"];
        firsetbtn1.backgroundColor =[UIColor wjColorFloat:@"3AA0DB"];
        self.friendid = @"4";
        NSLog(@"id==========%@",self.friendid);
    }
}

-(void)saveclick
{
    NSLog(@"保存");
    UITextField *text1 = [self.contacttableview viewWithTag:1];
    UITextField *text2 = [self.contacttableview viewWithTag:2];
    NSDictionary *dic = @{@"uid":UID,@"familyPhone":text1.text,@"familyid":self.familyid,@"friendid":self.friendid,@"friendPhone":text2.text};
    [AFManager postReqURL:contact reqBody:dic block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"设置成功"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"设置失败，请检查输入信息"];
        }

    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    UITextField *text1 = [self.contacttableview viewWithTag:1];
    UITextField *text2 = [self.contacttableview viewWithTag:2];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}
@end
