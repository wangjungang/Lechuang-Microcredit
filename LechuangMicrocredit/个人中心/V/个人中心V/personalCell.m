//
//  personalCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "personalCell.h"
@interface personalCell()

@end
@implementation personalCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.infoimage];
        [self.contentView addSubview:self.infolabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.infoimage.frame = CGRectMake(10, self.frame.size.height/2-10, 20, 20);
    self.infolabel.frame = CGRectMake(40, self.frame.size.height/2-10, 100, 20);
}

#pragma mark - getters

-(UILabel *)infolabel
{
    if(!_infolabel)
    {
        _infolabel = [[UILabel alloc] init];
        //_infolabel.backgroundColor = [UIColor greenColor];
    }
    return _infolabel;
}

-(UIImageView *)infoimage
{
    if(!_infoimage)
    {
        _infoimage = [[UIImageView alloc] init];
        //_infoimage.backgroundColor = [UIColor redColor];
    }
    return _infoimage;
}


@end
