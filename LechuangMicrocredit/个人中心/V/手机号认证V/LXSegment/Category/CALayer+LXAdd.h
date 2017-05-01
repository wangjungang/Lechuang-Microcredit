//
//  CALayer+LXAdd.h
//  LXAppFrameworkDemo
//
//  Created by liuxin on 16/5/11.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (LXAdd)


@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///< Shortcut for frame.size.

/**
 *  旋转
 */
@property (nonatomic) CGFloat transformRotation;     ///< key path "transform.rotation"
@property (nonatomic) CGFloat transformRotationX;    ///< key path "transform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    ///< key path "transform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    ///< key path "transform.rotation.z"

/**
 *  缩放
 */
@property (nonatomic) CGFloat transformScale;        ///< key path "transform.scale"
@property (nonatomic) CGFloat transformScaleX;       ///< key path "transform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       ///< key path "transform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       ///< key path "transform.scale.z"

/**
 *  平移
 */
@property (nonatomic) CGFloat transformTranslationX; ///< key path "transform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; ///< key path "transform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; ///< key path "transform.translation.z"

@end
