//
//  myinfoCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinfoCell0.h"

@implementation myinfoCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.setimage];
        [self.contentView addSubview:self.setimage2];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 30*HEIGHT_SCALE, 160*WIDTH_SCALE, 30*HEIGHT_SCALE);
    //self.setimage.frame = CGRectMake(self.frame.size.width/2, 15*HEIGHT_SCALE, 60*WIDTH_SCALE, 60*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.textColor = [UIColor wjColorFloat:@"373737"];
        
    }
    return _leftlabel;
}

-(UIButton *)setimage
{
    if(!_setimage)
    {
        _setimage = [[UIButton alloc] init];
        [_setimage addTarget:self action:@selector(firstclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setimage;
}


-(UIButton *)setimage2
{
    if(!_setimage2)
    {
        _setimage2 = [[UIButton alloc] init];
        [_setimage2 addTarget:self action:@selector(secondclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setimage2;
}

#pragma mark - 协议方法

-(void)firstclick
{
    [self.delegate firstClick:self];
}

-(void)secondclick
{
    [self.delegate secondClick:self];
}
@end
