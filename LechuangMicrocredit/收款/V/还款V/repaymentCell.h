//
//  repaymentCell.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class repayModel;
@interface repaymentCell : UITableViewCell
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UILabel *pricelabel;
-(void)setcelldata:(repayModel *)model;
@end
