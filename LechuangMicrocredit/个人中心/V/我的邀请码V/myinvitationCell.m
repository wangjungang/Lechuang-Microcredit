//
//  myinvitationCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinvitationCell.h"

@implementation myinvitationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimage];
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.rightbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimage.frame = CGRectMake(15*WIDTH_SCALE, 15*HEIGHT_SCALE, 30*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(60*WIDTH_SCALE, 15*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.rightbtn.frame = CGRectMake(DEVICE_WIDTH-100*WIDTH_SCALE, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)leftimage
{
    if(!_leftimage)
    {
        _leftimage = [[UIImageView alloc] init];
       // _leftimage.backgroundColor = [UIColor greenColor];
    }
    return _leftimage;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        //_namelabel.backgroundColor = [UIColor redColor];
        _namelabel.textColor = [UIColor wjColorFloat:@"696969"];
    }
    return _namelabel;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        _rightbtn.layer.masksToBounds = YES;
        _rightbtn.layer.borderWidth = 1;
        _rightbtn.layer.borderColor = [UIColor wjColorFloat:@"90D6F3"].CGColor;
        [_rightbtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightbtn;
}

//按钮事件
-(void)test:(UIButton *)sender
{
    
    [self.delegate myTabVClick:self];
    
}
@end
