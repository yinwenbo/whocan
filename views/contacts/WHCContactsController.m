//
//  WHCContactsTableViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactsController.h"

@interface WHCContactsController (){
    NSArray * _appContacts;
    AppContact * _selectedContact;
    UINavigationController * _messageNC;
}

@end

static NSString * xx = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#!";

@implementation WHCContactsController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initRefreshControl];
    self.navigationController.delegate = self;
    [[WHCGetFriendsAPI getInstance:self] asynchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self){
        [self.tableView reloadData];
    }
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if([api isKindOfClass:[WHCGetFriendsAPI class]]){
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        _appContacts = nil;
        [self.tableView reloadData];
    }
}

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


- (NSArray*)getAppContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getFriends];
    }
    return _appContacts;
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for(int i = 0; i < xx.length; i++){
        [arr addObject:[NSString stringWithFormat:@"%c", [xx characterAtIndex:i]]];
    }
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    return [[self getAppContacts] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if (section == 0){
        return [tableView dequeueReusableCellWithIdentifier:@"NewFriendCell" forIndexPath:indexPath];
    }
    return [self getContactCell:tableView cellForRowAtIndexPath:indexPath];
}

- (UITableViewCell*)getContactCell:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if([indexPath row] == [[self getAppContacts] count]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SumCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"通讯录共 %lu 条记录", [[self getAppContacts] count]];
        return cell;
    }
    WHCContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    AppContact *contact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    cell.appContact = contact;
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    return cell;
}
*/

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WHCContactCell class]]){
        _selectedContact = ((WHCContactCell*)cell).appContact;
    }
    return indexPath;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == 0 ){
        return nil;
    }
    return [self getSectionTitle:section];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [xx rangeOfString:title].location + 1;
}

-(NSString *)getSectionTitle:(NSInteger)section
{
    return [NSString stringWithFormat:@"%c",[xx characterAtIndex:(section - 1)]];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if([indexPath section] == 0){
        return NO;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AppContact *appContact = [[self getAppContacts] objectAtIndex:[indexPath row]];
    if (appContact.isMyFriend) {
        [self sendMessage:appContact];
    } else if (appContact.isAppUser) {
        [self addToFriend:appContact];
    } else {
        [self sendInvite:appContact];
    }
}

- (void)sendMessage:(AppContact*)appContact
{
    WHCMessageSessionView * view = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageSession"];
    [view setAppContact:appContact];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)sendInvite:(AppContact*)appContact
{
    WHCSmsSendController * smsView = [WHCViewUtils getInviteSMSView:appContact.mobileNo];
    [self presentViewController:smsView animated:YES completion:nil];
}

- (void)addToFriend:(AppContact*)appContact;
{
    //    UIButton *btn = (UIButton*)sender;
    //    [btn titleLabel].text = @"等待批准";
    //    [btn setEnabled:NO];
    [[WHCAddFriendAPI getInstance:self userId:appContact.appId] asynchronize];
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController * vc = [segue destinationViewController];
    if ([vc isKindOfClass:[WHCContactViewController class]]) {
        WHCContactViewController * contactVC = (WHCContactViewController*)vc;
        contactVC.appContact = _selectedContact;
    }
}


@end
