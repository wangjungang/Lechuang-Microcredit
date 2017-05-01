//
//  myinfoCell3.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinfoCell3.h"

@implementation myinfoCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.detailedaddresstext];
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.messagelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.detailedaddresstext.frame = CGRectMake(110*WIDTH_SCALE, 15*HEIGHT_SCALE, self.frame.size.width-180*WIDTH_SCALE, 30*HEIGHT_SCALE);
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

-(UITextField *)detailedaddresstext
{
    if(!_detailedaddresstext)
    {
        _detailedaddresstext = [[UITextField alloc] init];
        
    }
    return _detailedaddresstext;
}


-(UILabel *)messagelabel
{
    if(!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.textColor = [UIColor wjColorFloat:@"373737"];
    }
    return _messagelabel;
}


@end
