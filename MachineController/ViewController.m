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
    [self showMask];
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
                [self closeMask];
                int isSuccess = [responseObject[@"Error"] intValue];
                if(!isSuccess){
                   [self performSegueWithIdentifier:@"ViewtoMachineList" sender:self];
                   //[self alertString:@"登陆成功" andTitle:@"登陆"];
                }else{
                    NSString* errorMsg = responseObject[@"Message"];
                    [self alertString:errorMsg andTitle:@"登陆"];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self closeMask];
                [self alertString:@"您的网络有问题，请确认网络情况良好后重试！Login Error90" andTitle:@"登陆"];
            }];
        } else {
             [self closeMask];
             [self alertString:@"您的网络有问题，请确认网络情况良好后重试！Time Length Error " andTitle:@"登陆"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self closeMask];
        [self alertString:@"您的网络有问题，请确认网络情况良好后重试！Error Time" andTitle:@"登陆"];
    }];

}

-(void)showMask{
    self.imageView.animationDuration = 1;
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];
    [self.view addSubview:self.maskView];
}

-(void)closeMask{
    [self.imageView stopAnimating];
    [self.maskView removeFromSuperview];
}

- (IBAction)clk:(id)sender {
    [self performSegueWithIdentifier:@"ViewtoMachineList" sender:self];
    //[self showMask];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _width = 80.0f;
    _height = 80.0f;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    CGFloat x = (w -self.width) / 2.0f;
    CGFloat y = (h - self.height) / 2.0f;
    CGRect rect = CGRectMake(x, y, self.width, self.height);
    
    self.loginUrl = @"http://172.27.35.1:8080/eng/PpnRentLoginServices";
    [self.btn_submit.layer setBorderWidth:1];
    [self.btn_submit.layer setMasksToBounds:YES];
    [self.btn_submit.layer setBorderColor:[UIColor blueColor].CGColor];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"loading" ofType:@"gif"];
    _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    _imageView = [[GifImageView alloc] initWithPath: path andFrame:rect];
    [self.maskView addSubview:self.imageView];
}





@end
