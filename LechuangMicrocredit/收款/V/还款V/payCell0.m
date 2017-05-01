//
//  payCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/23.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "payCell0.h"

@implementation payCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.moneylabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(15*WIDTH_SCALE, 10*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.moneylabel.frame = CGRectMake(100*WIDTH_SCALE, 10*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        
    }
    return _leftlabel;
}

-(UILabel *)moneylabel
{
    if(!_moneylabel)
    {
        _moneylabel = [[UILabel alloc] init];
        _moneylabel.textColor = [UIColor wjColorFloat:@"FD8C31"];
    }
    return _moneylabel;
}




@end
