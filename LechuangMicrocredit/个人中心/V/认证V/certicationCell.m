//
//  certicationCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/12.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "certicationCell.h"
#import "certifocaModel.h"
@interface certicationCell()
@property (nonatomic,strong) certifocaModel *model;
@end

@implementation certicationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimage];
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.typelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimage.frame = CGRectMake(20*WIDTH_SCALE, self.frame.size.height/2-13*HEIGHT_SCALE,30*WIDTH_SCALE, 26*HEIGHT_SCALE);
    self.typelabel.frame = CGRectMake(DEVICE_WIDTH-100*WIDTH_SCALE, self.frame.size.height/2-10*HEIGHT_SCALE, 60*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.namelabel.frame = CGRectMake(60*WIDTH_SCALE, self.frame.size.height/2-15*HEIGHT_SCALE, 220*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)leftimage
{
    if(!_leftimage)
    {
        _leftimage = [[UIImageView alloc] init];
        //_leftimage.backgroundColor = [UIColor redColor];
    }
    return _leftimage;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
       // _namelabel.backgroundColor = [UIColor greenColor];
    }
    return _namelabel;
}

-(UILabel *)typelabel
{
    if(!_typelabel)
    {
        _typelabel = [[UILabel alloc] init];
        //_typelabel.backgroundColor = [UIColor redColor];
        //_typelabel.text = @"未完善";
        _typelabel.textAlignment = NSTextAlignmentRight;
        _typelabel.font = [UIFont systemFontOfSize:12];
        _typelabel.textColor = [UIColor wjColorFloat:@"BABABA"];
    }
    return _typelabel;
}

-(void)setcelldata:(certifocaModel *)cermodel
{
    self.model = cermodel;
    if ([cermodel.isequal isEqualToString:@"0"]) {
        self.typelabel.text = @"正在认证";
    }
    if ([cermodel.isequal isEqualToString:@"1"]) {
        self.typelabel.text = @"认证通过";
    }
    if ([cermodel.isequal isEqualToString:@"2"]) {
        self.typelabel.text = @"认证未通过";
    }
    if ([cermodel.isequal isEqualToString:@"3"]) {
        self.typelabel.text = @"未完善";
    }
}

@end
