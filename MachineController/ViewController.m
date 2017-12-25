//
//  ViewController.m
//  MachineControll
//
//  Created by rouies zhang on 2017/12/19.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonCrypto.h>
#import "MachineListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)alertString:(NSString*)message andTitle:(NSString*)title{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(NSString*)stringByMd5:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr);
    CC_MD5(cStr, x, digest);
    // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

- (IBAction)onDidEnd:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)onTouchDown:(id)sender {
    [self.txt_account resignFirstResponder];
    [self.txt_passwd resignFirstResponder];
}
- (IBAction)onSubmitLogin:(id)sender {
    NSString* acc = [[self.txt_account text]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* pw = [[self.txt_passwd text]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([acc isEqualToString:@""] || acc.length > 22){
        [self alertString:@"用户名不能为空且必须小于23个字符" andTitle:@"非法的用户名"];
        return;
    }
    if([pw isEqualToString:@""] || pw.length > 22){
        [self alertString:@"密码不能为空且必须小于23个字符" andTitle:@"非法的密码"];
        return;
    }
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"text/html",nil]];
    [manager GET:self.loginUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* serverTime = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if(serverTime.length == 17){
            AFHTTPSessionManager* postManager = [AFHTTPSessionManager manager];
            postManager.requestSerializer = [AFJSONRequestSerializer serializer];
            postManager.responseSerializer = [AFJSONResponseSerializer serializer];
            NSString* account = [self.txt_account text];
            NSString* passwd  = [self.txt_passwd text];
            NSString* md5Passwd     = [self stringByMd5:passwd];
            NSMutableString* str = [[NSMutableString alloc] initWithString:md5Passwd];
            NSString* mTime = [serverTime substringToIndex:12];
            [str appendString:mTime];
            NSString* pwd = [self stringByMd5:str];
            NSDictionary* pars = @{@"account":account,@"password":pwd};
            [postManager POST:self.loginUrl parameters:pars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                int isSuccess = [responseObject[@"Error"] intValue];
                if(!isSuccess){
                    [self performSegueWithIdentifier:@"ViewtoMachineList" sender:self];
                   [self alertString:@"登陆成功" andTitle:@"登陆"];
                }else{
                    NSString* errorMsg = responseObject[@"Message"];
                    [self alertString:errorMsg andTitle:@"登陆"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self alertString:@"您的网络有问题，请确认网络情况良好后重试！" andTitle:@"登陆"];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alertString:@"您的网络有问题，请确认网络情况良好后重试！" andTitle:@"登陆"];
    }];

}
- (IBAction)clk:(id)sender {
    //[self performSegueWithIdentifier:@"ViewtoMachineList" sender:self];
//    UIView* maskView = [[UIView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 200.0f, 200.0f)];
    UIView* maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    maskView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    /*
    UIImageView* loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    loadImageView.image = [UIImage imageNamed:@"win_item"];
    loadImageView.layer.masksToBounds = YES;
    loadImageView.layer.cornerRadius = 10;
    [maskView addSubview:loadImageView];
     */
    /*
    UIWebView* imageView = [[UIWebView alloc]initWithFrame:CGRectMake(200, 200, 200, 200)];
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"loading" withExtension:@"gif"];
    [imageView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [maskView addSubview:imageView];
     
    [self.view addSubview:maskView];
    */
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
    //1.找到gif文件路径
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"loading" ofType:@"gif"];
    //2.获取gif文件数据
    CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:dataPath], NULL);
    //3.获取gif文件中图片的个数
    size_t count = CGImageSourceGetCount(source);
    //4.定义一个变量记录gif播放一轮的时间
    //5.定义一个可变数组存放所有图片
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (size_t i=0; i<count; i++) {
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        UIImage* itemImg = [UIImage imageWithCGImage:image];
        [imageArray addObject:itemImg];
        CGImageRelease(image);
        //获取图片信息
        //NSDictionary *info = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
        //NSLog(@"info---%@",info);
    }
    imageView.animationImages = imageArray; //获取Gif图片列表
    imageView.animationDuration = 5;     //执行一次完整动画所需的时长
    imageView.animationRepeatCount = 0;  //动画重复次数
    [imageView startAnimating];
    
    [maskView addSubview:imageView];
    [self.view addSubview:maskView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginUrl = @"http://172.27.35.1:8080/eng/PpnRentLoginServices";
    [self.btn_submit.layer setBorderWidth:1];
    [self.btn_submit.layer setMasksToBounds:YES];
    [self.btn_submit.layer setBorderColor:[UIColor blueColor].CGColor];
}





@end
