//
//  WHCContactViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-20.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCContactViewController.h"

@interface WHCContactViewController ()

@end

@implementation WHCContactViewController

@synthesize appContact, btnMainAction, lblName, lblId, lblMobileNo, lblNickname;

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
    if (self.appContact.isMyFriend) {
        btnMainAction.titleLabel.text = @"发送消息";
    } else if (self.appContact.isAppUser) {
        btnMainAction.titleLabel.text = @"加为好友";
    } else {
        btnMainAction.titleLabel.text = @"发送邀请";
    }
    lblName.text = self.appContact.phoneABName;
    if (self.appContact.appId == nil) {
        lblId.text = @"";
    }else{
        lblId.text = [NSString stringWithFormat:@"互看id: %@", self.appContact.appId];
    }
    lblMobileNo.text = self.appContact.mobileNo;
    if (self.appContact.appName == nil){
        lblNickname.text = @"";
    }else{
        lblNickname.text = [NSString stringWithFormat:@"昵称: %@", self.appContact.appName];
    }
    [WHCViewUtils setButton:btnMainAction];
    [self.tableView setSectionHeaderHeight:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch ([indexPath row]) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
            break;
        case 2:
            if (self.appContact.isAppFriend) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SendMessage" forIndexPath:indexPath];
            } else if (self.appContact.isAppUser) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"AddFriend" forIndexPath:indexPath];
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SendInvite" forIndexPath:indexPath];
            }
            break;
        default:
            return nil;
    }

    return cell;
    
    // Configure the cell...
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMainAction:(id)sender
{
    if (self.appContact.isMyFriend) {
//        btnMainAction.titleLabel.text = @"发送消息";
    } else if (self.appContact.isAppUser) {
//        btnMainAction.titleLabel.text = @"加为好友";
    } else {
        WHCSmsSendController * smsView = [WHCViewUtils getInviteSMSView:self.appContact.mobileNo];
        [self presentViewController:smsView animated:YES completion:nil];

    }

}
@end
