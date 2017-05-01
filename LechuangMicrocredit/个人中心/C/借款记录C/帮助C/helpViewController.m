//
//  helpViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "helpViewController.h"
#import "XDMultTableView.h"
@interface helpViewController ()<XDMultTableViewDatasource,XDMultTableViewDelegate>
@property (nonatomic,strong) XDMultTableView *helptableview;
@end

@implementation helpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"帮助"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.helptableview];
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
}

#pragma mark - getters

-(XDMultTableView *)helptableview
{
    if(!_helptableview)
    {
        _helptableview = [[XDMultTableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        _helptableview.datasource = self;
        _helptableview.delegate = self;
        _helptableview.openSectionArray = [NSArray arrayWithObjects:@0,@1, nil];
        _helptableview.autoAdjustOpenAndClose = NO;
    }
    return _helptableview;
}

#pragma mark -XDMultTableViewDatasource&&XDMultTableViewDelegate

- (NSInteger)mTableView:(XDMultTableView *)mTableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (XDMultTableViewCell *)mTableView:(XDMultTableView *)mTableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIView *view = [[UIView alloc] initWithFrame:cell.bounds] ;
    view.layer.backgroundColor  = [UIColor whiteColor].CGColor;
    view.layer.masksToBounds    = YES;
    view.layer.borderWidth      = 0.3;
    view.layer.borderColor      = [UIColor lightGrayColor].CGColor;
    
    cell.backgroundView = view;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(XDMultTableView *)mTableView{
    return 6;
}

-(NSString *)mTableView:(XDMultTableView *)mTableView titleForHeaderInSection:(NSInteger)section{
    return @"我是头部";
}

#pragma mark - delegate
- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)mTableView:(XDMultTableView *)mTableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (void)mTableView:(XDMultTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section{
    NSLog(@"即将展开");
}


- (void)mTableView:(XDMultTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section{
    NSLog(@"即将关闭");
}

- (void)mTableView:(XDMultTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击cell");
}


@end
