//
//  myinfoViewController.m
//  LechuangMicrocredit
//
//  Created by 王俊钢 on 2016/12/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "myinfoViewController.h"
#import "myinfoCell0.h"
#import "myinfoCell1.h"
#import "myinfoCell2.h"
#import "myinfoCell3.h"

#import "CityView.h"
#import "ValuePickerView.h"
#import "TWSelectCityView.h"
static NSString *myinfoidentfid0 = @"myinfoidentfid0";
static NSString *myinfoidentfid1 = @"myinfoidentfid1";
static NSString *myinfoidentfid2 = @"myinfoidentfid2";
static NSString *myinfoidentfid3 = @"myinfoidentfid3";
@interface myinfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,myinfodelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *myinfotableview;

@property (nonatomic,strong) NSString *typestr;

@property (nonatomic, strong) ValuePickerView *pickerView;

@property (nonatomic,strong) NSString *faceurlstr;
@property (nonatomic,strong) NSString *idcardpositiveurl;
@property (nonatomic,strong) NSString *idcardreverseurl;
@end

@implementation myinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.myinfotableview addGestureRecognizer:TapGestureTecognizer];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"保存" title:@"认证"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock = ^{
        [self saveinfo];
    };
    
    self.faceurlstr = [[NSString alloc] init];
    self.idcardpositiveurl = [[NSString alloc] init];
    self.idcardreverseurl = [[NSString alloc] init];
    
    self.pickerView = [[ValuePickerView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myinfotableview];
    
    self.myinfotableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myinfotableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    
}

#pragma mark - getters

