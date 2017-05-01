//
//  contactCell0.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol contactdelegate <NSObject>

-(void)firstClick:(UITableViewCell *)cell;
-(void)secondClick:(UITableViewCell *)cell;
@end
@interface contactCell0 : UITableViewCell
@property (nonatomic,strong) UILabel *leftlabel;
@property (nonatomic,strong) UIButton *firstbtn;
@property (nonatomic,strong) UIButton *secondbtn;
@property(assign,nonatomic)id<contactdelegate>delegate;

@end
