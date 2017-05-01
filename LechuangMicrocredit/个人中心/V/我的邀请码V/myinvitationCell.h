//
//  myinvitationCell.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;

@end

@interface myinvitationCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftimage;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UIButton *rightbtn;

@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
