//
//  phoneregisCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "phoneregisCell1.h"
@interface phoneregisCell1()
@property (nonatomic,strong) UILabel *leftlabel;
@property (nonatomic,strong) UIImageView *rightimage;
@end
@implementation phoneregisCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.messagetext];
        [self.contentView addSubview:self.rightimage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 10*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.messagetext.frame = CGRectMake(110*WIDTH_SCALE, 10*HEIGHT_SCALE, DEVICE_WIDTH-160*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.rightimage.frame = CGRectMake(DEVICE_WIDTH-40*WIDTH_SCALE, 15*HEIGHT_SCALE, 20*WIDTH_SCALE, 20*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.text = @"服务密码";
        _leftlabel.textColor = [UIColor wjColorFloat:@"373737"];
        _leftlabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftlabel;
}

-(UITextField *)messagetext
{
    if(!_messagetext)
    {
        _messagetext = [[UITextField alloc] init];
        _messagetext.placeholder = @"请输入验证码";
    }
    return _messagetext;
}


-(UIImageView *)rightimage
{
    if(!_rightimage)
    {
        _rightimage = [[UIImageView alloc] init];
        _rightimage.image = [UIImage imageNamed:@"30x30"];
    }
    return _rightimage;
}





@end
