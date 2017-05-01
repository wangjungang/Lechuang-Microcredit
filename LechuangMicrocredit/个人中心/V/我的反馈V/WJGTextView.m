//
//  CustomTextVeiw.m
//  TextViewPlaceholder
//
//  Created by SunwinQuan on 15/12/26.
//  Copyright © 2015年 SunwinQuan. All rights reserved.
//

#import "WJGTextView.h"


@interface WJGTextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation WJGTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        self.customPlaceholderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        [self addSubview:self.numberlabel];
    }
    return self;
}

- (void)textDidChange{
    
    self.placeholderLabel.hidden = self.hasText;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize maxSize = CGSizeMake(self.placeholderLabel.frame.size.width, MAXFLOAT);
    float height = [self.customPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = CGRectMake(5, 8, self.frame.size.width - 10, height);
    
    self.numberlabel.frame = CGRectMake(self.frame.size.width-60, self.frame.size.height-30, 60, 30);
}



-(UILabel *)numberlabel
{
    if(!_numberlabel)
    {
        _numberlabel = [[UILabel alloc] init];
       // _numberlabel.backgroundColor = [UIColor greenColor];
        _numberlabel.textColor = [UIColor wjColorFloat:@"B9B9B9"];
        _numberlabel.font = [UIFont systemFontOfSize:14];
        _numberlabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberlabel;
}


-(void)setCustomPlaceholder:(NSString *)customPlaceholder{
    _customPlaceholder = customPlaceholder;
    self.placeholderLabel.text = customPlaceholder;
    [self setNeedsLayout];
}

-(void)setCustomPlaceholderColor:(UIColor *)customPlaceholderColor{
    _customPlaceholderColor = customPlaceholderColor;
    self.placeholderLabel.textColor = customPlaceholderColor;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
