//
//  LastView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "LastView.h"

@implementation LastView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.startlabel];
        [self addSubview:self.returnlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.startlabel.frame = CGRectMake(5*WIDTH_SCALE, 15*HEIGHT_SCALE, DEVICE_WIDTH/2-8*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.returnlabel.frame = CGRectMake(DEVICE_WIDTH/2, 15*HEIGHT_SCALE, DEVICE_WIDTH/2-8*WIDTH_SCALE, 20*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)startlabel
{
    if(!_startlabel)
    {
        _startlabel = [[UILabel alloc] init];
        _startlabel.textColor = [UIColor wjColorFloat:@"686868"];
        _startlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _startlabel;
}

-(UILabel *)returnlabel
{
    if(!_returnlabel)
    {
        _returnlabel = [[UILabel alloc] init];
        _returnlabel.textColor = [UIColor wjColorFloat:@"686868"];
        _returnlabel.textAlignment = NSTextAlignmentRight;
        _returnlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _returnlabel;
}

@end

