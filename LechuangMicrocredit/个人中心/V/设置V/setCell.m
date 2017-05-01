//
//  setCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "setCell.h"

@implementation setCell

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
    self.leftimage.frame = CGRectMake(15*WIDTH_SCALE, 15*HEIGHT_SCALE, 30*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(50*WIDTH_SCALE, 15*HEIGHT_SCALE, 120*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)leftimage
{
    if(!_leftimage)
    {
        _leftimage = [[UIImageView alloc] init];
        //_leftimage.backgroundColor = [UIColor redColor];
    }
    return _leftimage;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        //_namelabel.backgroundColor = [UIColor greenColor];
        _namelabel.textColor = [UIColor wjColorFloat:@"8A8A8A"];
    }
    return _namelabel;
}


@end
