//
//  getmoneyCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "getmoneyCell.h"

@interface getmoneyCell()

@end

@implementation getmoneyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.bankcardtextfiled];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(10*WIDTH_SCALE, self.frame.size.height/2-15*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.bankcardtextfiled.frame = CGRectMake(65*WIDTH_SCALE, self.frame.size.height/2-15*HEIGHT_SCALE, DEVICE_WIDTH-85, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.textColor = [UIColor wjColorFloat:@"545454"];
    }
    return _leftlabel;
}

-(UITextField *)bankcardtextfiled
{
    if(!_bankcardtextfiled)
    {
        _bankcardtextfiled = [[UITextField alloc] init];
       // _bankcardtextfiled.backgroundColor = [UIColor greenColor];
    }
    return _bankcardtextfiled;
}



@end
