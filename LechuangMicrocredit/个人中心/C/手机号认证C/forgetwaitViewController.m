//
//  forgetwaitViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "forgetwaitViewController.h"
#import "LXSegmentScrollView.h"

#import "forgetwaitCell0.h"
#import "forgetwaitCell1.h"
@interface forgetwaitViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableview0;
@property (nonatomic,strong) UITableView *tableview1;
@property (nonatomic,strong) UITableView *tableview2;

@end
static NSString *cellid0 = @"cellid0";
static NSString *cellid1 = @"cellid1";
static NSString *cellid2 = @"cellid2";
static NSString *cellid3 = @"cellid3";
static NSString *cellid4 = @"cellid4";
static NSString *cellid5 = @"cellid5";

@implementation forgetwaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"重制密码"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    
    //iOS7新增属性
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    NSMutableArray *array=[NSMutableArray array];
    
    [array addObject:self.tableview0];
    [array addObject:self.tableview1];
    [array addObject:self.tableview2];
    
    LXSegmentScrollView *scView=[[LXSegmentScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) titleArray:@[@"移动",@"联通",@"电信"] contentViewArray:array];
    [self.view addSubview:scView];
    self.tableview0.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableview1.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableview2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - getters

-(UITableView *)tableview0
{
    if(!_tableview0)
    {
        _tableview0 = [[UITableView alloc] init];
        _tableview0.dataSource = self;
        _tableview0.delegate = self;
        _tableview0.scrollEnabled = NO;
    }
    return _tableview0;
}

-(UITableView *)tableview1
{
    if(!_tableview1)
    {
        _tableview1 = [[UITableView alloc] init];
        _tableview1.dataSource = self;
        _tableview1.delegate = self;
        _tableview1.scrollEnabled = NO;
    }
    return _tableview1;
}

-(UITableView *)tableview2
{
    if(!_tableview2)
    {
        _tableview2 = [[UITableView alloc] init];
        _tableview2.dataSource = self;
        _tableview2.delegate = self;
        _tableview2.scrollEnabled = NO;
    }
    return _tableview2;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableview0) {
        if (indexPath.section==0) {
            forgetwaitCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellid0];
            if (!cell) {
                cell = [[forgetwaitCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid0];
            }
            cell.messagelabel.text = @"联系10086运营客服进行设置";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell.submitbtn addTarget:self action:@selector(dadianhua0) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        if (indexPath.section==1) {
            forgetwaitCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
            if (!cell) {
                cell = [[forgetwaitCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
            }
            cell.label2.text = @"b,点击[我的移动]-[密码重置]";
            cell.label3.text = @"https://www.10086.com";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            return cell;
        }
    }
    if (tableView==self.tableview1) {
        if (indexPath.section==0) {
            forgetwaitCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
            if (!cell) {
                cell = [[forgetwaitCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid2];
            }
            cell.messagelabel.text = @"联系10010运营客服进行设置";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell.submitbtn addTarget:self action:@selector(dadianhua1) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        if (indexPath.section==1) {
            forgetwaitCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellid3];
            if (!cell) {
                cell = [[forgetwaitCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid3];
            }
            cell.label2.text = @"b,点击[我的联通]-[密码重置]";
            cell.label3.text = @"https://www.10010.com";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            return cell;
        }
    }if (tableView==self.tableview2) {
        if (indexPath.section==0) {
            forgetwaitCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellid4];
            if (!cell) {
                cell = [[forgetwaitCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid4];
            }
            cell.messagelabel.text = @"联系10000运营客服进行设置";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell.submitbtn addTarget:self action:@selector(dadianhua2) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        if (indexPath.section==1) {
            forgetwaitCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellid5];
            if (!cell) {
                cell = [[forgetwaitCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid5];
            }
            cell.label2.text = @"b,点击[我的电信]-[密码重置]";
            cell.label3.text = @"https://www.10000.com";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 150*HEIGHT_SCALE;
    }else
    {
        return 180*HEIGHT_SCALE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 拨打电话

-(void)dadianhua0
{
    NSString *allString = [NSString stringWithFormat:@"tel:10086"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}
-(void)dadianhua1
{
    NSString *allString = [NSString stringWithFormat:@"tel:10010"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}

-(void)dadianhua2
{
    NSString *allString = [NSString stringWithFormat:@"tel:10000"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}


@end
