//
//  DetailViewController.h
//  MachineController
//
//  Created by rouies zhang on 2017/12/22.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* identity;
@property (weak, nonatomic) IBOutlet UINavigationItem *nav_item;

@end
