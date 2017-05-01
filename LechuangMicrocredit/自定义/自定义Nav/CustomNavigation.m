//
//  CustomNavigation.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/8.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "CustomNavigation.h"

@implementation CustomNavigation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
        _bgView.clipsToBounds=NO;
        _bgView.backgroundColor = KNAV_Blue;
        [self addSubview:_bgView];
        
        
    }
    return self;
}

-(void)customNavLeftBtnImageName:(NSString *)leftImageNameStr leftBtnTitle:(NSString *)leftBtnTitleStr rightBtnImageName:(NSString *)rightImageNameStr rightBtnTitle:(NSString *)rightBtnTitleStr title:(NSString *)titleStr
{
    
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(15 *WIDTH_SCALE, 32, 80, 20);
    self.leftButton.tag = 1001;
//    self.leftButton.backgroundColor = [UIColor redColor];
    
    [self.leftButton setTitle:leftBtnTitleStr forState:UIControlStateNormal];
    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.leftButton setImage:[UIImage imageNamed:leftImageNameStr] forState:UIControlStateNormal];
    self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,-5,0,60);//设置image在button上的位置
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:self.leftButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(DEVICE_WIDTH / 2 - 75 *WIDTH_SCALE, 32, 150 *WIDTH_SCALE, 20);
    self.titleLabel.text = titleStr;
    self.titleLabel.font = [UIFont systemFontOfSize:17*WIDTH_SCALE];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    //    label.backgroundColor = [UIColor yellowColor];
    [_bgView addSubview:self.titleLabel];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(DEVICE_WIDTH - 60 *WIDTH_SCALE - 15 *WIDTH_SCALE, 33, 60*WIDTH_SCALE, 20);
    //        self.nextButton.backgroundColor = [UIColor redColor];
    self.rightButton.tag = 1002;
    [self.rightButton setTitle:rightBtnTitleStr forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:rightImageNameStr] forState:0];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:self.rightButton];
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 64, 64);
//    leftBtn.backgroundColor = [UIColor redColor];
    leftBtn.tag = 1;
    [leftBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:leftBtn];
    self.notiView.backgroundColor=[UIColor redColor];
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 100, 100);
//    rightBtn.backgroundColor = [UIColor redColor];
//    rightBtn.tag = 1;
//    [rightBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [_bgView addSubview:rightBtn];
    
}
- (void)setRightBtnFrame:(CGRect)rect
{
    self.rightButton.frame = rect;
}
/*

-(void)startNoti
{
    [NetworkStatus instanceView].NetworkStatusChangeBlock=^(BOOL isNetwork){
        if (isNetwork) {
            [self hideAnimationNoti];
            if (_ChanageViewFrameBlock) {
                _ChanageViewFrameBlock(NO);
            }
            
        }else{
            [self showAnimationNoti];
            if (_ChanageViewFrameBlock) {
                _ChanageViewFrameBlock(YES);
            }
        }
    };
}
 */
-(void)leftButtonClick
{
    if (self.CustomNavLeftBtnClickBlock)
    {
        self.CustomNavLeftBtnClickBlock();
    }
}
-(void)rightButtonClick
{
    if (self.CustomNavRightBtnClickBlock)
    {
        self.CustomNavRightBtnClickBlock();
    }
}
/*
- (UIView*)notiView
{
    if (!_notiView) {
        _notiView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, 0)];
        _notiView.alpha=0.5;
        _notiView.clipsToBounds=YES;
        UILabel *notiLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, DEVICE_WIDTH, 30)];
        notiLb.text=@"网络请求失败，请检查您的网络设置";
        notiLb.textAlignment=1;
        notiLb.textColor =[UIColor whiteColor];
        notiLb.font =[UIFont systemFontOfSize:14];
        [_notiView addSubview:notiLb];
        [_bgView addSubview:_notiView];
    }
    return _notiView;
}
- (void)showAnimationNoti
{
    [UIView animateWithDuration:0.3 animations:^{
        _notiView.frame=CGRectMake(0, 64, DEVICE_WIDTH, 50);
    } completion:^(BOOL finished) {
        _notiView.frame=CGRectMake(0, 64, DEVICE_WIDTH, 50);
    }];
}
- (void)hideAnimationNoti
{
    [UIView animateWithDuration:0.3 animations:^{
        _notiView.frame=CGRectMake(0, 64, DEVICE_WIDTH, 0);
    } completion:^(BOOL finished) {
        
    }];
}
 */
@end
