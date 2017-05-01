//
//  homeTimeCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/21.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "homeTimeCell.h"

@implementation homeTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.timelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.namelabel.frame = CGRectMake(10*WIDTH_SCALE, 10*HEIGHT_SCALE, DEVICE_WIDTH/2-20, 30*HEIGHT_SCALE);
    self.timelabel.frame = CGRectMake(DEVICE_WIDTH/2, 10*HEIGHT_SCALE, DEVICE_WIDTH/2-20, 30*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.textColor = [UIColor wjColorFloat:@"686868"];
    }
    return _namelabel;
}

-(UILabel *)timelabel
{
    if(!_timelabel)
    {
        _timelabel = [[UILabel alloc]init];;
        _timelabel.textColor = [UIColor wjColorFloat:@"686868"];
        _timelabel.textAlignment = NSTextAlignmentRight;
    }
    return _timelabel;
}




@end
