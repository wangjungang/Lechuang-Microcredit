//
//  borrowCell.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BorrowModel;
@interface borrowCell : UITableViewCell
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UILabel *pricelabel;
-(void)setcelldata:(BorrowModel *)model;
@end
