//
//  MachineListViewController.m
//  MachineController
//
//  Created by rouies zhang on 2017/12/21.
//  Copyright © 2017年 rouies zhang. All rights reserved.
//

#import "MachineListViewController.h"
#import "SearchResultTableViewController.h"
#import "DetailViewController.h"

@interface MachineListViewController ()

@end

@implementation MachineListViewController{
    NSString* identity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    identity = @"StandardCell";
    [self refurbish];
    SearchResultTableViewController* resultSearchController = [[SearchResultTableViewController alloc] initWithList:self.macList andWin:self.winList];
    resultSearchController.handler = ^(NSString* identity,NSString* name){
        [self performSegueWithIdentifier:@"SegueDetail" sender:self];
        [self.searchController setActive:NO];
    };
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:resultSearchController];
    UISearchBar* searchBar = self.searchController.searchBar;
    searchBar.placeholder = @"请输入您要查询的设备信息";
    searchBar.scopeButtonTitles = @[@"All",@"MacPro",@"Windows"];
    self.tableView.tableHeaderView = searchBar;
    self.searchController.searchResultsUpdater = resultSearchController;
    self.definesPresentationContext = YES;
    self.searchController.hidesNavigationBarDuringPresentation =YES;
    [searchBar sizeToFit];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //UINib* tvc = [UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
    //[self.tbl_contents registerNib:tvc forCellReuseIdentifier:identity];
}

-(void)refurbish{
    self.macList = [[NSMutableArray alloc] initWithArray:
                    @[@{@"id":@"8C-85-90-0F-4F-E0",@"obj_name":@"MAC01",@"type":@"0",@"desc":@"祖菊红 看见（香港）"},
                      @{@"id":@"8C-85-90-0F-4F-E1",@"obj_name":@"MAC02",@"type":@"0",@"desc":@"吕一夫 走遍中国"},
                      @{@"id":@"8C-85-90-0F-4F-E2",@"obj_name":@"MAC03",@"type":@"0",@"desc":@"崔博涵 寻找马克思"},
                      @{@"id":@"8C-85-90-0F-4F-E0",@"obj_name":@"MAC04",@"type":@"0",@"desc":@"祖菊红 看见（香港）"},
                      @{@"id":@"8C-85-90-0F-4F-E1",@"obj_name":@"MAC05",@"type":@"0",@"desc":@"吕一夫 走遍中国"},
                      @{@"id":@"8C-85-90-0F-4F-E2",@"obj_name":@"MAC06",@"type":@"0",@"desc":@"崔博涵 寻找马克思"},
                      @{@"id":@"8C-85-90-0F-4F-E3",@"obj_name":@"MAC07",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E4",@"obj_name":@"MAC08",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E5",@"obj_name":@"MAC09",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E6",@"obj_name":@"MAC10",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E3",@"obj_name":@"MAC11",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E4",@"obj_name":@"MAC12",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E5",@"obj_name":@"MAC13",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E6",@"obj_name":@"MAC14",@"type":@"0",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E7",@"obj_name":@"MAC15",@"type":@"0",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E8",@"obj_name":@"MAC16",@"type":@"0",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E7",@"obj_name":@"MAC17",@"type":@"0",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E8",@"obj_name":@"MAC18",@"type":@"0",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-EA",@"obj_name":@"MAC19",@"type":@"0",@"desc":@"保养"},
                      @{@"id":@"8C-85-90-0F-4F-EA",@"obj_name":@"MAC20",@"type":@"0",@"desc":@"保养"}]];
    self.winList = [[NSMutableArray alloc] initWithArray:
                    @[@{@"id":@"8C-85-90-0F-4F-E0",@"obj_name":@"WIN01",@"type":@"1",@"desc":@"李白 梦回大唐"},
                      @{@"id":@"8C-85-90-0F-4F-E1",@"obj_name":@"WIN02",@"type":@"1",@"desc":@"杜甫 喷遍大唐"},
                      @{@"id":@"8C-85-90-0F-4F-E2",@"obj_name":@"WIN03",@"type":@"1",@"desc":@"王羲之 梦想兰亭"},
                      @{@"id":@"8C-85-90-0F-4F-E0",@"obj_name":@"WIN04",@"type":@"1",@"desc":@"李白 梦回大唐"},
                      @{@"id":@"8C-85-90-0F-4F-E1",@"obj_name":@"WIN05",@"type":@"1",@"desc":@"杜甫 喷遍大唐"},
                      @{@"id":@"8C-85-90-0F-4F-E2",@"obj_name":@"WIN06",@"type":@"1",@"desc":@"王羲之 梦想兰亭"},
                      @{@"id":@"8C-85-90-0F-4F-E3",@"obj_name":@"WIN07",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E4",@"obj_name":@"WIN08",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E5",@"obj_name":@"WIN09",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E6",@"obj_name":@"WIN10",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E3",@"obj_name":@"WIN11",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E4",@"obj_name":@"WIN12",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E5",@"obj_name":@"WIN13",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E6",@"obj_name":@"WIN14",@"type":@"1",@"desc":@"在库"},
                      @{@"id":@"8C-85-90-0F-4F-E7",@"obj_name":@"WIN15",@"type":@"1",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E8",@"obj_name":@"WIN16",@"type":@"1",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E7",@"obj_name":@"WIN17",@"type":@"1",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-E8",@"obj_name":@"WIN18",@"type":@"1",@"desc":@"维修"},
                      @{@"id":@"8C-85-90-0F-4F-EA",@"obj_name":@"WIN19",@"type":@"1",@"desc":@"保养"},
                      @{@"id":@"8C-85-90-0F-4F-EA",@"obj_name":@"WIN20",@"type":@"1",@"desc":@"保养"}]];
    //self.filterList = [[NSMutableArray alloc]initWithCapacity:([self.macList count] + [self.winList count])];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    UILabel *label;
    
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 200, 20)];
        label.font = [UIFont systemFontOfSize:18];
        [headerView addSubview:label];
    }
    
    if (section == 0) {
        label.text = @"Mac移动非编";
    }else {
        label.text = @"天鹰移动非编";
    }
    
    return headerView;
   
}
 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.macList count];
    } else if(section == 1){
        return [self.winList count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    if(indexPath.section == 0){
        UIImage* image = [UIImage imageNamed:@"mac_item"];
        cell.imageView.image = image;
        [cell.textLabel setText:self.macList[indexPath.row][@"obj_name"]];
        [cell.detailTextLabel setText:self.macList[indexPath.row][@"desc"]];
    } else if(indexPath.section == 1){
        UIImage* image = [UIImage imageNamed:@"win_item"];
        cell.imageView.image = image;
        [cell.textLabel setText:self.winList[indexPath.row][@"obj_name"]];
        [cell.detailTextLabel setText:self.winList[indexPath.row][@"desc"]];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SegueDetail"]){
        DetailViewController* dc = (DetailViewController*)segue.destinationViewController;
        NSIndexPath* index =  [self.tableView indexPathForSelectedRow];
        if(index.section == 0){
            dc.name = self.macList[index.row][@"obj_name"];
            dc.identity = self.macList[index.row][@"id"];
        } else if(index.section == 1){
            dc.name = self.winList[index.row][@"obj_name"];
            dc.identity = self.winList[index.row][@"id"];
        }
    }
}
@end
