//
//  YString+Ext.m
//  YFramework
//
//  Created by 熊宸 on 15/4/23.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YString+Ext.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Ext)

#pragma mark - 验证邮箱格式
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - 验证手机号码格式
- (BOOL)isValidPhoneNumber {
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189
//     */
//    NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189
//     22         */
//    NSString * chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
//    NSPredicate *cmPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
//    NSPredicate *cuPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
//    NSPredicate *ctPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
//    if ([mobilePredicate evaluateWithObject:self]
//        || [cmPredicate evaluateWithObject:self]
//        || [cuPredicate evaluateWithObject:self]
//        || [ctPredicate evaluateWithObject:self]) {
//        return YES;
//    }
    
    NSString *mobile = @"^1[3-9]\\d{9}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    if ([mobilePredicate evaluateWithObject:self])
    {
        return YES;
    }
        return NO;
}

#pragma mark:验证密码格式
- (BOOL)isValidPassword
{
    NSString *pattern = @"^(?![_]+$)[a-zA-Z0-9_]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始下标
 * 参数:字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

//判断是否为空
- (BOOL)isEmpty
{
    BOOL isEmpty = NO;
    if (self == nil) {
        isEmpty = YES;
    }
    else if ([self isEqualToString:@""]) {
        isEmpty = YES;
    }
    else if ([self class] == [NSNull null]) {
        isEmpty = YES;
    }
    NSString *tempString = [self removeSpaceAndNewline];
    if (tempString.length == 0) {
        isEmpty = YES;
    }
    return isEmpty;
}

//自定义文本大小
- (CGSize)customTextSize:(UIFont *)font size:(CGSize)inputSize
{
    CGSize result;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect1=[self boundingRectWithSize:inputSize options:option attributes:dic context:nil];
    result=rect1.size;
    return result;
}

//自定义内容文字大小
- (CGSize)customContentTextSize:(UIFont *)font size:(CGSize)inputSize
{
    CGSize result;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:1.0f];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect1=[self boundingRectWithSize:inputSize options:option attributes:dic context:nil];
    result=rect1.size;
    return result;
}
//字符串MD5加密 传入字符串,传出加密过的字符串

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)removeTrimmingSpaceAndNewline
{
    if ([self isKindOfClass:[NSString class]])
    {
        return @"";
    }
    NSString *tempString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [tempString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
}

- (NSString *)removeNewline
{
    NSString *tempString = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return tempString;
}

- (NSString *)removeSpaceAndNewline
{
    NSString *tempString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return tempString;
}

- (NSString *)validePathWithDir:(NSString *)dir
{
    if (self.length == 0) {
        return nil;
    }
    
    if ([self isValidImagePathUrl]) {
        return self;
    }
    
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:self isDirectory:&isDirectory])
    {
        if (!isDirectory)
        {
            return self;
        }
    }
    
    if (dir.length > 0)
    {
        NSString *path = [dir stringByAppendingString:self];
        return [path validePathWithDir:nil];
    }
    
    return nil;
}

-  (NSInteger)pingyinLenght {
    
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}



@end
