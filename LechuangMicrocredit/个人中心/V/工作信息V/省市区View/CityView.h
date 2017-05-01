//
//  CityView.h
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@protocol CityViewDelegate <NSObject>

- (void)getBtnIndex:(NSInteger)index content:(NSString*)text;

@end

@interface CityView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    NSString *selectedProvince;
}
@property (nonatomic,strong)UIPickerView*picker;
@property (nonatomic,strong)UIButton*cancleBtn,*sureBtn;
@property (nonatomic,assign)id<CityViewDelegate>delegate;
@end

// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )
