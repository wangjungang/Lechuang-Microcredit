//
//  repaymentCell2.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "repaymentCell2.h"

@implementation repaymentCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimage];
        [self.contentView addSubview:self.namelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimage.frame = CGRectMake(10*WIDTH_SCALE, 15*HEIGHT_SCALE, 30*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(50*WIDTH_SCALE, 15*HEIGHT_SCALE, 250*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)leftimage
{
    if(!_leftimage)
    {
        _leftimage = [[UIImageView alloc] init];
        
    }
    return _leftimage;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.textColor = [UIColor wjColorFloat:@"686868"];
    }
    return _namelabel;
}



@end
