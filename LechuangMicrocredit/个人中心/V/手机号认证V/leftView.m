//
//  leftView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "leftView.h"
@interface leftView()
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;
@end
@implementation leftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titlelabel];
        [self addSubview:self.label0];
        [self addSubview:self.label1];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake(20*WIDTH_SCALE, 10*HEIGHT_SCALE, 200*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.label0.frame = CGRectMake(20*WIDTH_SCALE, 50*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.label1.frame = CGRectMake(20*WIDTH_SCALE, 90*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"温馨提示";
        _titlelabel.textColor = [UIColor wjColorFloat:@"686868"];
        _titlelabel.font = [UIFont systemFontOfSize:13];
    }
    return _titlelabel;
}

-(UILabel *)label0
{
    if(!_label0)
    {
        _label0 = [[UILabel alloc] init];
        _label0.text = @"1、本人实名认证手机号";
        _label0.textColor = [UIColor wjColorFloat:@"686868"];
        _label0.font = [UIFont systemFontOfSize:13];
    }
    return _label0;
}


-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"2、收到运营商短信无需回复,属于正常情况";
        _label1.textColor = [UIColor wjColorFloat:@"686868"];
        _label1.font = [UIFont systemFontOfSize:13];
    }
    return _label1;
}

@end
