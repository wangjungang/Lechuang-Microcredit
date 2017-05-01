//
//  contactCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "contactCell1.h"

@implementation contactCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.mobiletext];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.mobiletext.frame = CGRectMake(140*WIDTH_SCALE, 15*HEIGHT_SCALE, self.frame.size.width-160*WIDTH_SCALE, 30*HEIGHT_SCALE);
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

-(UITextField *)mobiletext
{
    if(!_mobiletext)
    {
        _mobiletext = [[UITextField alloc] init];
       // _mobiletext.backgroundColor = [UIColor greenColor];
        _mobiletext.placeholder = @"请输入手机号";
        _mobiletext.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    return _mobiletext;
}


@end
