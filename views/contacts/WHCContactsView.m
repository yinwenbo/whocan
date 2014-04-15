//
//  WHCContactsTableViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactsView.h"

@interface WHCContactsView (){
    NSArray * _appContacts;
}

@end

static NSString * xx = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#!";

@implementation WHCContactsView

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
    
    if ([self hasRefesh]){
        [self initRefreshControl];
    }
    self.navigationController.delegate = self;
    [[WHCGetFriendsAPI getInstance:self] asynchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if([api isKindOfClass:[WHCGetFriendsAPI class]]){
        [self finishedRefresh];
    }
}

- (NSArray*)getAppContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getFriends];
    }
    return _appContacts;
}

- (BOOL)hasRefesh
{
    return YES;
}

- (BOOL)hasTotalCell
{
    return NO;
}

#pragma mark - Refresh Control

- (void)initRefreshControl
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    refresh.tintColor = [UIColor blueColor];
    [refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)pullToRefresh
{
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    [[WHCGetFriendsAPI getInstance:self] asynchronize];
}

- (void)finishedRefresh
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    _appContacts = nil;
    [self.tableView reloadData];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self hasTopFixCellSection]){
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasTopFixCellSection] && section == 0) {
        return [self topFixCellCount];
    }
    if ([self hasTotalCell]){
        return [[self getAppContacts] count] + 1;
    }
    return [[self getAppContacts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if ([self hasTopFixCellSection] && section == 0){
        return [self getTopFixCell:tableView cellForRowAtIndexPath:indexPath];
    }
    if ([self hasTotalCell] && [indexPath row] == [[self getAppContacts] count]) {
        return [self getTotalCell:tableView cellForRowAtIndexPath:indexPath];
    }
    return [self getContactCell:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIdentifier:indexPath]];
    return cell.bounds.size.height;
}

#pragma mark - Cell Init

- (BOOL)hasTopFixCellSection{
    return [self topFixCellCount] > 0;
}

- (NSInteger)topFixCellCount
{
    return 1;
}

- (NSString *)getCellIdentifier:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if ([self hasTopFixCellSection] && section == 0){
        return @"NewFriendCell";
    }
    if ([self hasTotalCell] && ([indexPath row] == [[self getAppContacts] count])) {
        return @"SumCell";
    }
    return @"ContactCell";
}

- (UITableViewCell *)getTopFixCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:[self getCellIdentifier:indexPath] forIndexPath:indexPath];
}

- (UITableViewCell *)getContactCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    WHCContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIdentifier:indexPath] forIndexPath:indexPath];
    AppContact *contact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    [cell setAppContact:contact];
    if (cell.button) {
        cell.button.tag = [indexPath row];
        [cell.button addTarget:self action:@selector(onCellButtionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (UITableViewCell *)getTotalCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIdentifier:indexPath] forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"通讯录共 %li 条记录", (long)[[self getAppContacts] count]];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WHCContactCell class]]){
        WHCContactShowView * view = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactShowView"];
        [view setAppContact:((WHCContactCell*)cell).appContact];
        [self.navigationController pushViewController:view animated:YES];
    }
    return indexPath;
}

#pragma mark - Section Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
    /*
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for(int i = 0; i < xx.length; i++){
        [arr addObject:[NSString stringWithFormat:@"%c", [xx characterAtIndex:i]]];
    }
    return arr;
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == 0 ){
        return nil;
    }
    return [self getSectionTitle:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [xx rangeOfString:title].location + 1;
}

- (NSString *)getSectionTitle:(NSInteger)section
{
    return [NSString stringWithFormat:@"%c",[xx characterAtIndex:(section - 1)]];
}

#pragma mark - Button Event

- (void)onCellButtionAction:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    AppContact *appContact = [[self getAppContacts] objectAtIndex:btn.tag];
    if (appContact.isAppUser) {
        [self addToFriend:appContact];
    } else {
        [self sendInvite:appContact];
    }
}

- (void)sendInvite:(AppContact*)appContact
{
    WHCSmsSendController * controller = [[WHCSmsSendController alloc]init];
    controller.recipients = [NSArray arrayWithObjects:appContact.mobileNo, nil];
    controller.body = @"我正在使用[互看]来做项目，请加入进来，以便沟通。下载：http://www.weijinrong100.com/whocan/static/download.html";
    controller.messageComposeDelegate = controller;
    [self presentViewController:controller animated:YES completion:nil];

}

- (void)addToFriend:(AppContact*)appContact;
{
    [[WHCAddFriendAPI getInstance:self userId:appContact.appId] synchronize];
    [[WHCGetFriendsAPI getInstance:self] synchronize];
}

#pragma mark - Table Edit
/*
 
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if([indexPath section] == 0){
        return NO;
    }
    return YES;
}

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

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if (viewController == self){
//        [self.tableView reloadData];
//    }
}


@end
