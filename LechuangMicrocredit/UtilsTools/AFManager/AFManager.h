//
//  AFManager.h
//  OneRMBRegiment
//
//  Created by 李壮 on 16/6/25.
//  Copyright © 2016年 李壮 All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;


@interface AFManager : NSObject
//typedef void(^myBlock)(id CallBack);
//@property (nonatomic,copy)myBlock block;
///是否登录
//+ (BOOL)isLogoIn;

///get请求
+(void)getReqURL:(NSString*)str block:(void(^)(id infor))callBack errorblock:(void(^)(NSError *  error))errorBack;
///post请求
+(void)postReqURL:(NSString*)str reqBody:(NSDictionary *)reqBodyDic block:(void(^)(id infor))callBack;
///AF上传
+(void)upLoadpath:(NSString*)path reqBody:(NSDictionary *)reqBodyDic file:(NSData*)data fileName:(NSString*)name fileType:(NSString*)type block:(void(^)(id infor))callBack errorBlock:(void(^)(NSError *  error))errorBlock;
///AF网络状态
+ (void)AFNetworkStatus;
///广告请求
+ (void)isAdvertisement;
@end
