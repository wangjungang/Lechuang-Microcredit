//
//  Apipayclick.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/26.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "Apipayclick.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Payorder.h"
@implementation Apipayclick
//订单号 商品标题 价格  回调地址
+(void)alipayModelWithOrderid:(NSString *)orderid withName:(NSString *)name withMoney:(NSString *)money withNotify:(NSString *)notify withViewcontroller:(UIViewController *)vc
{
    NSString *appScheme = @"jisudaidaiAlipay";
    NSString *partner = @"2088521193226283";//商户ID
    NSString *seller = @"15001373238m@sina.cn";
//    NSString *privateKey =@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKWbjeRvNSpZhQeE5uJTc6akFHPGb4BedrASOHBH7kx51b2zpTkQLHifIbvZVNrJv6p6xfhE9Na1xgp1U2qwv3WhYLEPN8/O0jOOVHSqmNjKqDhbmbpOXpflRfCKhJxjyggBkiV0ngebft3wU6Ajciy+TDyivFDwAqo4Gi46vq2rAgMBAAECgYAnM+2g99pkDhD5uLJXPV4RQqI8zeqzPqlmAMovejelDupUH+Sq33NHkpQPveDicgPXPX0Dyn8THLCm5SM8DF8l/fEwJJFFth0rECtufz7Q5qtOE2WDma1iZ1jCAupRS8Hdux5zf3Ms3Hi4UKks0/9NWOena7o9zMkV6Pts/oszAQJBANDn+RnEmFHegWkKhhGhp3slEU/WhHX3TjDbjs41wPU1YpYYKiwxapfPUBgCp0pQnQz4cVDNEPpx6AcUF/HTuMECQQDK8NAnU5ATqNwivUwuaXpJmfpZW6pKk2C6eAW66qAPLzSAj+KQ0g7HmF+V9O/JQTix3zDx3rkxe7l6TNg9oLVrAkEAipJVWhJeN3Awx0yDwg5I2hasdRkGpHl3FFGPWJmvdPgEfStqTgY5fpm1tzeLYHA4vPHPuJlOOdJ05r0dZPvcAQJARLA5Y/Yun9jZmZCExnjBAURyregOvWsgpDyXg+qB/mG13YXV47qVcg0q3TCoMHA45ktq35LJD+yWnMSBtGo+vQJAeUwpZMs4X9BUGNU2ClNQY5STJCoF5m82ItYdZ2k+65lj8XHoEZN5sR03DQP9x4MzV2C5yO7AOt0q6pNMs7mQaA==";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAN3cUGL161VdFYME+rAJIEEB3AWZ3UzTRZkUsbCDg9sKNETflGGOmZrWAtmFPQ0voCwKYisYGxk5fOSEIdQEKvaaCqsR/WA9+JpzpIYeTLktH/5tAWz2uIp9u6W1FL+xs4Xszbk4I8TtrSFP+rNCWVj7OxYEW8U5iGd/OUJqMW4VAgMBAAECgYAdpfGAKAj48WWMir/Ngoqy5UK35OXz/E/SszdDtW+LeAOgKJi1qM7SKENdOjb8ah7ng8O2qpQEfPA5wYabxKrQ5fFRjsrCCe90E6b3h6zR0WO49rocEcFlHf4SA7oyRglcl7KWeoXCHVb/PaE6Aj+gZwYqIL2rDCKy+K/NMJLZQQJBAPSJcpKxrKn7DUwjcNXCR6G7YlNui59Zs95JT1AR7rV3gqtkWK8v282jsz1cHzUxqD+BoJDUsHQvyRXTagUSMo0CQQDoQr2b/aHJJWvbl3BnsLEV13mYSRRStZGZNw7YLDTjVzyxCY38LBKooJe8qxl5b2ccscRJ2d4smGz4x5htigupAkEApQMbDWJX4VxH3NkNizFOpRSNhT9TeHRPq/BMVPvE2S+MPZu5PH5PFLUifoVribm4jyIp95GOgNi+GLxRDpr5AQJAZyLr688O/rE9Wf+/jGvr1xUeC7+35Jp4Ex9d2iSXP7THYJ4rjKVNi8/0UXVxFHmhwh42Wc0DWa4+BaMsTsgUMQJBAMyeZZsqRy5Kw+8+zav3FC8BkqslbwY/95XdW1OJ6rn7ftapMV3eA7J3TFVbEy5msDAHeywQnB+GOHIX8GkOmug=";
    Payorder *order = [[Payorder alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [NSString stringWithFormat:@"%@",orderid] ;//订单ID（由商家自行制定）
    order.productName = name ; //商品标题
    //     order.productDescription = @"测试" ; //商品描述
    order.amount = [NSString stringWithFormat:@"%@", money];
    order.notifyURL =  notify;//回调地址
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    order.service = @"mobile.securitypay.pay";//固定值
    NSString *orderSpec = [order description];
    
    id <DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"******%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //【callback 处理支付结果】
            NSLog(@"reslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                
                
                
            }
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"chongzhichenggong" object:nil];
                //                [vc.navigationController pushViewController:vc animated:YES];
            }
            if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                    
                }
            }
            
        }];
    }
    

}

@end