-(UITableView *)myinfotableview
{
    if(!_myinfotableview)
    {
        _myinfotableview = [[UITableView alloc] init];
        _myinfotableview.dataSource = self;
        _myinfotableview.delegate = self;
        _myinfotableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _myinfotableview;
}



-(void)addresspick
{
    TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:self.view.bounds TWselectCityTitle:@"选择地区"];
    //__weak typeof(self)blockself = self;
    UILabel *message = [self.myinfotableview viewWithTag:42];
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        //blockself.strLB.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
        message.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,distr];
       
    }];
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 2;
    }
    if (section==2) {
        return 2;
    }
    if (section==3) {
        return 2;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        myinfoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid0];
        if (!cell) {
            cell = [[myinfoCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid0];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.leftlabel.text = @"人脸识别";
            cell.setimage.frame = CGRectMake(DEVICE_WIDTH/2, 15*HEIGHT_SCALE, 60*WIDTH_SCALE, 60*HEIGHT_SCALE);
            [cell.setimage setImage:[UIImage imageNamed:@"个人信息_03"] forState:normal];
            cell.setimage.tag = 300;
        }
        if (indexPath.row==1) {
            cell.leftlabel.text = @"身份证识别";
            cell.setimage.frame = CGRectMake(DEVICE_WIDTH/3, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 60*HEIGHT_SCALE);
             cell.setimage2.frame = CGRectMake(DEVICE_WIDTH/3*2, 15*HEIGHT_SCALE, 80*WIDTH_SCALE, 60*HEIGHT_SCALE);
             [cell.setimage2 setImage:[UIImage imageNamed:@"bei"] forState:normal];
             [cell.setimage setImage:[UIImage imageNamed:@"个人信息_06"] forState:normal];
            cell.setimage.tag = 301;
            cell.setimage2.tag = 302;

        }
        return cell;
    }
    if (indexPath.section==1) {
        myinfoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid1];
        if (!cell) {
            cell = [[myinfoCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid1];
        }
        cell.infotextfiled.delegate = self;
        if (indexPath.row==0) {
            cell.leftlabel.text = @"姓名";
            cell.infotextfiled.placeholder = @"请输入姓名";
            cell.infotextfiled.tag = 2;
        }
        if (indexPath.row==1) {
            cell.leftlabel.text = @"身份证号";
            cell.infotextfiled.placeholder = @"请输入身份证号";
            cell.infotextfiled.tag = 3;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        myinfoCell2 *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid2];
        if (!cell) {
            cell = [[myinfoCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid2];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.leftlabel.text = @"学历";
            cell.messagelabel.tag = 32;
        }
        if (indexPath.row==1) {
            cell.leftlabel.text = @"现居地址";
            [cell.rightbtn setHidden:YES];
            cell.messagelabel.tag = 42;
        }
        return cell;
    }
    if (indexPath.section==3) {
        myinfoCell3 *cell = [tableView dequeueReusableCellWithIdentifier:myinfoidentfid3];
        if (!cell) {
            cell = [[myinfoCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfoidentfid3];
        }
        if (indexPath.row==0) {
            cell.detailedaddresstext.tag=4;
            [cell.leftlabel setHidden:YES];
            cell.detailedaddresstext.placeholder = @"请输入具体地址";
        }
        if (indexPath.row==1) {
            //cell.detailedaddresstext.tag = 5;
            cell.leftlabel.text = @"婚姻状态";
            cell.messagelabel.frame =  CGRectMake(110*WIDTH_SCALE, 15*HEIGHT_SCALE, DEVICE_WIDTH-180*WIDTH_SCALE, 30*HEIGHT_SCALE);
            cell.messagelabel.text = @"(选填)";
            cell.messagelabel.tag = 52;
            [cell.detailedaddresstext setHidden:YES];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailedaddresstext.delegate = self;
        return cell;
    }
   else
   {
       return nil;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90*HEIGHT_SCALE;
    }
    else
    {
        return 60*HEIGHT_SCALE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40*HEIGHT_SCALE;
    }
    else
    {
        return 0;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40*HEIGHT_SCALE)];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 40*HEIGHT_SCALE)];
    titlelabel.text = @"身份认证信息保存后将无法修改，请务必保证正确";
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:12];
    titlelabel.textColor = [UIColor wjColorFloat:@"008CCF"];
    [view addSubview:titlelabel];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2&&indexPath.row==0) {
        NSLog(@"学历");
        [self RecordvaluechanggeEvent];
    }
    if (indexPath.section==2&&indexPath.row==1) {
        [self addresspick];
        NSLog(@"123");
    }
    if (indexPath.section==3&&indexPath.row==1) {
        [self marriageValuechanggeEvent];
    }
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _myinfotableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIView *view = textField.superview;
    
    while (![view isKindOfClass:[UITableViewCell class]]) {
        
        view = [view superview];
    }
    
    UITableViewCell *cell = (UITableViewCell*)view;
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
    if (rect.origin.y / 2 + rect.size.height>=DEVICE_HEIGHT-276) {
        
        _myinfotableview.contentInset = UIEdgeInsetsMake(0, 0, 276, 0);
        
        [_myinfotableview scrollToRowAtIndexPath:[_myinfotableview indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    return YES;
}

-(void)keyboardHide
{
    UITextField *nametext = [self.myinfotableview viewWithTag:2];
    UITextField *idcardtext = [self.myinfotableview viewWithTag:3];
    UITextField *text4 = [self.myinfotableview viewWithTag:4];
    
    [nametext resignFirstResponder];
    [idcardtext resignFirstResponder];
    [text4 resignFirstResponder];
    _myinfotableview.contentInset = UIEdgeInsetsMake(0, 0, 276, 0);

}


#pragma mark - myinfodelegate

-(void)firstClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.myinfotableview indexPathForCell:cell];
    if (index.row==0) {
        NSLog(@"人脸识别");
        
    }
    if (index.row==1) {
        NSLog(@"身份证正面");
        [self changeIcon];
        self.typestr = @"301";
    }
}
-(void)secondClick:(UITableViewCell *)cell
{
    NSLog(@"身份证背面");
    [self changeIcon];
    self.typestr = @"302";
}

#pragma mark - 选择图片

- (void)changeIcon
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片" preferredStyle:    UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击拍照");
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //只支持访问相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 选择图片后,回调选择

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //self.pic_image.image = image;

    if ([self.typestr isEqualToString:@"300"]) {
        UIButton *button0 = [self.myinfotableview viewWithTag:300];
        [button0 setImage:image forState:normal];
        
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
            
            self.faceurlstr = inforStr2;
            if (inforStr2!=nil||inforStr2!=NULL) {
                 [NSObject wj_showHUDWithTip:@"设置成功"];
            }else
            {
                [NSObject wj_showHUDWithTip:@"请检查网络"];
            }
        } errorBlock:^(NSError *error) {
            
        }];

    }
    if ([self.typestr isEqualToString:@"301"]) {
        UIButton *button1 = [self.myinfotableview viewWithTag:301];
        [button1 setImage:image forState:normal];
        
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
            
            self.idcardpositiveurl = inforStr2;
            if (inforStr2!=nil||inforStr2!=NULL) {
                [NSObject wj_showHUDWithTip:@"设置成功"];
            }else
            {
                [NSObject wj_showHUDWithTip:@"请检查网络"];
            }
        } errorBlock:^(NSError *error) {
            
        }];
    }
    if ([self.typestr isEqualToString:@"302"]) {
        UIButton *button2 = [self.myinfotableview viewWithTag:302];
        [button2 setImage:image forState:normal];
        
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
            
            self.idcardreverseurl = inforStr2;
            if (inforStr2!=nil||inforStr2!=NULL) {
                [NSObject wj_showHUDWithTip:@"设置成功"];
            }else
            {
                [NSObject wj_showHUDWithTip:@"请检查网络"];
            }
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
}

