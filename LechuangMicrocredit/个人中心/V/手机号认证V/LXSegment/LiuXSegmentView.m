//
//  LiuXSegmentView.m
//  LiuXSegment
//
//  Created by liuxin on 16/3/18.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

#import "LiuXSegmentView.h"
#import "CALayer+LXAdd.h"
#import "NSString+Size.h"

@interface LiuXSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *titlesStrWidthArray;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;
@end

@implementation LiuXSegmentView


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.shadowColor=[UIColor blackColor].CGColor;
        self.layer.shadowOffset=CGSizeMake(2, 2);
        self.layer.shadowRadius=2;
        self.layer.shadowOpacity=.2;
        
        _titles=titleArray;
        
        [self initData];
        
        [self initViews];
        
        self.block=block;
       
    }
    
    return self;
}

-(void)initData{
    _btn_w=0.0;
    if (_titles.count<MAX_TitleNumInWindow+1) {
        _btn_w=windowContentWidth/_titles.count;
    }else{
        _btn_w=windowContentWidth/MAX_TitleNumInWindow;
    }
  
    _defaultIndex=1;
    _titleFont=[UIFont systemFontOfSize:15];
    _btns=[[NSMutableArray alloc] initWithCapacity:0];
    _titleNomalColor=[UIColor blackColor];
    _titleSelectColor=SFQRedColor;
}

-(void)initViews{
    self.bgScrollView.contentSize=CGSizeMake(_btn_w*_titles.count, self.frame.size.height);
    [self addSubview:_bgScrollView];
    
    [self.bgScrollView addSubview:self.selectLine];
    
    for (int i=0; i<_titles.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
        btn.tag=i+1;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font=_titleFont;
        [_bgScrollView addSubview:btn];
        [_btns addObject:btn];
        if (i==0) {
            _titleBtn=btn;
            btn.selected=YES;
        }
        
        //计算字串长度
        CGFloat strW = [self getlineWidth:i];
        [self.titlesStrWidthArray addObject:@(strW)];
    }
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        CGFloat lineW = [self.titlesStrWidthArray[btn.tag-1] floatValue];
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x+(_btn_w-lineW)/2, self.frame.size.height-2, lineW, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)updateselectLineFrameWithoffset:(CGFloat)offsetx{
//    NSLog(@"====%f",offsetx);
    for (UIButton *btn in _btns) {
       
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;

            CGFloat w = [self.titlesStrWidthArray[btn.tag-1] floatValue];//字的宽度
            CGFloat line_x = (_btn_w-w)/2+(btn.tag-1)*_btn_w;
            CGFloat nextw=0;
            if (offsetx<(btn.tag-1)*windowContentWidth) {
                NSLog(@"向左");
                nextw = [self.titlesStrWidthArray[btn.tag-2] floatValue];
                CGFloat max_w = (_btn_w*2 + w +nextw)/2;
                CGFloat endoffsetx = (btn.tag-1)*windowContentWidth-offsetx;
                
                if (_selectLine.layer.width<max_w) {
                    _selectLine.layer.width=w+MIN(endoffsetx, max_w);
                }else{
               
                    _selectLine.layer.width=max_w;
                }
                _selectLine.layer.right=line_x+w;
                
            }else{
                NSLog(@"向右");
                nextw = [self.titlesStrWidthArray[btn.tag] floatValue];
                CGFloat max_w = (_btn_w*2 + w +nextw)/2;
                CGFloat endoffsetx = offsetx - (btn.tag-1)*windowContentWidth;
                if (_selectLine.layer.width<max_w) {
                    _selectLine.layer.width=w+MIN(endoffsetx, max_w);
                }else{
                    _selectLine.layer.width=max_w;
                }
                
            }
            
        }else{
            
        }
    }
}

-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            CGFloat lineW = [self.titlesStrWidthArray[btn.tag-1] floatValue];

            [UIView animateWithDuration:0.3 animations:^{
                _selectLine.layer.left=btn.frame.origin.x+(_btn_w-lineW)/2;
                _selectLine.layer.width=lineW;
            }];
           
        }else{
            btn.selected=NO;
        }
    }
}

//获取线的宽度
-(CGFloat)getlineWidth:(NSInteger )strIndex{
    NSString *firstStr = _titles[strIndex];
    CGFloat lineW = [firstStr widthWithFont:_titleFont constrainedToHeight:self.frame.size.height-2]+4;
    
    return lineW;
}

#pragma mark ---INITUI---

-(NSMutableArray *)titlesStrWidthArray{
    if (!_titlesStrWidthArray) {
        _titlesStrWidthArray = [[NSMutableArray alloc] init];
    }
    return _titlesStrWidthArray;
}

-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
      
    }
    return _bgScrollView;
}

-(UIView *)selectLine{
    if (!_selectLine) {
        CGFloat lineW = [self getlineWidth:0];
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake((_btn_w-lineW)/2, self.frame.size.height-2, lineW, 2)];
        _selectLine.backgroundColor=_titleSelectColor;
    }
    return _selectLine;
}


@end
