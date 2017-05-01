//
//  mainview.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "mainview.h"
@interface mainview()
@property (nonatomic,strong) UIImageView *mainimage;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *xinyongedulabel;
@end

@implementation mainview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainimage];
        [self addSubview:self.namelabel];
        [self addSubview:self.ascensionbtn];
        [self addSubview:self.accountlabel];
        [self addSubview:self.certificationlabel];
        [self addSubview:self.xinyongedulabel];
        [self addSubview:self.pricenumlabel];
        [self addSubview:self.borrownumberlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.mainimage.frame = CGRectMake(15, 15, 18*WIDTH_SCALE, 15*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(40, 15, 100*WIDTH_SCALE, 15*HEIGHT_SCALE);
    self.ascensionbtn.frame = CGRectMake(14, self.frame.size.height/2, 100*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.accountlabel.frame = CGRectMake(14, self.frame.size.height-30, self.frame.size.width/2-40, 20*HEIGHT_SCALE);
    self.certificationlabel.frame = CGRectMake(self.frame.size.width/2+60*WIDTH_SCALE, 12*HEIGHT_SCALE, 50*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.xinyongedulabel.frame = CGRectMake(self.frame.size.width/2+50*WIDTH_SCALE, 35*HEIGHT_SCALE, 70*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.pricenumlabel.frame = CGRectMake(self.frame.size.width/2+50*WIDTH_SCALE, 65*HEIGHT_SCALE, 70*WIDTH_SCALE, 40*HEIGHT_SCALE);
    self.borrownumberlabel.frame = CGRectMake(self.frame.size.width/2+60*WIDTH_SCALE, self.frame.size.height-30*HEIGHT_SCALE, 50, 20);
    
}

#pragma mark - getters


-(UIImageView *)mainimage
{
    if(!_mainimage)
    {
        _mainimage = [[UIImageView alloc] init];
        _mainimage.image = [UIImage imageNamed:@"首页_13"];
    }
    return _mainimage;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"乐创现金";
        _namelabel.font = [UIFont systemFontOfSize:15];
    }
    return _namelabel;
}

-(UIButton *)ascensionbtn
{
    if(!_ascensionbtn)
    {
        _ascensionbtn = [[UIButton alloc] init];
        [_ascensionbtn setTitle:@"提升额度" forState:normal];
        [_ascensionbtn setTitleColor:[UIColor wjColorFloat:@"5EACDE"] forState:normal];
        
    }
    return _ascensionbtn;
}

-(UILabel *)accountlabel
{
    if(!_accountlabel)
    {
        _accountlabel = [[UILabel alloc] init];
       // _accountlabel.backgroundColor = [UIColor redColor];
        _accountlabel.text = @"5139 8837 3727 1221";
        _accountlabel.font = [UIFont systemFontOfSize:11];
        _accountlabel.adjustsFontSizeToFitWidth = YES;
        _accountlabel.textColor = [UIColor wjColorFloat:@"959595"];
    }
    return _accountlabel;
}

-(UILabel *)certificationlabel
{
    if(!_certificationlabel)
    {
        _certificationlabel = [[UILabel alloc] init];
        _certificationlabel.backgroundColor = [UIColor wjColorFloat:@"93C9E7"];
        _certificationlabel.layer.masksToBounds = YES;
        _certificationlabel.layer.cornerRadius = 5;
       // _certificationlabel.text = @"认证0/5";
        _certificationlabel.adjustsFontSizeToFitWidth = YES;
        _certificationlabel.textAlignment = NSTextAlignmentCenter;
        _certificationlabel.textColor = [UIColor whiteColor];
    }
    return _certificationlabel;
}

-(UILabel *)xinyongedulabel
{
    if(!_xinyongedulabel)
    {
        _xinyongedulabel = [[UILabel alloc] init];
        _xinyongedulabel.text = @"信用额度(元)";
        _xinyongedulabel.font = [UIFont systemFontOfSize:12];
        _xinyongedulabel.adjustsFontSizeToFitWidth = YES;
        _xinyongedulabel.textColor = [UIColor wjColorFloat:@"888888"];
        
    }
    return _xinyongedulabel;
}

-(UILabel *)pricenumlabel
{
    if(!_pricenumlabel)
    {
        _pricenumlabel = [[UILabel alloc] init];
        _pricenumlabel.textColor = [UIColor wjColorFloat:@"189CDB"];
       // _pricenumlabel.text = @"1000";
       // _pricenumlabel.backgroundColor = [UIColor greenColor];
        _pricenumlabel.textAlignment = NSTextAlignmentCenter;
        _pricenumlabel.font = [UIFont systemFontOfSize:28];
        _pricenumlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _pricenumlabel;
}

-(UILabel *)borrownumberlabel
{
    if(!_borrownumberlabel)
    {
        _borrownumberlabel = [[UILabel alloc] init];
        _borrownumberlabel.text = @"借款次数:0";
        _borrownumberlabel.textColor = [UIColor wjColorFloat:@"959595"];
       // _borrownumberlabel.backgroundColor = [UIColor greenColor];
        _borrownumberlabel.adjustsFontSizeToFitWidth = YES;
        _borrownumberlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _borrownumberlabel;
}



@end
