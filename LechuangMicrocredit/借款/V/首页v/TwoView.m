//
//  TwoView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "TwoView.h"

@interface TwoView()
@property (nonatomic,strong) UILabel *tianshulabel;
@property (nonatomic,strong) UILabel *jiekuanlabel;
@property (nonatomic,strong) UILabel *huankuanlabel;

@property (nonatomic,strong) UILabel *linelabel0;
@property (nonatomic,strong) UILabel *linelabel1;
@end

@implementation TwoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tianshulabel];
        [self addSubview:self.addbtn];
        [self addSubview:self.delbtn];
        [self addSubview:self.daynumlabel];
        [self addSubview:self.accountpricelabel];
        [self addSubview:self.jiekuanlabel];
        [self addSubview:self.huankuanlabel];
        [self addSubview:self.returnpricelabel];
        [self addSubview:self.linelabel0];
        [self addSubview:self.linelabel1];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tianshulabel.frame = CGRectMake(0, 5, self.frame.size.width/3, self.frame.size.height/2);
    self.delbtn.frame = CGRectMake(15, self.frame.size.height/2+7, 18*WIDTH_SCALE, 18*HEIGHT_SCALE);
    self.daynumlabel.frame = CGRectMake(50*WIDTH_SCALE, self.frame.size.height/2+7*WIDTH_SCALE, 20*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.addbtn.frame = CGRectMake(90*WIDTH_SCALE, self.frame.size.height/2+7, 18*WIDTH_SCALE, 18*HEIGHT_SCALE);
    
    self.accountpricelabel.frame = CGRectMake(self.frame.size.width/3, self.frame.size.height/2+5, self.frame.size.width/3, self.frame.size.height/3);
    self.jiekuanlabel.frame = CGRectMake(self.frame.size.width/3, 10*HEIGHT_SCALE, self.frame.size.width/3, self.frame.size.height/3);
    
    self.returnpricelabel.frame = CGRectMake(self.frame.size.width/3*2, self.frame.size.height/2+5, self.frame.size.width/3, self.frame.size.height/3);
    self.huankuanlabel.frame = CGRectMake(self.frame.size.width/3*2, 10*HEIGHT_SCALE, self.frame.size.width/3, self.frame.size.height/3);
    
    self.linelabel0.frame = CGRectMake(self.frame.size.width/3, 3, 0.3, self.frame.size.height-6);
    self.linelabel1.frame = CGRectMake(self.frame.size.width/3*2, 3, 0.3, self.frame.size.height-6);
}

#pragma mark - getters


-(UILabel *)tianshulabel
{
    if(!_tianshulabel)
    {
        _tianshulabel = [[UILabel alloc] init];
       // _tianshulabel.backgroundColor = [UIColor redColor];
        _tianshulabel.text = @"天数";
        _tianshulabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tianshulabel;
}


-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"首页_19"] forState:normal];
    }
    return _addbtn;
}

-(UIButton *)delbtn
{
    if(!_delbtn)
    {
        _delbtn = [[UIButton alloc] init];
        [_delbtn setImage:[UIImage imageNamed:@"首页_17"] forState:normal];
    }
    return _delbtn;
}

-(UILabel *)daynumlabel
{
    if(!_daynumlabel)
    {
        _daynumlabel = [[UILabel alloc] init];
        _daynumlabel.textAlignment = NSTextAlignmentCenter;
        _daynumlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _daynumlabel;
}

-(UILabel *)accountpricelabel
{
    if(!_accountpricelabel)
    {
        _accountpricelabel = [[UILabel alloc] init];
        //_accountpricelabel.text = @"850";
        //_accountpricelabel.backgroundColor = [UIColor redColor];
        _accountpricelabel.textAlignment = NSTextAlignmentCenter;
        _accountpricelabel.font = [UIFont systemFontOfSize:16];
        _accountpricelabel.adjustsFontSizeToFitWidth = YES;
        _accountpricelabel.textColor = [UIColor wjColorFloat:@"0094DB"];
    }
    return _accountpricelabel;
}

-(UILabel *)jiekuanlabel
{
    if(!_jiekuanlabel)
    {
        _jiekuanlabel = [[UILabel alloc] init];
        _jiekuanlabel.textColor = [UIColor wjColorFloat:@"0094DB"];
        _jiekuanlabel.text = @"到账金额";
        _jiekuanlabel.textAlignment = NSTextAlignmentCenter;
        _jiekuanlabel.font = [UIFont systemFontOfSize:16];
        _jiekuanlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _jiekuanlabel;
}


-(UILabel *)huankuanlabel
{
    if(!_huankuanlabel)
    {
        _huankuanlabel = [[UILabel alloc] init];
        _huankuanlabel.textColor = [UIColor wjColorFloat:@"FD8C31"];
        _huankuanlabel.text = @"还款金额";
        _huankuanlabel.textAlignment = NSTextAlignmentCenter;
        _huankuanlabel.font = [UIFont systemFontOfSize:16];
        _huankuanlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _huankuanlabel;
}

-(UILabel *)returnpricelabel
{
    if(!_returnpricelabel)
    {
        _returnpricelabel = [[UILabel alloc] init];
        _returnpricelabel.textAlignment = NSTextAlignmentCenter;
        _returnpricelabel.font = [UIFont systemFontOfSize:16];
        _returnpricelabel.adjustsFontSizeToFitWidth = YES;
        _returnpricelabel.textColor = [UIColor wjColorFloat:@"FD8C31"];
    }
    return _returnpricelabel;
}


-(UILabel *)linelabel0
{
    if(!_linelabel0)
    {
        _linelabel0 = [[UILabel alloc] init];
        _linelabel0.backgroundColor = [UIColor wjColorFloat:@"B9B9B9"];
    }
    return _linelabel0;
}

-(UILabel *)linelabel1
{
    if(!_linelabel1)
    {
        _linelabel1 = [[UILabel alloc] init];
        _linelabel1.backgroundColor = [UIColor wjColorFloat:@"B9B9B9"];
    }
    return _linelabel1;
}

@end
