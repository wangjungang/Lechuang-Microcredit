//
//  invitationView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "invitationView.h"
@interface invitationView()
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UILabel *linelabel;
@end
@implementation invitationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.firstbtn];
        [self addSubview:self.secondbtn];
        [self addSubview:self.thirdbtn];
        [self addSubview:self.forthbtn];
        [self addSubview:self.lastbtn];
        [self addSubview:self.titlelabel];
        [self addSubview:self.linelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.firstbtn.frame = CGRectMake(50, 40, 60, 60);
    self.secondbtn.frame = CGRectMake(self.frame.size.width/2-30, 40, 60, 60);
    self.thirdbtn.frame = CGRectMake(DEVICE_WIDTH-110, 40, 60, 60);
    self.forthbtn.frame = CGRectMake(50, 120, 60, 60);
    self.lastbtn.frame = CGRectMake(self.frame.size.width/2-30, 120, 60, 60);
    
    self.titlelabel.frame = CGRectMake(self.frame.size.width/2-40, 5, 80, 20);
    self.linelabel.frame = CGRectMake(0, 26, DEVICE_WIDTH, 0.3);
}

#pragma mark - getters

-(UIButton *)firstbtn
{
    if(!_firstbtn)
    {
        _firstbtn = [[WJGButton alloc] init];
        [_firstbtn setImage:[UIImage imageNamed:@"直播-分享_03"] forState:normal];
        [_firstbtn setTitle:@"新浪微博" forState:normal];
        [_firstbtn setTitleColor:[UIColor blackColor] forState:normal];
    }
    return _firstbtn;
}

-(UIButton *)secondbtn
{
    if(!_secondbtn)
    {
        _secondbtn = [[WJGButton alloc] init];
        [_secondbtn setImage:[UIImage imageNamed:@"直播-分享_05"] forState:normal];
        [_secondbtn setTitle:@"微信" forState:normal];
        [_secondbtn setTitleColor:[UIColor blackColor] forState:normal];
    }
    return _secondbtn;
}

-(UIButton *)thirdbtn
{
    if(!_thirdbtn)
    {
        _thirdbtn = [[WJGButton alloc] init];
        [_thirdbtn setImage:[UIImage imageNamed:@"直播-分享_07"] forState:normal];
        [_thirdbtn setTitle:@"QQ" forState:normal];
        [_thirdbtn setTitleColor:[UIColor blackColor] forState:normal];
    }
    return _thirdbtn;
}

-(UIButton *)forthbtn
{
    if(!_forthbtn)
    {
        _forthbtn = [[WJGButton alloc] init];
        [_forthbtn setImage:[UIImage imageNamed:@"直播-分享_12"] forState:normal];
        [_forthbtn setTitle:@"朋友圈" forState:normal];
        [_forthbtn setTitleColor:[UIColor blackColor] forState:normal];
    }
    return _forthbtn;
}

-(UIButton *)lastbtn
{
    if(!_lastbtn)
    {
        _lastbtn= [[WJGButton alloc] init];
        [_lastbtn setImage:[UIImage imageNamed:@"直播-分享_13"] forState:normal];
        [_lastbtn setTitle:@"QQ空间" forState:normal];
        [_lastbtn setTitleColor:[UIColor blackColor] forState:normal];
    }
    return  _lastbtn;
}

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc]init];
        //_titlelabel.backgroundColor = [UIColor greenColor];
        _titlelabel.text = @"分享到";
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

-(UILabel *)linelabel
{
    if(!_linelabel)
    {
        _linelabel = [[UILabel alloc] init];
        _linelabel.backgroundColor = [UIColor wjColorFloat:@"373737"];
    }
    return _linelabel;
}

@end
