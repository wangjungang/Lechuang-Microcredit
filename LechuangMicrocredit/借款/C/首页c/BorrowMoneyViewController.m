//
//  BorrowMoneyViewController.m
//  LechuangMicrocredit
//
//  Created by 张婷 on 16/12/5.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "BorrowMoneyViewController.h"
#import "mainview.h"
#import "TwoView.h"
#import "LastView.h"
#import "messageViewController.h"

#import "loginViewController.h"
#import "YContactsManager.h"
#import "YContactObject.h"
#import "homeTimeCell.h"

#import <SDCycleScrollView.h>
@interface BorrowMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    NSInteger daynum;
}
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UIImageView *maintopimage;
@property (nonatomic,strong) UIImageView *trumpetimage;
@property (nonatomic,strong) UILabel *announcementlabel;
@property (nonatomic,strong) mainview *grayview;
@property (nonatomic,strong) TwoView *twoview;
@property (nonatomic,strong) UIButton *requestbtn;
@property (nonatomic,strong) LastView *lastview;
@property (nonatomic,strong) UIButton *insurancebtn;
@property (nonatomic,strong) UIButton *regulatorybtn;

@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;//轮播器
@property (strong,nonatomic)NSArray *netImages;  //网络图片
//手机通讯录
@property (nonatomic, copy)NSArray <YContactObject *> *  contactObjects;
@property (nonatomic, strong) YContactsManager * contactManager;
@property (nonatomic,strong) NSMutableDictionary *addressdic;
@property (nonatomic,strong) NSMutableDictionary *addressdit;

@property (nonatomic,strong) UITableView *homeTableView;

@property (nonatomic,strong) NSString *starttimestr;
@property (nonatomic,strong) NSString *returntimestr;
@end
static NSString *homeidentfid = @"homeidentfid";
@implementation BorrowMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"首页"];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self loginclick];
    };
    
    [self.view addSubview:customNavView];
    [self.view addSubview:self.rightbtn];
    [self.view addSubview:self.homeTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (UID==nil) {
        //[self loginclick];
        NSLog(@"请登录");
    }
    else {
        //提交用户通讯录到服务器----相当霸道，慎重
        //[self getaddressbook];
        NSLog(@"用户已经登录");
         [self refresh];
    }
    [self ScrollNetWorkImages];
    //[self.cycleScrollView adjustWhenControllerViewWillAppera];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    self.rightbtn.frame = CGRectMake(DEVICE_WIDTH-30, 30, 20, 15);
    self.trumpetimage.frame = CGRectMake(30/2, 330/2*HEIGHT_SCALE+15*HEIGHT_SCALE, 32/2, 34/2*HEIGHT_SCALE);
    self.announcementlabel.frame = CGRectMake(40, 330/2*HEIGHT_SCALE+15*HEIGHT_SCALE, DEVICE_WIDTH-60, 20*HEIGHT_SCALE);
    self.grayview.frame = CGRectMake(40, 310/2*HEIGHT_SCALE+64*HEIGHT_SCALE, DEVICE_WIDTH-80, 130*HEIGHT_SCALE);
    self.twoview.frame = CGRectMake(10, 345*HEIGHT_SCALE, DEVICE_WIDTH-20, 60*HEIGHT_SCALE);
    self.requestbtn.frame = CGRectMake(40, 440*HEIGHT_SCALE, DEVICE_WIDTH-80, 50*HEIGHT_SCALE);
    self.insurancebtn.frame = CGRectMake(DEVICE_WIDTH/2-120, 510*HEIGHT_SCALE, 100, 30*HEIGHT_SCALE);
    self.regulatorybtn.frame = CGRectMake(DEVICE_WIDTH/2+20, 510*HEIGHT_SCALE, 100, 30*HEIGHT_SCALE);    
}

-(void)refresh
{
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.homeTableView.mj_header endRefreshing];
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loaddatafromweb)];
    
    // 马上进入刷新状态
     [self.homeTableView.mj_header beginRefreshing];
}