#pragma mark - 选择器

- (void)marriageValuechanggeEvent {
    
    self.pickerView.dataSource =@[@"已婚",@"未婚"];
    self.pickerView.pickerTitle = @"婚姻状态";
    UILabel *marriage = [self.myinfotableview viewWithTag:52];
 
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        marriage.text = stateArr[0];
    };
    
    [self.pickerView show];
    
}

- (void)RecordvaluechanggeEvent {
    
    self.pickerView.dataSource = @[@"高中", @"大专", @"本科", @"硕士", @"博士", @"其他"];
    self.pickerView.pickerTitle = @"学历";
    UILabel *Recordlabel = [self.myinfotableview viewWithTag:32];
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        Recordlabel.text = stateArr[0];
    };
    [self.pickerView show];
    
}

#pragma mark - 图片转字符串

-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

#pragma mark - 保存提交

-(void)saveinfo
{
    //人脸识别照片
    NSLog(@"人脸识别照片%@",self.faceurlstr);
    
    //身份证正面
    NSLog(@"身份证正面%@",self.idcardpositiveurl);
    
    //身份证反面
    NSLog(@"身份证反面%@",self.idcardreverseurl);
    
    //姓名
    UILabel *namelabel = [self.myinfotableview viewWithTag:2];
    NSString *namestr = @"无";
    if (namelabel.text!=nil||namelabel.text!=NULL) {
        namestr = namelabel.text;
    }
    NSLog(@"namestr=====%@",namestr);
    
    //身份证号
    UILabel *cardidlabel = [self.myinfotableview viewWithTag:3];
    NSString *cardidstr = @"无";
    if (cardidlabel.text!=nil||cardidlabel.text!=NULL) {
        cardidstr = cardidlabel.text;
    }
    NSLog(@"cardidstr====%@",cardidstr);
    
    //学历
    UILabel *schoollabel = [self.myinfotableview viewWithTag:32];
    NSString *schoolstr = @"其他";
    if (schoollabel.text!=nil||schoollabel.text!=NULL) {
        schoolstr =  schoollabel.text;
    }
    NSLog(@"schoolstr====%@",schoolstr);
    
    //居住地址
 
    UITextField *address2 = [self.myinfotableview viewWithTag:4];
    NSString *addressstr = @"无";
    if (address2.text!=nil||address2.text!=NULL) {
        addressstr = address2.text;
    }
    NSLog(@"addressstr===%@",addressstr);
    
    //居住地区
    
    UILabel *address1 = [self.myinfotableview viewWithTag:42];
    NSString *area = @"无";
    if (address1.text!=nil||address1.text!=NULL) {
        area = address1.text;
    }
    NSLog(@"area=====%@",area);
    
    //婚姻状态
    UILabel *marriagelabel = [self.myinfotableview viewWithTag:52];
    NSString *marriagestr = @"未婚";
    if (marriagelabel.text!=nil||marriagelabel.text!=NULL) {
        marriagestr = marriagelabel.text;
    }
    NSLog(@"marriage=====%@",marriagestr);
    
    
    NSDictionary *dit = @{@"uid":UID,@"face":self.faceurlstr,@"Idcardpicz":self.idcardpositiveurl,@"Idcardpicf":self.idcardreverseurl,@"name":namestr,@"Idcard":cardidstr,@"schooling":schoolstr,@"area":area,@"address":addressstr,@"maritalStatus":marriagestr};
    NSLog(@"dit=========%@",dit);
    
    [AFManager postReqURL:userInfoAdd reqBody:dit block:^(id infor) {
        NSLog(@"infor-----%@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"保存成功"];
        }
        else
        {
            [NSObject wj_showHUDWithTip:@"请检查输入信息"];
        }
    }];
    
}

@end
