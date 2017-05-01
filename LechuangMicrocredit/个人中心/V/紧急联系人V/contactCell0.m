//
//  contactCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "contactCell0.h"

@implementation contactCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.firstbtn];
        [self.contentView addSubview:self.secondbtn];
        [self.contentView addSubview:self.leftlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.firstbtn.frame = CGRectMake(140*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.secondbtn.frame = CGRectMake(230*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        //_leftlabel.backgroundColor = [UIColor redColor];
    }
    return _leftlabel;
}

-(UIButton *)firstbtn
{
    if(!_firstbtn)
    {
        _firstbtn = [[UIButton alloc] init];
        _firstbtn.backgroundColor = [UIColor wjColorFloat:@"3AA0DB"];
        [_firstbtn addTarget:self action:@selector(firstclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstbtn;
}

-(UIButton *)secondbtn
{
    if(!_secondbtn)
    {
        _secondbtn = [[UIButton alloc] init];
        _secondbtn.backgroundColor = [UIColor wjColorFloat:@"3AA0DB"];
        [_secondbtn addTarget:self action:@selector(secondclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secondbtn;
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
