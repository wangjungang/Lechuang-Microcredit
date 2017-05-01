//
//  myjobViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myjobViewController.h"
#import "myjobCell0.h"
#import "myjobCell1.h"
#import "myjobCell2.h"
#import "ValuePickerView.h"
#import "TWSelectCityView.h"
#import "WJGimageViewController.h"
@interface myjobViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,WJGImagePickerControllerDelegate>

@property (nonatomic,strong) UITableView *myjobtableview;
@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic,strong) WJGimageViewController *wjgimagepick;

@property (nonatomic,strong) NSString *workimageurl;
@end

static NSString *myjobidentfid0 = @"myjobidentfid0";
static NSString *myjobidentfid1 = @"myjobidentfid1";
static NSString *myjobidentfid2 = @"myjobidentfid2";
static NSString *myjobidentfid3 = @"myjobidentfid3";
static NSString *myjobidentfid4 = @"myjobidentfid4";
static NSString *myjobidentfid5 = @"myjobidentfid5";

@implementation myjobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.myjobtableview addGestureRecognizer:TapGestureTecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pickerView = [[ValuePickerView alloc] init];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"工作认证"];
    [self.view addSubview:customNavView];
    self.workimageurl = [[NSString alloc] init];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self saveclick];
    };
    [self.view addSubview:self.myjobtableview];
    
    self.myjobtableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myjobtableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);

}

#pragma mark - getters

-(UITableView *)myjobtableview
{
    if(!_myjobtableview)
    {
        _myjobtableview = [[UITableView alloc] init];
        _myjobtableview.dataSource = self;
        _myjobtableview.delegate = self;
        _myjobtableview.scrollEnabled = NO;
    }
    return _myjobtableview;
}

