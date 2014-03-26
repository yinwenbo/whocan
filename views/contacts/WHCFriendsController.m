//
//  WHCContactsTableViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCFriendsController.h"

@interface WHCFriendsController (){
    AppContact * _selectedContact;
}

@end

static NSString * xx = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#!";

@implementation WHCFriendsController

@synthesize appContacts = _appContacts;

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
        _appContacts = nil;
        [self.tableView reloadData];
    }
}

- (NSArray*)appContacts
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
    return [self.appContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if (section == 0){
        return [tableView dequeueReusableCellWithIdentifier:@"NewFriendCell" forIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    AppContact *contact = [self.appContacts objectAtIndex:[indexPath row]];
    if (contact.phoneABName == nil) {
        [cell textLabel].text = contact.appName;
    } else if (![contact.phoneABName isEqualToString:contact.appName]) {
        [cell textLabel].text = [NSString stringWithFormat:@"%@(%@)", contact.appName, contact.phoneABName];
    } else {
        [cell textLabel].text = contact.appName;
    }
    [cell detailTextLabel].text = @"";
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

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _selectedContact = [self.appContacts objectAtIndex:[indexPath row]];
    return indexPath;
}


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
