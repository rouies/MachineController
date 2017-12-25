//
//  SearchResultTableViewController.m
//  MachineController
//
//  Created by rouies zhang on 2017/12/22.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import "SearchResultTableViewController.h"

@interface SearchResultTableViewController ()

@end

@implementation SearchResultTableViewController

-(instancetype)initWithList:(NSArray*)macList andWin:(NSArray*)winList{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self != nil){
        self.macList = macList;
        self.winList = winList;
        self.filterList = [[NSMutableArray alloc] initWithCapacity:(self.macList.count + self.winList.count)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.filterList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identity = @"Standard";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    
    if([self.filterList[indexPath.row][@"type"] isEqualToString:@"0"]){
        UIImage* image = [UIImage imageNamed:@"mac_item"];
        cell.imageView.image = image;
    } else {
        UIImage* image = [UIImage imageNamed:@"win_item"];
        cell.imageView.image = image;
    }
    [cell.textLabel setText:self.filterList[indexPath.row][@"obj_name"]];
    [cell.detailTextLabel setText:self.filterList[indexPath.row][@"desc"]];
    
    return cell;
}



- (void)updateSearchResultsForSearchController:(UISearchController *)controller{
    NSString* searchText = [controller.searchBar text];
    NSInteger index = controller.searchBar.selectedScopeButtonIndex;
    [self.filterList removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K CONTAINS[c] %@) OR (%K CONTAINS[c] %@)",@"obj_name",searchText,@"desc",searchText];
    if(index == 0 || index == 1){
        [self.filterList addObjectsFromArray:([NSMutableArray arrayWithArray:[self.macList filteredArrayUsingPredicate:predicate]])];
    }
    if(index == 0 || index == 2){
        [self.filterList addObjectsFromArray:([NSMutableArray arrayWithArray:[self.winList filteredArrayUsingPredicate:predicate]])];
    }
    [self.tableView reloadData];
}

@end
