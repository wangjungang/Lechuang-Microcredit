//
//  repaymentCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/13.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "repaymentCell.h"
#import "repayModel.h"
@interface repaymentCell()
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) repayModel *repaymodel;
@end
@implementation repaymentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.timelabel];
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.pricelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.timelabel.frame = CGRectMake(10*WIDTH_SCALE, 10*HEIGHT_SCALE, DEVICE_WIDTH/2-20*WIDTH_SCALE, self.frame.size.height-20*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(180*WIDTH_SCALE, 10*HEIGHT_SCALE, 40*WIDTH_SCALE, self.frame.size.height-20);
    self.pricelabel.frame = CGRectMake(DEVICE_WIDTH-120*WIDTH_SCALE, 10*HEIGHT_SCALE, 100*WIDTH_SCALE, self.frame.size.height-20);
}

#pragma mark - getters

-(UILabel *)timelabel
{
    if(!_timelabel)
    {
        _timelabel = [[UILabel alloc] init];
         _timelabel.font = [UIFont systemFontOfSize:14];
        _timelabel.textColor = [UIColor wjColorFloat:@"686868"];
    }
    return _timelabel;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"还款";
        _namelabel.textColor = [UIColor wjColorFloat:@"686868"];
    }
    return _namelabel;
}

-(UILabel *)pricelabel
{
    if(!_pricelabel)
    {
        _pricelabel = [[UILabel alloc] init];
        _pricelabel.textColor = [UIColor wjColorFloat:@"686868"];
        _pricelabel.textAlignment = NSTextAlignmentRight;
    }
    return _pricelabel;
}

-(void)setcelldata:(repayModel *)model
{
    self.repaymodel = model;
    self.timelabel.text = model.timestr;
    self.pricelabel.text = model.money;
}
@end
