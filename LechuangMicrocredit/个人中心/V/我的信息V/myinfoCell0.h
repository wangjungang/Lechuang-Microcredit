//
//  myinfoCell0.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myinfodelegate <NSObject>

-(void)firstClick:(UITableViewCell *)cell;
-(void)secondClick:(UITableViewCell *)cell;

@end
@interface myinfoCell0 : UITableViewCell
@property (nonatomic,strong) UILabel *leftlabel;
@property (nonatomic,strong) UIButton *setimage;

@property (nonatomic,strong) UIButton *setimage2;
@property(assign,nonatomic)id<myinfodelegate>delegate;
@end