-(void)loaddatafromweb
{

    [AFManager getReqURL:[NSString stringWithFormat:homeindex,UID] block:^(id infor) {
        NSLog(@"info=====%@",infor);
        NSString *auth = [infor objectForKey:@"auth"];
        NSLog(@"auth======%@",auth);
        NSString *credit = [infor objectForKey:@"credit"];
        NSLog(@"credit=====%@",credit);
        self.grayview.certificationlabel.text = [NSString stringWithFormat:@"%@%@%@",@"认证",auth,@"/5"];
        self.grayview.pricenumlabel.text = credit;
        NSDictionary *data = [infor objectForKey:@"data"];
        
        if (data==nil||data==NULL) {
            //允许借款
            self.twoview.addbtn.userInteractionEnabled = YES;
            self.twoview.delbtn.userInteractionEnabled = YES;
            self.requestbtn.userInteractionEnabled = YES;
            self.twoview.daynumlabel.text = @"1";
            self.twoview.accountpricelabel.text = @"850";
            self.twoview.returnpricelabel.text = @"1000";
            [self nowtime];
            [self lasttime:1];
        }else
        {
 
            //不允许借款
            self.twoview.addbtn.userInteractionEnabled = NO;
            self.twoview.delbtn.userInteractionEnabled = NO;
            self.requestbtn.userInteractionEnabled = NO;
            self.twoview.daynumlabel.text = data[@"days"];
            self.twoview.accountpricelabel.text = data[@"toamount"];
            self.twoview.returnpricelabel.text = data[@"alsoamount"];
            self.starttimestr = data[@"time"];
            self.returntimestr = data[@"alsotime"];
        }
        
        [self.homeTableView reloadData];
        [self.homeTableView.mj_header endRefreshing];
    } errorblock:^(NSError *error) {
        [self.homeTableView.mj_header endRefreshing];
        [NSObject wj_showHUDWithTip:@"请检查网络"];
    }];
}

-(void)getaddressbook
{
    self.contactManager = [YContactsManager shareInstance];
    
    
    __weak typeof(self) copy_self = self;
    //开始请求
    [self.contactManager requestContactsComplete:^(NSArray<YContactObject *> * _Nonnull contacts) {
        
        copy_self.contactObjects = contacts;
        
        self.addressdic = [NSMutableDictionary dictionary];
        for (int i = 0; i<self.contactObjects.count; i++) {
            YContactObject * contactObject = [self.contactObjects objectAtIndex:i];
            NSString *name = contactObject.nameObject.name;
            NSString *phone = contactObject.phoneObject.firstObject.phoneNumber;
            //        NSLog(@"name=======%@",contactObject.nameObject.name);
            //        NSLog(@"phone=======%@",contactObject.phoneObject.firstObject.phoneNumber);
            [self.addressdic setValue:phone forKey:name];
            //[self.dic setObject:phone forKey:name];
        }
        NSLog(@"dic=====%@",_addressdic);
        self.addressdit = [NSMutableDictionary dictionaryWithObject:UID forKey:@"uid"];
        [self.addressdit setValue:self.addressdic forKey:@"AddressBook"];
        
        NSLog(@"dit===========%@",self.addressdit);
        
        NSString *jsonstr = [[NSString alloc] init];
        if ([NSJSONSerialization isValidJSONObject:self.addressdit]) {
            NSError *error;
            NSLog(@"error===%@",error);
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.addressdit options:NSJSONWritingPrettyPrinted error:nil];
        jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonstr=====%@",jsonstr);
        
        NSDictionary *getdic = @{@"contact":jsonstr};
        
        NSLog(@"getdic=====%@",getdic);
        [AFManager postReqURL:getContact reqBody:getdic block:^(id infor) {
            NSLog(@"info====%@",infor);
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                NSLog(@"success");
            }
            
        }];
        
    }];
    

}

