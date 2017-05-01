//
//  registeredCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "registeredCell0.h"
@interface registeredCell0()
@property (nonatomic,strong) UILabel *linelabel;
@end
@implementation registeredCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.messagetext];
        [self.contentView addSubview:self.timebtn];
        [self.contentView addSubview:self.linelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.messagetext.frame = CGRectMake(5*WIDTH_SCALE, 10*HEIGHT_SCALE, self.frame.size.width/3*2, 30*HEIGHT_SCALE);
    self.timebtn.frame = CGRectMake(self.frame.size.width/3*2, 10*HEIGHT_SCALE, self.frame.size.width/3, 30*HEIGHT_SCALE);
    self.linelabel.frame = CGRectMake(self.frame.size.width/3*2, 1, 0.5, self.frame.size.height-2);
}

-(UIButton *)timebtn
{
    if(!_timebtn)
    {
        _timebtn = [[UIButton alloc] init];
        [_timebtn setTitleColor:[UIColor wjColorFloat:@"008CCF"] forState:normal];
        [_timebtn setTitle:@"获取验证码" forState:normal];
        _timebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _timebtn;
}

-(UITextField *)messagetext
{
    if(!_messagetext)
    {
        _messagetext = [[UITextField alloc] init];
        _messagetext.keyboardType = UIKeyboardTypePhonePad;
    }
    return _messagetext;
}

-(UILabel *)linelabel
{
    if(!_linelabel)
    {
        _linelabel = [[UILabel alloc] init];
        _linelabel.backgroundColor = [UIColor wjColorFloat:@"B9B9B9"];
    }
    return _linelabel;
}




@end
