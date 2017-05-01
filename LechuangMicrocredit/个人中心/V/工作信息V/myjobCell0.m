//
//  myjobCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myjobCell0.h"

@implementation myjobCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.messagelabel];
        [self.contentView addSubview:self.rightbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.messagelabel.frame = CGRectMake(110*WIDTH_SCALE, 15*HEIGHT_SCALE, self.frame.size.width-180*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.rightbtn.frame = CGRectMake(self.frame.size.width-60*WIDTH_SCALE, 20*HEIGHT_SCALE, 40*WIDTH_SCALE, 20*HEIGHT_SCALE);
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

-(UILabel *)messagelabel
{
    if(!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        
    }
    return _messagelabel;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setTitle:@"选择" forState:normal];
        _rightbtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_rightbtn setTitleColor:[UIColor wjColorFloat:@"686868"] forState:normal];

    }
    return _rightbtn;
}



@end
