//
//  myinfoCell2.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinfoCell2.h"

@implementation myinfoCell2

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
    self.leftlabel.frame = CGRectMake(20, 15, 80, 30);
    self.messagelabel.frame = CGRectMake(110, 15, self.frame.size.width-180, 30);
    self.rightbtn.frame = CGRectMake(self.frame.size.width-60, 20, 40, 20);
}

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
        //_messagelabel.backgroundColor = [UIColor greenColor];
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
