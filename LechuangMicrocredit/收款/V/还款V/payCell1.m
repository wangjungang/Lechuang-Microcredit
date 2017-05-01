//
//  payCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/23.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "payCell1.h"

@implementation payCell1

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
    self.leftimage.frame = CGRectMake(15*WIDTH_SCALE, 10*HEIGHT_SCALE, 50*WIDTH_SCALE, 50*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(100*WIDTH_SCALE, 15*HEIGHT_SCALE, 100*WIDTH_SCALE, 35*HEIGHT_SCALE);
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
        
    }
    return _namelabel;
}




@end
