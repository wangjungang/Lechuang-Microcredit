//
//  AFManager.m
//  OneRMBRegiment
//
//  Created by 李壮 on 16/6/25.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "AFManager.h"
#import <AFNetworking.h>
//网络请求
//#import "NetworkStatus.h"
@implementation AFManager

//+ (BOOL)isLogoIn
//{
//    return [[NSFileManager defaultManager]fileExistsAtPath:USER_ID];
//}
+ (void)isAdvertisement
{
//    [AFManager getReqURL:[NSString stringWithFormat:@"http://yewen.yhoso.com/ajax_ad/getAd?ticket=%@",TICKET] block:^(id infor)
//     {
//         if ([[infor objectForKey:@"status"] integerValue]==200)
//         {
//             AdvertisementLibraryBaseClass*baseClass=[AdvertisementLibraryBaseClass modelObjectWithDictionary:infor];
//             [NSKeyedArchiver archiveRootObject:baseClass.data toFile:ADVERTISMENT_PATH];
////             callBack(baseClass.data,YES);
//             
//         }else{
////             callBack(nil,NO);
//             [[NSFileManager defaultManager]removeItemAtPath:ADVERTISMENT_PATH error:nil];
//         }
//     } errorblock:^(NSError *error) {
//    
//     }];
}
+(void)getReqURL:(NSString*)str block:(void(^)(id infor))callBack errorblock:(void(^)(NSError *  error))errorBack
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 启动状态栏网络请求指示
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBack(error);
         NSLog(@"=====/n%@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示

    }];
}
+(void)postReqURL:(NSString*)str reqBody:(NSDictionary *)reqBodyDic block:(void(^)(id infor))callBack;
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 启动状态栏网络请求指示
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:str parameters:reqBodyDic progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
       
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        callBack(dic);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"=====/n%@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
    }];

}

+(void)upLoadpath:(NSString*)path reqBody:(NSDictionary *)reqBodyDic file:(NSData*)data fileName:(NSString*)name fileType:(NSString*)type block:(void(^)(id infor))callBack errorBlock:(void(^)(NSError *  error))errorBlock;
{
    AFHTTPSessionManager* sessinManager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:path]];
    sessinManager.responseSerializer=[AFJSONResponseSerializer serializer];
    sessinManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    //增加这几行代码；
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    //这里进行设置；
    [sessinManager setSecurityPolicy:securityPolicy];
    sessinManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [sessinManager POST:path parameters:reqBodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        /*
         在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
         要解决此问题，
         可以在上传时使用当前的系统时间作为文件名
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         设置时间格式
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *str = [formatter stringFromDate:[NSDate date]];
         */
    
        [formData appendPartWithFileData:data name:@"file" fileName:name mimeType:type];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        callBack(str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        errorBlock(error);
    }];
}
+ (void)AFNetworkStatus
{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
//   __block NSString *statusNet;
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
//    {
//        //这里是监测到网络改变的block  可以写成switch方便
//        //在里面可以随便写事件
//        switch (status)
//        {
//            case AFNetworkReachabilityStatusUnknown:
//            {
//                NSLog(@"未知网络状态");
//                [NetworkStatus instanceView].networkStatus=@"0";
//                [[NetworkStatus instanceView]save];
//                if ([NetworkStatus instanceView].NetworkStatusChangeBlock) {
//                [NetworkStatus instanceView].NetworkStatusChangeBlock(YES);
//                }
//                statusNet=@"未知网络状态";
//            }
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            {
//                NSLog(@"无网络");
//                [NetworkStatus instanceView].networkStatus=@"1";
//                [[NetworkStatus instanceView]save];
//                if ([NetworkStatus instanceView].NetworkStatusChangeBlock) {
//                    [NetworkStatus instanceView].NetworkStatusChangeBlock(NO);
//                }
//                statusNet=@"无网络";
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            {
//                NSLog(@"蜂窝数据网");
//                [NetworkStatus instanceView].networkStatus=@"2";
//                [[NetworkStatus instanceView]save];
//                if ([NetworkStatus instanceView].NetworkStatusChangeBlock) {
//                [NetworkStatus instanceView].NetworkStatusChangeBlock(YES);
//                }
//                statusNet=@"蜂窝数据网";
//            }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//            {
//                NSLog(@"WiFi网络");
//                [NetworkStatus instanceView].networkStatus=@"3";
//                [[NetworkStatus instanceView]save];
//                if ([NetworkStatus instanceView].NetworkStatusChangeBlock) {
//                     [NetworkStatus instanceView].NetworkStatusChangeBlock(YES);
//                }
//               
//                statusNet=@"WiFi网络";
//            }
//                break;
//            default:
//                break;
//        }
//    }] ;
//    
//    [manager startMonitoring];
}
@end
