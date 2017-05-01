//
//  ZYLocationKit.h
//  MapDemo
//
//  Created by 李壮 on 16/6/13.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationBlk)(CLLocation* userLocation);

typedef void(^TBlock)(CLLocation* item);

typedef void(^CallBack)(CLPlacemark*item);
@interface ZYLocationKit : NSObject

+(ZYLocationKit*) getInstance;

/// 定位,callback(CLLocation*)
+(void) getUserLocation:(TBlock)callback;

//CLGeocoder: 编码器
//反编码：reverseGeocodeLocation  经纬度 -> 详细信息
//编码：geocodeAddressString  详细信息 -> 经纬度

/// 反编码,coordinate:经纬度,callBack(CLPlacemark*)
+(void) reverseGeocode:(CLLocationCoordinate2D)coordinate callBack:(CallBack)callBack;

/// 编码
+(void) geocodeAddress:(NSString*)address callBack:(TBlock)callBack;

@end












