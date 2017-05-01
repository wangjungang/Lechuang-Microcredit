//
//  myjobCell2.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/22.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myjobCell2.h"

@implementation myjobCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.workimage];
        [self.contentView addSubview:self.messagelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.workimage.frame = CGRectMake(DEVICE_WIDTH-80*WIDTH_SCALE, 10*HEIGHT_SCALE, 60*WIDTH_SCALE, 40*HEIGHT_SCALE);
    self.messagelabel.frame = CGRectMake(120*WIDTH_SCALE, 15*HEIGHT_SCALE, 180*WIDTH_SCALE, 30*HEIGHT_SCALE);
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

-(UIImageView *)workimage
{
    if(!_workimage)
    {
        _workimage = [[UIImageView alloc] init];
        //_workimage.backgroundColor = [UIColor redColor];
    }
    return _workimage;
}

-(UILabel *)messagelabel
{
    if(!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.textColor = [UIColor wjColorFloat:@"373737"];
        _messagelabel.font = [UIFont systemFontOfSize:14];
        _messagelabel.text = @"选填，可提高通过率";
    }
    return _messagelabel;
}



@end
