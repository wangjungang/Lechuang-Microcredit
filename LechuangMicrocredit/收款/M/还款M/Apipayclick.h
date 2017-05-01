//
//  Apipayclick.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/26.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apipayclick : NSObject
+(void)alipayModelWithOrderid:(NSString *)orderid withName:(NSString *)name withMoney:(NSString *)money withNotify:(NSString *)notify withViewcontroller:(UIViewController *)vc;
@end
