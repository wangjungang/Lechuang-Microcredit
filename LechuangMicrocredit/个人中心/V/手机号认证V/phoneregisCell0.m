//
//  phoneregisCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "phoneregisCell0.h"
@interface phoneregisCell0()
@property (nonatomic,strong) UILabel *leftlabel;
@end
@implementation phoneregisCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.phonelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(20*WIDTH_SCALE, 10*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.phonelabel.frame = CGRectMake(110*WIDTH_SCALE, 10*HEIGHT_SCALE, DEVICE_WIDTH-130*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.text = @"手机号码";
        _leftlabel.textColor = [UIColor wjColorFloat:@"989898"];
        _leftlabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftlabel;
}

-(UILabel *)phonelabel
{
    if(!_phonelabel)
    {
        _phonelabel = [[UILabel alloc] init];
        _phonelabel.textColor = [UIColor wjColorFloat:@"989898"];
       // _phonelabel.text = @"15510922836";
        _phonelabel.font = [UIFont systemFontOfSize:14];
    }
    return _phonelabel;
}

@end
