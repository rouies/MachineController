//
//  SearchResultTableViewController.h
//  MachineController
//
//  Created by rouies zhang on 2017/12/22.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectedRowHandler)(NSString* identity,NSString* name);

@interface SearchResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic,strong) NSArray* macList;
@property (nonatomic,strong) NSArray* winList;
@property (nonatomic,strong) NSMutableArray* filterList;
@property (nonatomic,strong) SelectedRowHandler handler;
-(instancetype)initWithList:(NSArray*)macList andWin:(NSArray*)winList;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
