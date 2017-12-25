//
//  MachineListViewController.h
//  MachineController
//
//  Created by rouies zhang on 2017/12/21.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MachineListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *sb_contents;
@property (nonatomic,strong) NSMutableArray* macList;
@property (nonatomic,strong) NSMutableArray* winList;
@property (nonatomic,strong) NSMutableArray* filterList;
@property (weak, nonatomic) IBOutlet UINavigationItem *nativeBar;
@property (nonatomic,strong) UISearchController* searchController;
@end
