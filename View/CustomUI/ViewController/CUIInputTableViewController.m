//
//  CUIInputTableViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-5-7.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "CUIInputTableViewController.h"

@interface CUIInputTableViewController () {
    CGRect _tabBarFrame;
    CGRect _navBarFrame;
    CGRect _tableViewFrame;
    CGPoint _lastScrollLocation;
    BOOL _barIsHide;
}

@end

@implementation CUIInputTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tabBarFrame = self.tabBarController.tabBar.frame;
    _navBarFrame = self.navigationController.navigationBar.frame;
    _tableViewFrame = self.tableView.frame;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"offset %@", NSStringFromCGPoint(scrollView.contentOffset));
    if ([scrollView isDecelerating]) {
        return;
    }
//    [self hideBars];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastScrollLocation = [scrollView contentOffset];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"content size %@", NSStringFromCGSize(scrollView.contentSize));
    CGPoint contentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    NSLog(@"last offset %@ offset %@ decelerate %hhd",
          NSStringFromCGPoint(_lastScrollLocation),
          NSStringFromCGPoint(contentOffset),
          decelerate);
    if (_lastScrollLocation.y < contentOffset.y
        && contentSize.height > _tabBarFrame.origin.y + _tabBarFrame.size.height) {
        [self hideBars];
    } else {
        [self showBars];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [self showBars];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}

- (void)showBars
{
    if (!_barIsHide) {
        return;
    }
    [UIView animateWithDuration:0.3f
                     animations:^(){
                         [self.tabBarController.tabBar setFrame:_tabBarFrame];
                         [self.navigationController.navigationBar setFrame:_navBarFrame];
                         [self.tableView setFrame:_tableViewFrame];
                     }
                     completion:^(BOOL finished) {
                         _barIsHide = NO;
                     }];
}

- (void)hideBars
{
    if (_barIsHide) {
        return;
    }

    CGRect tabBarHideFarme = CGRectMake(_tabBarFrame.origin.x,
                                        _tabBarFrame.origin.y + _tabBarFrame.size.height,
                                        _tabBarFrame.size.width,
                                        _tabBarFrame.size.height);
    CGRect navBarHideFarme = CGRectMake(_navBarFrame.origin.x,
                                        -_navBarFrame.size.height,
                                        _navBarFrame.size.width,
                                        _navBarFrame.size.height);
    CGRect tableFrame = CGRectMake(_tableViewFrame.origin.x,
                                   _tableViewFrame.origin.y - navBarHideFarme.origin.y - navBarHideFarme.size.height,
                                   _tableViewFrame.size.width,
                                   _tableViewFrame.size.height + _tabBarFrame.size.height);
    
    [UIView animateWithDuration:0.3f
                     animations:^(){
                         [self.tabBarController.tabBar setFrame:tabBarHideFarme];
                         [self.navigationController.navigationBar setFrame:navBarHideFarme];
                         [self.tableView setFrame:tableFrame];
                     }
                     completion:^(BOOL finished) {
                         _barIsHide = YES;
                     }];
    
    
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return 40;
}
 */
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self showBars];
}


@end
