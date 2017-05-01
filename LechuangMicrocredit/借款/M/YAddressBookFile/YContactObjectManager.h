//
//  messageViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;

@class YContactObject;

NS_ASSUME_NONNULL_BEGIN


@interface YContactObjectManager : NSObject


/**
 *  根据ABRecordRef数据获得YContantObject对象
 *
 *  @param recordRef ABRecordRef对象
 *
 *  @return YContantObject对象
 */
+(YContactObject *)contantObject:(ABRecordRef)recordRef;



@end

NS_ASSUME_NONNULL_END