#pragma mark - getters

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"首页_03"] forState:normal];
        [_rightbtn addTarget:self action:@selector(rightbtnclick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightbtn;
}

-(UIImageView *)trumpetimage
{
    if(!_trumpetimage)
    {
        _trumpetimage = [[UIImageView alloc] init];
        _trumpetimage.image = [UIImage imageNamed:@"首页_09"];
    }
    return _trumpetimage;
}

-(UILabel *)announcementlabel
{
    if(!_announcementlabel)
    {
        _announcementlabel = [[UILabel alloc] init];
        _announcementlabel.text = @"公告公告公告公告公告";
        _announcementlabel.backgroundColor = [UIColor redColor];
    }
    return _announcementlabel;
}

-(mainview *)grayview
{
    if(!_grayview)
    {
        _grayview = [[mainview alloc] init];
        _grayview.backgroundColor = [UIColor wjColorFloat:@"f5f5f5"];
        _grayview.layer.masksToBounds = YES;
        _grayview.layer.cornerRadius = 10;
        [_grayview.ascensionbtn addTarget:self action:@selector(tishenedubtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _grayview;
}

-(TwoView *)twoview
{
    if(!_twoview)
    {
        _twoview = [[TwoView alloc] init];
        [_twoview.addbtn addTarget:self action:@selector(adddaybtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_twoview.delbtn addTarget:self action:@selector(deldaybtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoview;
}

-(UIButton *)requestbtn
{
    if(!_requestbtn)
    {
        _requestbtn = [[UIButton alloc] init];
        _requestbtn.backgroundColor = [UIColor wjColorFloat:@"39A0DB"];
        _requestbtn.layer.masksToBounds = YES;
        _requestbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
        [_requestbtn setTitle:@"立即申请" forState:normal];
        [_requestbtn addTarget:self action:@selector(requestbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _requestbtn;
}

-(LastView *)lastview
{
    if(!_lastview)
    {
        _lastview = [[LastView alloc] init];
        _lastview.layer.masksToBounds = YES;
        _lastview.layer.borderWidth = 1;
        _lastview.layer.borderColor = [UIColor wjColorFloat:@"e0e0e0"].CGColor;
    }
    return _lastview;
}


-(UIButton *)insurancebtn
{
    if(!_insurancebtn)
    {
        _insurancebtn = [[UIButton alloc] init];
        [_insurancebtn setTitle:@"账户保险" forState:normal];
        [_insurancebtn setTitleColor:[UIColor wjColorFloat:@"FD9B6C"] forState:normal];
        _insurancebtn.layer.masksToBounds = YES;
        _insurancebtn.layer.cornerRadius = 15*HEIGHT_SCALE;
        _insurancebtn.layer.borderWidth = 2;
        _insurancebtn.layer.borderColor = [UIColor wjColorFloat:@"FD9B6C"].CGColor;
        [_insurancebtn addTarget:self action:@selector(insurancebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _insurancebtn;
}

-(UIButton *)regulatorybtn
{
    if(!_regulatorybtn)
    {
        _regulatorybtn = [[UIButton alloc] init];
        [_regulatorybtn setTitle:@"银行监管" forState:normal];
        [_regulatorybtn setTitleColor:[UIColor wjColorFloat:@"FD9B6C"] forState:normal];
        _regulatorybtn.layer.masksToBounds = YES;
        _regulatorybtn.layer.cornerRadius = 15*HEIGHT_SCALE;
        _regulatorybtn.layer.borderWidth = 2;
        _regulatorybtn.layer.borderColor = [UIColor wjColorFloat:@"FD9B6C"].CGColor;
        [_regulatorybtn addTarget:self action:@selector(regulatorybtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regulatorybtn;
}


-(UITableView *)homeTableView
{
    if(!_homeTableView)
    {
        CGRect rect = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-74);
        _homeTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
        UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        [headview addSubview:self.cycleScrollView];
        [headview addSubview:self.trumpetimage];
        [headview addSubview:self.announcementlabel];
        [headview addSubview:self.grayview];
        [headview addSubview:self.twoview];
        [headview addSubview:self.requestbtn];
        [headview addSubview:self.lastview];
        [headview addSubview:self.insurancebtn];
        [headview addSubview:self.regulatorybtn];
        
        headview.tag = 10000;
        _homeTableView.tableHeaderView = headview;
    }
    return _homeTableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeidentfid];
    if (!cell) {
        cell = [[homeTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.namelabel.text = @"起始日期";
        cell.timelabel.text = self.starttimestr;
    }
    if (indexPath.row==1) {
        cell.namelabel.text = @"截止日期";
        cell.timelabel.text = self.returntimestr;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 实现方法

-(void)rightbtnclick
{
    NSLog(@"rightbtnclick");
    NSLog(@"uid-------%@",UID);
    messageViewController *messageVC = [[messageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

-(void)tishenedubtnclick
{
    NSLog(@"提升额度");
}

-(void)adddaybtnclick
{
    NSInteger days = [self.twoview.daynumlabel.text intValue]+1;
    self.twoview.daynumlabel.text = [NSString stringWithFormat:@"%ld",days];
    [self lasttime:days];
}

-(void)deldaybtnclick
{
    NSInteger days = [self.twoview.daynumlabel.text intValue];
    if (days>1) {
        days--;
    }
    [self lasttime:days];
     self.twoview.daynumlabel.text = [NSString stringWithFormat:@"%ld",days];
}

-(void)requestbtnclick
{
    NSLog(@"立即申请");
    NSString *amount = self.twoview.returnpricelabel.text;
    NSString *toamount = self.twoview.accountpricelabel.text;
    NSString *days = self.twoview.daynumlabel.text;
    if (amount!=nil) {
        NSDictionary *dit = @{@"uid":UID,@"amount":amount,@"toamount":toamount,@"days":days};
        NSLog(@"dit-------%@",dit);
        [AFManager postReqURL:borrowMoney reqBody:dit block:^(id infor) {
            NSLog(@"info====%@",infor);
            
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                [NSObject wj_showHUDWithTip:@"申请成功"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==201)
            {
                [NSObject wj_showHUDWithTip:@"信息填写有误"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==202)
            {
                [NSObject wj_showHUDWithTip:@"信息审核没通过"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==203)
            {
                [NSObject wj_showHUDWithTip:@"没有填写收款卡号"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==204)
            {
                [NSObject wj_showHUDWithTip:@"上次借款金额没还"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==205)
            {
                [NSObject wj_showHUDWithTip:@"通讯录人数不足"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==206)
            {
                [NSObject wj_showHUDWithTip:@"手机号认证没有通过"];
            }
            if ([[infor objectForKey:@"code"]integerValue]==207)
            {
                [NSObject wj_showHUDWithTip:@"支付宝验证没有通过"];
            }
        }];

    }
}

-(void)insurancebtnclick
{
    NSLog(@"账户保险");
}

-(void)regulatorybtnclick
{
    NSLog(@"银行监管");
}

-(void)loginclick
{
    loginViewController *loginVC = [[loginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - 时间计算方法

-(void)lasttime:(NSInteger )day
{
    NSInteger dis = day; //前后的天数
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;

    if(dis!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:s
        NSString *currentTime = [formatter stringFromDate:theDate];
        self.returntimestr = currentTime;
        [self.homeTableView reloadData];
    }
    else
    {
        theDate = nowDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:s
        NSString *currentTime = [formatter stringFromDate:theDate];
        self.returntimestr = currentTime;
        [self.homeTableView reloadData];
    }

}

-(void)nowtime
{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    theDate = nowDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:s
    NSString *currentTime = [formatter stringFromDate:theDate];
    NSLog(@"%@", currentTime);
    self.starttimestr = currentTime;
    [self.homeTableView reloadData];
}

-(void)ScrollNetWorkImages{
    
    CGRect rect = CGRectMake(0,0, self.view.bounds.size.width, 330/2*HEIGHT_SCALE);
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"首页_06"]];
    self.netImages = @[
                   @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
                   @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
                   @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
                   @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
                   ];
    //设置网络图片数组
    self.cycleScrollView.imageURLStringsGroup = self.netImages;
    
    //设置图片视图显示类型
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    //设置轮播视图的分页控件的显示
    self.cycleScrollView.showPageControl = YES;
    
    //设置轮播视图分也控件的位置
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    //当前分页控件小圆标图片
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageCon.png"];
    
    //其他分页控件小圆标图片
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageConSel.png"];
    
    self.cycleScrollView.autoScrollTimeInterval = 2;
    
    self.cycleScrollView.autoScroll = YES;
    
    UIView *view = [self.homeTableView viewWithTag:10000];
    [view addSubview:self.cycleScrollView];
    
}

@end
