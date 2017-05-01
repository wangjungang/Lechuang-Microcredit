//
//  CustomNavigation.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/8.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigation : UIView
{
    UIView *_bgView;
}
@property(nonatomic,strong)UIView *notiView;
@property(nonatomic,retain)UIButton *leftButton;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIButton *rightButton;
@property(nonatomic,copy)void(^CustomNavLeftBtnClickBlock)();
@property(nonatomic,copy)void(^CustomNavRightBtnClickBlock)();
@property(nonatomic,copy)void(^ChanageViewFrameBlock)(BOOL isShow);

-(void)customNavLeftBtnImageName:(NSString *)leftImageNameStr leftBtnTitle:(NSString *)leftBtnTitleStr rightBtnImageName:(NSString *)rightImageNameStr rightBtnTitle:(NSString *)rightBtnTitleStr title:(NSString *)titleStr;
//- (void)showAnimationNoti;
//- (void)hideAnimationNoti;
//-(void)startNoti;
- (void)setRightBtnFrame:(CGRect)rect;
@end
