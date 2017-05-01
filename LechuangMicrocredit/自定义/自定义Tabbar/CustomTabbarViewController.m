//
//  CustomTabbarViewController.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/1.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import "CustomNavigation.h"
//借款
#import "BorrowMoneyViewController.h"
//还款
#import "RepaymentMoneyViewController.h"
#import "PersonalCenterViewController.h"
#define TABBARBUTTON_WIDTH 20
#define TITLELABELWIDTH 50
#define TITLELABELHEIGHT 10
@interface CustomTabbarViewController ()
{
    NSMutableArray *_norImageArray;
    NSMutableArray *_selImageArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_labelArray;
    UIButton *_selectedButton;
    UIView *_bgView;
    int _hightLightValue;
    
}
//@property (nonatomic,strong)HWAlertView *alertView;
@property (nonatomic,strong)UIView *adView;
@property (nonatomic,strong)UIImageView*adImageView;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *lookBtn;
@end

@implementation CustomTabbarViewController
//
static CustomTabbarViewController *tabbar;
+ (id)instanceTabBar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbar=[[CustomTabbarViewController alloc]init];
    });
    return tabbar;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    // Do any additional setup after loading the view.
    self.tabBar.hidden=YES;
    
    //tabbar正常情况下图片数组
    _norImageArray = [[NSMutableArray alloc] initWithObjects:@"tabbar-01.png",@"tabbar-02.png",@"tabbar-03.png", nil];
    //选种情况下图片数组 注：f-3选中和未选中状态图片一样
    _selImageArray = [[NSMutableArray alloc] initWithObjects:@"tabbar-sel01.png",@"tabbar-sel02.png",@"tabbar-sel03", nil];
    _titleArray = [[NSMutableArray alloc] initWithObjects:@"借款",@"还款",@"个人中心", nil];
    
    _labelArray = [[NSMutableArray alloc] init];
    //
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[BorrowMoneyViewController alloc] init]];
    
    //
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[RepaymentMoneyViewController alloc] init]];
    //
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[[PersonalCenterViewController alloc] init]];

    nav1.navigationBar.hidden = YES;
    nav2.navigationBar.hidden = YES;
    nav3.navigationBar.hidden = YES;
    self.viewControllers = @[nav1,nav2,nav3];
    
    
    [self createMyCustomTabbar];
}
-(void)createMyCustomTabbar
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT - 49, DEVICE_WIDTH, 49 )];
    
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgView];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lineLabel.backgroundColor = kCOLOR(175, 175, 175, 1);
    [_bgView addSubview:lineLabel];

    for (int i = 0 ; i < _titleArray.count; i++)
    {
        UIButton *tabbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarButton.frame = CGRectMake(WIDTH_SCALE *(20 + i*(55 + 15)), 0, 55*WIDTH_SCALE,49);
        tabbarButton.tag = i + 10;
        [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0)
        {
            tabbarButton.selected = YES;
            _selectedButton = tabbarButton;
            tabbarButton.frame = CGRectMake(WIDTH_SCALE *45, 0, 55*WIDTH_SCALE,49);
        }
        if (i == 1)
        {
            tabbarButton.frame = CGRectMake(DEVICE_WIDTH/2 -55 *WIDTH_SCALE/2, 0, 55*WIDTH_SCALE,49);
        }
        if (i == 2)
        {
            tabbarButton.frame = CGRectMake(DEVICE_WIDTH -55 *WIDTH_SCALE - 45 *WIDTH_SCALE, 0, 55*WIDTH_SCALE,49);
        }

        [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarButton setImage:[UIImage imageNamed:_norImageArray[i]] forState:UIControlStateNormal];
        [tabbarButton setImage:[UIImage imageNamed:_selImageArray[i]] forState:UIControlStateSelected];
        [tabbarButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [tabbarButton setTitleColor:kCOLOR(175, 174, 175, 1) forState:UIControlStateNormal];
        [tabbarButton setTitleColor:KNAV_Blue forState:UIControlStateSelected];
         UIImage *image = [UIImage imageNamed:_norImageArray[i]];
        tabbarButton.imageEdgeInsets = UIEdgeInsetsMake(6, 17 *WIDTH_SCALE, 21, 17*WIDTH_SCALE);
        tabbarButton.titleEdgeInsets = UIEdgeInsetsMake(25, -0.5*image.size.width - 31*WIDTH_SCALE, -7, 0.5*image.size.width -29*WIDTH_SCALE);
        tabbarButton.titleLabel.font = [UIFont systemFontOfSize:10*WIDTH_SCALE];
        tabbarButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:tabbarButton];
    }
}

-(void)tabbarButtonClick:(UIButton *)button
{
    _selectedButton.selected = NO;
   
    button.selected = YES;

    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
}
-(void)showTabbar
{
    _bgView.hidden = NO;
}
-(void)hideTabbar
{
    _bgView.hidden = YES;
}

-(void)jumpClinicViewController
{
//    _lastBtnTag=11;
    _selectedButton.selected = NO;
    UIButton *button = (UIButton*)[_bgView viewWithTag:11];
    button.selected = YES;
    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
}
-(void)jumpMedicalViewController
{
//    _lastBtnTag=12;
    _selectedButton.selected = NO;
    UIButton *button = (UIButton*)[_bgView viewWithTag:12];
    button.selected = YES;
    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
