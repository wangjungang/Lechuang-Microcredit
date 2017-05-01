//
//  placeholderView.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/20.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "placeholderView.h"
@interface placeholderView()
@property (nonatomic,strong)UIImageView *messimage;
@property (nonatomic,strong)UILabel *messlabel;
@end

@implementation placeholderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.messimage];
        [self addSubview:self.messlabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.messimage.frame = CGRectMake(self.frame.size.width/2-40*WIDTH_SCALE, 64+50*HEIGHT_SCALE, 80*WIDTH_SCALE, 80*HEIGHT_SCALE);
    self.messlabel.frame = CGRectMake(self.frame.size.width/2-80*HEIGHT_SCALE, 64+150*HEIGHT_SCALE, 160*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)messimage
{
    if(!_messimage)
    {
        _messimage = [[UIImageView alloc] init];
        _messimage.image = [UIImage imageNamed:@"还款_03"];
    }
    return _messimage;
}

-(UILabel *)messlabel
{
    if(!_messlabel)
    {
        _messlabel = [[UILabel alloc] init];
       // _messlabel.backgroundColor = [UIColor redColor];
        _messlabel.textAlignment = NSTextAlignmentCenter;
        _messlabel.font = [UIFont systemFontOfSize:14];
        _messlabel.text = @"您还没有借款记录哦~";
        _messlabel.textColor = [UIColor wjColorFloat:@"8A8A8A"];
    }
    return _messlabel;
}


@end
