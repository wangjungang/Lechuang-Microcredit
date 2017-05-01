//
//  topimage.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "topimage.h"
@interface topimage()
@property (nonatomic,strong) UILabel *toplabel;
@end
@implementation topimage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.toplabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.toplabel.frame = CGRectMake(self.frame.size.width/2-100, self.frame.size.height/2, 200, 50);
}

#pragma mark - getters


-(UILabel *)toplabel
{
    if(!_toplabel)
    {
        _toplabel = [[UILabel alloc] init];
        _toplabel.text = @"小额贷款";
        _toplabel.textAlignment = NSTextAlignmentCenter;
        _toplabel.textColor = [UIColor whiteColor];
        _toplabel.font = [UIFont systemFontOfSize:28];
    }
    return _toplabel;
}



@end
