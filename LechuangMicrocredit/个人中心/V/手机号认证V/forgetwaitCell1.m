//
//  forgetwaitCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/29.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "forgetwaitCell1.h"
@interface forgetwaitCell1()
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;

@end
@implementation forgetwaitCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.label0];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        [self.contentView addSubview:self.label3];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake(20*WIDTH_SCALE, 10*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.label0.frame = CGRectMake(20*WIDTH_SCALE, 45*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 25*HEIGHT_SCALE);
    self.label1.frame = CGRectMake(20*WIDTH_SCALE, 75*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 25*HEIGHT_SCALE);
    self.label2.frame = CGRectMake(20*WIDTH_SCALE, 105*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 25*HEIGHT_SCALE);
    self.label3.frame = CGRectMake(20*WIDTH_SCALE, 135*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 25*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"方法2";
        _titlelabel.textColor = [UIColor wjColorFloat:@"373737"];

    }
    return _titlelabel;
}

-(UILabel *)label0
{
    if(!_label0)
    {
        _label0 = [[UILabel alloc] init];
        _label0.textColor = [UIColor wjColorFloat:@"686868"];
        _label0.text = @"进入官网找回密码";
        _label0.font = [UIFont systemFontOfSize:13];
    }
    return _label0;
}


-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = [UIColor wjColorFloat:@"686868"];
        _label1.text = @"a,选择手机号归属地";
        _label1.font = [UIFont systemFontOfSize:13];
    }
    return _label1;
}

-(UILabel *)label2
{
    if(!_label2)
    {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = [UIColor wjColorFloat:@"686868"];
       // _label2.text = @"b,点击[我的移动]-[密码重置]";
        _label2.font = [UIFont systemFontOfSize:13];
    }
    return _label2;
}

-(UILabel *)label3
{
    if(!_label3)
    {
        _label3 = [[UILabel alloc] init];
        //_label3.text = @"https://www.10086.com";
        _label3.textColor = [UIColor wjColorFloat:@"30BC9B"];
        _label3.font = [UIFont systemFontOfSize:13];
    }
    return _label3;
}

@end
