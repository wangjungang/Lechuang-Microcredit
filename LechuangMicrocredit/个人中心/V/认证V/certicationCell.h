//
//  certicationCell.h
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class certifocaModel;
@interface certicationCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftimage;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *typelabel;
-(void)setcelldata:(certifocaModel *)cermodel;
@end
