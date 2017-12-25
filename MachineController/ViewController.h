//
//  ViewController.h
//  MachineControll
//
//  Created by rouies zhang on 2017/12/19.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UITextField *txt_account;
@property (weak, nonatomic) IBOutlet UITextField *txt_passwd;
@property (weak, nonatomic) IBOutlet UIButton *btn_submit;
@property (strong,nonatomic) NSString* loginUrl;


@end

