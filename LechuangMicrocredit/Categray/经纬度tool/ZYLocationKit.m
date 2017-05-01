//
//  ZYLocationKit.m
//  MapDemo
//
//  Created by 李壮 on 16/6/13.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "ZYLocationKit.h"


@interface ZYLocationKit ()<CLLocationManagerDelegate>

/// 定位回调
@property(nonatomic, copy)LocationBlk locationCallback;

/// 定位管理器
@property(nonatomic, strong)CLLocationManager* locationManager;


@end

/// 火星坐标: 中国的GPS坐标加密标准(Google得到的是GPS坐标)
@implementation ZYLocationKit

/// 定位:完成的回调
+(void) getUserLocation:(TBlock)callback;
{
    [self getInstance].locationCallback = callback;
    
    // CLLocationManager
    CLLocationManager* locationManager = [CLLocationManager new];
    locationManager.delegate = [self getInstance];
    [self getInstance].locationManager = locationManager;
    
    // 对于8.0 有特殊处理, 注意看 文档
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    // 开始更新位置
    [locationManager startUpdatingLocation];
}


#pragma mark - ******** 地址编码委托方法 ********


/// 反编码,coordinate:经纬度,callBack(CLPlacemark*)
+(void) reverseGeocode:(CLLocationCoordinate2D)coordinate callBack:(CallBack)callBack;
{
    // 编码器
    CLGeocoder* coder = [CLGeocoder new];
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (!error) {
            CLPlacemark* place = placemarks[0];
            if (callBack) {
                callBack(place);
            }
//            NSLog(@"%@--%@--%@--%@--%@",place.administrativeArea,place.subLocality,place.name);
        }else{
            NSLog(@"反编码失败:%f-%f",coordinate.latitude,coordinate.longitude);
//            if (callBack) {
//                callBack(nil);
//            }
        }
    }];
}


/// 编码
//+(void) geocodeAddress:(NSString*)address callBack:(TBlock)callBack;
//{
//    // 编码器
//    CLGeocoder* coder = [CLGeocoder new];
//    
//    [coder geocodeAddressString:address completionHandler:^(NSArray/*<CLPlacemark *>*/ * placemarks, NSError * error) {
//        CLPlacemark* placeMark = nil;
//        if (!error) {
//            placeMark = placemarks[0];
//        }
//        if (callBack) {
//            callBack(placeMark);
//        }
//    }];
//}





#pragma mark - ******** 定位委托方法 ********

// 定位成功
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    NSLog(@"定位成功");
    // 如果是真机,可以尝试使用此方式,让定位更精准
//    if (locations.count<5) {
//        return;
//    }
    // 回调
    CLLocation* localtion = [locations lastObject];
    if (self.locationCallback) {
        self.locationCallback(localtion);
    }
    [manager stopUpdatingLocation];
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
    if (self.locationCallback) {
        self.locationCallback(nil);
    }
}
static ZYLocationKit* kInstance;
+(ZYLocationKit*) getInstance{
    if (!kInstance) {
        kInstance = [[ZYLocationKit alloc] init];
    }
    return kInstance;
}

@end






