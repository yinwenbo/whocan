//
//  WHCNewFriendsController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-25.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCNewFriendsController.h"

@interface WHCNewFriendsController (){
    AppContact * _selectedContact;
}

@end

@implementation WHCNewFriendsController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)appContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getAppUsers];
    }
    return _appContacts;
}
#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appContacts count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    if(row == [self.appContacts count]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SumCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"通讯录共 %lu 条记录", [self.appContacts count]];
        return cell;
    }else{
        AppContact *appContact = (AppContact*)[self.appContacts objectAtIndex:[indexPath row]];
        WHCAddressBookCell *cell = nil;
        NSString * name = appContact.appName;
        if (name == nil){
            name = appContact.phoneABName;
        }
        if (name == nil){
            name = appContact.mobileNo;
        }
        if(appContact.isMyFriend){
            cell = (WHCAddressBookCell *)[tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
            [cell setCellText:name actionText:@"已添加"];
        } else if(appContact.isInviteMe){
            cell = (WHCAddressBookCell *)[tableView dequeueReusableCellWithIdentifier:@"InviteMeCell" forIndexPath:indexPath];
            [cell setCellText:name actionText:@"同意"];
        } else {
            cell = (WHCAddressBookCell *)[tableView dequeueReusableCellWithIdentifier:@"MyInviteCell" forIndexPath:indexPath];
            cell.mobileNo = appContact.mobileNo;
            [cell setCellText:name actionText:@"邀请"];
            [WHCViewUtils setButton:cell.actionButton];
        }
        return cell;
    }
}


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
