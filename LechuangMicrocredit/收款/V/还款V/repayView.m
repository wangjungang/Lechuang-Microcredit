//
//  repayView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "repayView.h"
@interface repayView()
@property (nonatomic,strong) UIImageView *repayimage;
@property (nonatomic,strong) UILabel *titlelabel;
@end
@implementation repayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.repayimage];
        [self addSubview:self.titlelabel];
        [self addSubview:self.repaybtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.repayimage.frame = CGRectMake(self.frame.size.width/2-40*WIDTH_SCALE, 30*HEIGHT_SCALE, 80*WIDTH_SCALE, 80*HEIGHT_SCALE);
    self.titlelabel.frame = CGRectMake(self.frame.size.width/2-100*WIDTH_SCALE, 130*HEIGHT_SCALE, 200*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.repaybtn.frame = CGRectMake(self.frame.size.width/2-80*WIDTH_SCALE, 180*HEIGHT_SCALE, 160*WIDTH_SCALE, 40*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)repayimage
{
    if(!_repayimage)
    {
        _repayimage = [[UIImageView alloc] init];
        _repayimage.image = [UIImage imageNamed:@"还款_03"];
    }
    return _repayimage;
}

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"您还没有还款记录哦";
        _titlelabel.textColor = [UIColor wjColorFloat:@"8A8A8A"];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

-(UIButton *)repaybtn
{
    if(!_repaybtn)
    {
        _repaybtn = [[UIButton alloc] init];
        [_repaybtn setTitle:@"马上申请" forState:normal];
        _repaybtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        _repaybtn.layer.masksToBounds = YES;
        _repaybtn.layer.cornerRadius = 20*HEIGHT_SCALE;
    }
    return _repaybtn;
}

@end