-(WJGimageViewController *)wjgimagepick
{
    if(!_wjgimagepick)
    {
        _wjgimagepick = [[WJGimageViewController alloc] initWithIsCaches:NO andIdentifier:@"abc"];
        _wjgimagepick.delegate = self;
        
    }
    return _wjgimagepick;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        myjobCell0 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid0];
        if (!cell) {
            cell = [[myjobCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid0];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.leftlabel.text = @"工作类型";
        cell.messagelabel.tag = 101;
        return cell;
    }
    if (indexPath.row==1) {
        myjobCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid1];
        if (!cell) {
            cell = [[myjobCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.leftlabel.text = @"单位名称";
        cell.myjobtext.delegate = self;
        cell.myjobtext.tag = 1;
        cell.myjobtext.placeholder = @"请填写单位名称";
        return cell;
    }
    if (indexPath.row==2) {
        myjobCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid2];
        if (!cell) {
            cell = [[myjobCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.leftlabel.text = @"单位电话";
        cell.myjobtext.delegate = self;
        cell.myjobtext.tag = 2;
        cell.myjobtext.placeholder = @"请填写单位电话";
        cell.myjobtext.keyboardType = UIKeyboardTypePhonePad;
        return cell;
    }
    if (indexPath.row==3) {
        myjobCell0 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid3];
        if (!cell) {
            cell = [[myjobCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid3];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.leftlabel.text = @"单位所在地";
        cell.leftlabel.adjustsFontSizeToFitWidth = YES;
        cell.messagelabel.tag = 101;
        cell.rightbtn.tag = 200;
        [cell.rightbtn setTitle:@"北京市" forState:normal];
        return cell;
    }
    if (indexPath.row==4) {
        myjobCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid4];
        if (!cell) {
            cell = [[myjobCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell.leftlabel setHidden:YES];
        cell.myjobtext.delegate = self;
        cell.myjobtext.tag = 3;
        cell.myjobtext.placeholder = @"请填写具体地址";
        return cell;
    }
    if (indexPath.row==5) {
        myjobCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myjobidentfid5];
        if (!cell) {
            cell = [[myjobCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myjobidentfid5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.leftlabel.text = @"工作照片";
        cell.leftlabel.adjustsFontSizeToFitWidth = YES;
        //[cell.rightbtn setHidden:YES];
       // cell.messagelabel.text = @"选填，填写可提高通过率";
        cell.workimage.tag = 400;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self workValuechanggeEvent];
    }
    if (indexPath.row == 3)
    {
        [self addresspick];
    }
    if (indexPath.row==5) {
        [self selectImageClicked];
    }
}

#pragma mark - 实现方法

-(void)keyboardHide
{
    UITextField *text1 = [self.myjobtableview viewWithTag:1];
    UITextField *text2 = [self.myjobtableview viewWithTag:2];
    UITextField *text3 = [self.myjobtableview viewWithTag:3];
    [text1  resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}

-(void)saveclick
{
    NSLog(@"保存");
    //工作类型
    UILabel *typelabel = [self.myjobtableview viewWithTag:101];
    NSString *typestr = [[NSString alloc] init];
    if (typelabel.text!=nil||typelabel.text!=NULL) {
        typestr = typelabel.text;
    }
    NSLog(@"tyoestr=====%@",typestr);
    
    //单位名称
    UITextField *unitnametext = [self.myjobtableview viewWithTag:1];
    NSString *unitnamestr = [[NSString alloc] init];
    if (typelabel.text!=nil||typelabel.text!=NULL) {
        unitnamestr = unitnametext.text;
    }
    NSLog(@"unitname=====%@",unitnamestr);
    
    //单位电话
    UITextField *phonetext = [self.myjobtableview viewWithTag:2];
    NSString *phonestr = [[NSString alloc] init];
    if (phonetext.text!=nil||phonetext.text!=NULL) {
        phonestr = phonetext.text;
    }
    NSLog(@"unitphone=====%@",phonestr);
    
    //单位地区
    UILabel *arealabel = [self.myjobtableview viewWithTag:101];
    NSString *areastr = [[NSString alloc] init];
    if (arealabel.text!=nil||arealabel.text!=NULL) {
         areastr = arealabel.text;
    }
    NSLog(@"areastr=====%@",areastr);
    
    //单位地址
    UITextField *addresstext = [self.myjobtableview viewWithTag:3];
    NSString *addressstr = addresstext.text;
    NSLog(@"address=====%@",addressstr);
    
    //工作照片
    
    
    NSDictionary *dic = @{@"uid":UID,@"type":typestr,@"unitname":unitnamestr,@"unitphone":phonestr,@"unitarea":areastr,@"unitaddress":addressstr,@"unitphoto":self.workimageurl};
   
    NSLog(@"dic======%@",dic);
    
//    [AFManager postReqURL:workAdd reqBody:dic block:^(id infor) {
//        if ([[infor objectForKey:@"code"]integerValue]==200)
//        {
//            [NSObject wj_showHUDWithTip:@"保存成功"];
//        }
//        if ([[infor objectForKey:@"code"]integerValue]==201)
//        {
//            [NSObject wj_showHUDWithTip:@"请检查网络"];
//        }
//        
//    }];
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 选择器
- (void)workValuechanggeEvent {
    
    self.pickerView.dataSource =@[@"学生族",@"上班族",@"自由职业"];
    self.pickerView.pickerTitle = @"职业";
    UILabel *message101 = [self.myjobtableview viewWithTag:101];
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        message101.text= stateArr[0];
    };
    
    [self.pickerView show];
    
}

-(void)addresspick
{
    TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:self.view.bounds TWselectCityTitle:@"选择地区"];
    //__weak typeof(self)blockself = self;
    UILabel *message = [self.myjobtableview viewWithTag:101];
    UIButton *addbtn = [self.myjobtableview viewWithTag:200];
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        //blockself.strLB.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
        message.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
        [addbtn setTitle:[NSString stringWithFormat:@"%@",proviceStr] forState:normal];
    }];
}

#pragma mark - 图片选择

- (void)selectImageClicked{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选取图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.wjgimagepick selectImageFromCameraSuccess:^(UIImagePickerController *imagePickerController) {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        } fail:^{
            NSLog(@"无法获取相机权限");
        }];
    }];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.wjgimagepick selectImageFromAlbumSuccess:^(UIImagePickerController *imagePickerController) {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        } fail:^{
            NSLog(@"无法获取相簿权限");
        }];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cameraAction];
    [alert addAction:photoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)selectImageFinished:(UIImage *)image{
    //_imageView.image = image;
    UIImageView *workimage = [self.myjobtableview viewWithTag:400];
    workimage.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData*data=UIImageJPEGRepresentation(image,1);
    NSString *str = @"face";
    NSString *imageName=[str stringByAppendingFormat:@".JPEG"];
    NSLog(@"imagename====%@",imageName);
    NSLog(@"data=-------%@",data);
    [AFManager upLoadpath:UploadsIos reqBody:@{} file:data fileName:imageName fileType:@"image/jpeg" block:^(id infor) {
        NSLog(@"%@",infor);
        
        NSError *err;
        NSData *jsondata = [infor dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsondic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableLeaves error:&err];
        NSLog(@"jsondic=====%@",jsondic);
        
        
        NSString *imageurl = [jsondic objectForKey:@"url"];
        NSString *inforStr = [imageurl stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSString *inforStr2 = [inforStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"inforstr2======%@",inforStr2);
        
        if (inforStr2!=nil||inforStr2!=NULL) {
            [NSObject wj_showHUDWithTip:@"设置成功"];
        }else
        {
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }
        self.workimageurl = inforStr2;
    } errorBlock:^(NSError *error) {
        
    }];

}

- (void)selectImageFinishedAndCaches:(UIImage * )image cachesIdentifier:(NSString *)identifier isCachesSuccess:(BOOL)isCaches
{
    UIImageView *workimage = [self.myjobtableview viewWithTag:400];
    if (isCaches) {
        workimage.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
