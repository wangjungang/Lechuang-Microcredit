//
//  myinfoCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinfoCell1.h"

@implementation myinfoCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.infotextfiled];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.infotextfiled.frame = CGRectMake(100*WIDTH_SCALE, 15*HEIGHT_SCALE, self.frame.size.width-120*WIDTH_SCALE, 30*HEIGHT_SCALE);
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

-(UITextField *)infotextfiled
{
    if(!_infotextfiled)
    {
        _infotextfiled = [[UITextField alloc] init];
    }
    return _infotextfiled;
}



@end
