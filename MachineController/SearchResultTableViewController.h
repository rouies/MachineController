//
//  SearchResultTableViewController.h
//  MachineController
//
//  Created by rouies zhang on 2017/12/22.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic,strong) NSArray* macList;
@property (nonatomic,strong) NSArray* winList;
@property (nonatomic,strong) NSMutableArray* filterList;
-(instancetype)initWithList:(NSArray*)macList andWin:(NSArray*)winList;
@end
