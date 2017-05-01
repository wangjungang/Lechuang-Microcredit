//
//  messageViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "messageViewController.h"
#import "messageCell.h"
#import "messageModel.h"
@interface messageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *messagetableview;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) messageModel *model;
@end
static NSString *messageidentfid = @"messageidentfid";
@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"消息中心"];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:customNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray=[NSMutableArray array];
    
    [self loaddatafromweb];
    [self.view addSubview:self.messagetableview];
    self.messagetableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    self.messagetableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    
}

-(void)loaddatafromweb
{
    [AFManager getReqURL:messagelist block:^(id infor) {
        NSLog(@"info====%@",infor);
       if ([[infor objectForKey:@"code"]integerValue]==200)
       {
           NSArray *dit = [infor objectForKey:@"data"];
           for (int i = 0; i<dit.count; i++) {
               NSDictionary *dicarr = [dit objectAtIndex:i];
               self.model = [[messageModel alloc] init];
               
               NSString *title = [NSString stringWithFormat:@"%@",dicarr[@"title"]];
               NSString *time =[NSString stringWithFormat:@"%@",dicarr[@"addtime"]];
               if ([title isKindOfClass:[NSNull class]]) {
                   self.model.titlestr = @"无";
               }
               else
               {
                   self.model.titlestr = title;
               }
               self.model.pictureurl = dicarr[@"picture"];
               self.model.addtimestr = time;
               [self.dataArray addObject:self.model];
           }
           [self.messagetableview reloadData];
       }
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark - gettters

-(UITableView *)messagetableview
{
    if(!_messagetableview)
    {
        _messagetableview = [[UITableView alloc] init];
        _messagetableview.dataSource = self;
        _messagetableview.delegate = self;
    }
    return _messagetableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    messageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageidentfid];
    if (!cell) {
        cell = [[messageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageidentfid];
    }
    [cell setCellDate:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
}

@end
