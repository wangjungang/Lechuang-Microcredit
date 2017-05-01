//
//  messageCell.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "messageCell.h"
#import "messageModel.h"
@interface messageCell()
@property (nonatomic,strong) messageModel *messmodel;
@end
@implementation messageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titlelabel];
        [self.contentView addSubview:self.timelabel];
        [self.contentView addSubview:self.messageimage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake(10, 5, self.frame.size.width-20, 30);
    self.timelabel.frame = CGRectMake(10, 40, self.frame.size.width-30, 15);
    self.messageimage.frame = CGRectMake(10, 70, self.frame.size.width-20, 80);
}

#pragma mark - getters

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.textColor = [UIColor wjColorFloat:@"686868"];
    }
    return _titlelabel;
}

-(UILabel *)timelabel
{
    if(!_timelabel)
    {
        _timelabel = [[UILabel alloc] init];
        _timelabel.textColor = [UIColor wjColorFloat:@"8A8A8A"];
    }
    return _timelabel;
}

-(UIImageView *)messageimage
{
    if(!_messageimage)
    {
        _messageimage = [[UIImageView alloc] init];
    }
    return _messageimage;
}

-(void)setCellDate:(messageModel *)model
{
    self.messmodel = model;
    self.titlelabel.text = model.titlestr;
    self.timelabel.text = model.addtimestr;
    [self.messageimage sd_setImageWithURL:[NSURL URLWithString:model.pictureurl] placeholderImage:nil];
}

@end
