//
//  registeredCell1.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/16.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "registeredCell1.h"

@implementation registeredCell1

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
    self.messagetext.frame = CGRectMake(5*WIDTH_SCALE, 10*HEIGHT_SCALE, self.frame.size.width-10*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

-(UITextField *)messagetext
{
    if(!_messagetext)
    {
        _messagetext = [[UITextField alloc] init];
       
    }
    return _messagetext;
}

@end
