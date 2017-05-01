//
//  forgetwaitCell0.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/29.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "forgetwaitCell0.h"
@interface forgetwaitCell0()
@property (nonatomic,strong) UILabel *titlelabel;

@end
@implementation forgetwaitCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.messagelabel];
        [self.contentView addSubview:self.submitbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake(20*WIDTH_SCALE, 10*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.messagelabel.frame = CGRectMake(20*WIDTH_SCALE, 45*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 25*HEIGHT_SCALE);
    self.submitbtn.frame = CGRectMake(20*WIDTH_SCALE, 80*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 50*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"方法一";
        _titlelabel.textColor = [UIColor wjColorFloat:@"373737"];
    }
    return _titlelabel;
}

-(UILabel *)messagelabel
{
    if(!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.textColor = [UIColor wjColorFloat:@"686868"];
        //_messagelabel.text = @"联系10086运营客服进行设置";
        _messagelabel.font = [UIFont systemFontOfSize:13];
    }
    return _messagelabel;
}

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        [_submitbtn setTitle:@"联系客服" forState:normal];
        _submitbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        _submitbtn.layer.masksToBounds = YES;
        _submitbtn.layer.cornerRadius = 25*HEIGHT_SCALE;
    }
    return _submitbtn;
}


@end
