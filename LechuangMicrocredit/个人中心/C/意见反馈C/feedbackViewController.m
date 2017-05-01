//
//  feedbackViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "feedbackViewController.h"
#import "WJGTextView.h"
@interface feedbackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIButton *submitbtn;
@property (nonatomic,strong) WJGTextView *feedbacktext;
@end

@implementation feedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:TapGestureTecognizer];

    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"意见反馈"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.submitbtn];
    [self.view addSubview:self.feedbacktext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.feedbacktext.frame = CGRectMake(20, 84, DEVICE_WIDTH-40, DEVICE_HEIGHT/3);
    self.submitbtn.frame = CGRectMake(DEVICE_WIDTH/2-DEVICE_WIDTH/3, 104+DEVICE_HEIGHT/3, DEVICE_WIDTH/3*2, 50);
}

#pragma mark - getters

-(UIButton *)submitbtn
{
    if(!_submitbtn)
    {
        _submitbtn = [[UIButton alloc] init];
        _submitbtn.backgroundColor = [UIColor wjColorFloat:@"B9B9B9"];
        [_submitbtn setTitle:@"提交" forState:normal];
        _submitbtn.layer.masksToBounds = YES;
        _submitbtn.layer.cornerRadius = 25;
       
    }
    return _submitbtn;
}

-(WJGTextView *)feedbacktext
{
    if(!_feedbacktext)
    {
        _feedbacktext = [[WJGTextView alloc] init];
        _feedbacktext.layer.masksToBounds = YES;
        _feedbacktext.layer.cornerRadius = 10;
        _feedbacktext.layer.borderWidth = 0.2;
        _feedbacktext.delegate = self;
        _feedbacktext.customPlaceholder = @"请输入您的意见，我们会为您不断改进";
        _feedbacktext.numberlabel.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)_feedbacktext.text.length];
    }
    return _feedbacktext;
}

-(void)keyboardHide
{
    [self.feedbacktext resignFirstResponder];
}

-(void)submitbtnclick
{
    NSLog(@"提交");
    NSDictionary *dic = @{@"uid":UID,@"content":self.feedbacktext.text};
    [AFManager postReqURL:addfeedback reqBody:dic block:^(id infor) {
        NSLog(@"info====%@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"反馈成功"];
        }
        if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }

    }];
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    //允许提交按钮点击操作
   
    self.submitbtn.backgroundColor = [UIColor wjColorFloat:@"B9B9B9"];
    self.submitbtn.userInteractionEnabled = NO;
    //实时显示字数
    self.feedbacktext.numberlabel.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    
    //字数限制操作
    if (textView.text.length >= 200) {
        
        textView.text = [textView.text substringToIndex:200];
        self.feedbacktext.numberlabel.text = @"200/200";
        
    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length != 0) {
        
        self.submitbtn.userInteractionEnabled = YES;
        self.submitbtn.backgroundColor = [UIColor wjColorFloat:@"008CCF"];
        [_submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

@end
