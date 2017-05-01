//
//  myboundstitleView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myboundstitleView.h"

@interface myboundstitleView()
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UIImageView *rightimage;
@end

@implementation myboundstitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titlelabel];
        [self addSubview:self.rightimage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake(10, 10, DEVICE_WIDTH-20, 10);
    self.rightimage.frame = CGRectMake(DEVICE_WIDTH-20, 10, 8, 10);
}


#pragma mark - getters

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"请先绑定银行卡，再领奖金";
        _titlelabel.font = [UIFont systemFontOfSize:14];
        _titlelabel.textColor = [UIColor wjColorFloat:@"D03B3D"];
    }
    return _titlelabel;
}

-(UIImageView *)rightimage
{
    if(!_rightimage)
    {
        _rightimage = [[UIImageView alloc] init];
        _rightimage.image = [UIImage imageNamed:@"帮助_08"];
    }
    return _rightimage;
}



@end
