//
//  messageCell.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class messageModel;
@interface messageCell : UITableViewCell
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UIImageView *messageimage;
-(void)setCellDate:(messageModel *)model;
@end
