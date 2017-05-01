//
//  jiexiViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2017/2/5.
//  Copyright © 2017年 张婷. All rights reserved.
//

#import "jiexiViewController.h"

@interface jiexiViewController ()

@end

@implementation jiexiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
//    
    
    NSString *str = @"https://naucu.com:8443/englishStudy/queryMoviesbyName?info=%@";
    NSString *str1 = @"movieName";
    NSString *str2 = @"的";

    NSDictionary *dic = @{str1:str2};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"dic====%@",jsonData);
    
    NSString *jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:str,jsonstr];
    NSLog(@"urk====%@",url);
    [AFManager getReqURL:url block:^(id infor) {
        NSLog(@"info=====%@",infor);
        
        NSDictionary *dict = infor[@"tv"][0];
        
        NSLog(@"********%@",dict[@"createTime"]);
        
    } errorblock:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
