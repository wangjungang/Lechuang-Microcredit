//
//  WJGimageViewController.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/22.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  获取相机权限成功
 *
 *  @param imagePickerController 获取相机权限成功
 */
typedef void(^CameraSuccess)(UIImagePickerController * imagePickerController);

/**
 *  获取相机权限失败
 */
typedef void(^CameraFail)();

/**
 *  获取相簿权限成功
 *
 *  @param imagePickerController 获取相簿权限失败
 */
typedef void(^AlbumSuccess)(UIImagePickerController * imagePickerController);

/**
 *  获取相簿权限失败
 */
typedef void(^AlbumFail)();

/**
 *  获取图片 代理
 */
@protocol WJGImagePickerControllerDelegate <NSObject>

/**
 *  不缓存状态下的图片回调
 *
 *  @param image 回调的图片
 */
- (void)selectImageFinished:(UIImage * )image;

/**
 *  缓存状态下的图片回调
 *
 *  @param image      回调的图片
 *  @param identifier 图片的标识符(缓存的文件名称)
 *  @param isCaches   缓存是否成功
 */
- (void)selectImageFinishedAndCaches:(UIImage * )image cachesIdentifier:(NSString *)identifier isCachesSuccess:(BOOL)isCaches;

@end

@interface WJGimageViewController : NSObject

/**
 *  设置是否缓存 默认为NO
 */

@property (nonatomic,assign) BOOL isCaches;

/**
 *  设置是否编辑图片，默认为YES.设置为NO时，选择图片的时候不出现裁剪框，返回图片尺寸大小正常。
 */
@property (nonatomic,assign) BOOL isEditImage;

/**
 *  设置缓存标识符(缓存的文件名称)
 */
@property (nonatomic,strong) NSString * identifier;

/**
 *  选取图片结束的代理
 */
@property (nonatomic,weak) id<WJGImagePickerControllerDelegate>delegate;

/**
 *  需要缓存时的初始化方法
 *
 *  @param isCaches   设置缓存状态 默认为NO
 *  @param identifier 设置缓存标识符
 *
 *  @return 需要缓存时的初始化方法
 */
- (instancetype)initWithIsCaches:(BOOL)isCaches andIdentifier:(NSString *)identifier;

/**
 *  选取来自相机的图片
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)selectImageFromCameraSuccess:(CameraSuccess)success fail:(CameraFail)failure;

/**
 *  选取来自相簿的图片
 *
 *  @param success 成功
 *  @param failure 失败
 */
- (void)selectImageFromAlbumSuccess:(AlbumSuccess)success fail:(AlbumFail)failure;

/**
 *  读取缓存的图片
 *
 *  @param identifier 缓存标识符
 *
 *  @return 缓存的图片
 */
- (UIImage *)readImageFromCachesIdentifier:(NSString *)identifier;

/**
 *  删除指定的缓存的图片
 *
 *  @param identifier 缓存标识符
 *
 *  @return 是否删除成功
 */
- (BOOL)removeCachePictureForIdentifier:(NSString *)identifier;

/**
 *  删除全部缓存的图片
 *
 *  @return 是否删除成功
 */
- (BOOL)removeCachePictures;

@end
