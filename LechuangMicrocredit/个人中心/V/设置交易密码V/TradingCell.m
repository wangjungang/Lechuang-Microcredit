//
//  TradingCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/19.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "TradingCell.h"

@implementation TradingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.messagetext];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.messagetext.frame = CGRectMake(5*WIDTH_SCALE, 15*HEIGHT_SCALE, self.frame.size.width-10*WIDTH_SCALE, 30*HEIGHT_SCALE);
}


-(UITextField *)messagetext
{
    if(!_messagetext)
    {
        _messagetext = [[UITextField alloc] init];
        _messagetext.secureTextEntry = YES;
    }
    return _messagetext;
}
@end
