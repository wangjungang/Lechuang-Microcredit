//
//  mybonusViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "mybonusViewController.h"
#import "myboundstitleView.h"
#import "myboundsCell.h"
@interface mybonusViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) myboundstitleView *titleview;
@property (nonatomic,strong) UITableView *myboundstableview;
@end
static NSString *boundsidentfid = @"boundsidentfid";
@implementation mybonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"奖金"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleview];
    [self.view addSubview:self.myboundstableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleview.frame = CGRectMake(0, 64, DEVICE_WIDTH, 30);
    self.myboundstableview.frame = CGRectMake(0, 94, DEVICE_WIDTH, DEVICE_HEIGHT-94);
}

#pragma mark - getters

-(myboundstitleView *)titleview
{
    if(!_titleview)
    {
        _titleview = [[myboundstitleView alloc] init];
        _titleview.backgroundColor = [UIColor wjColorFloat:@"FEF0C1"];
    }
    return _titleview;
}

-(UITableView *)myboundstableview
{
    if(!_myboundstableview)
    {
        _myboundstableview = [[UITableView alloc] init];
        _myboundstableview.dataSource = self;
        _myboundstableview.delegate = self;
        _myboundstableview.separatorStyle = NO;
    }
    return _myboundstableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myboundsCell *cell = [tableView dequeueReusableCellWithIdentifier:boundsidentfid];
    if (!cell) {
        cell = [[myboundsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:boundsidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 170*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
}

@end
