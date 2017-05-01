//
//  myboundsCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myboundsCell.h"

@implementation myboundsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.boundsimage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.boundsimage.frame = CGRectMake(25*WIDTH_SCALE, 10*HEIGHT_SCALE, self.frame.size.width-50*WIDTH_SCALE, 150*HEIGHT_SCALE);
}

#pragma mark - getters


-(UIImageView *)boundsimage
{
    if(!_boundsimage)
    {
        _boundsimage = [[UIImageView alloc] init];
        _boundsimage.backgroundColor = [UIColor orangeColor];
        _boundsimage.layer.masksToBounds = YES;
        _boundsimage.layer.cornerRadius = 10;
    }
    return _boundsimage;
}


@end
