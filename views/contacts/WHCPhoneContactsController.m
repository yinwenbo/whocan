//
//  WHCContactsViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-6.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCPhoneContactsController.h"
#import "WHCPhoneABTableViewCell.h"

@interface WHCPhoneContactsController () {
    ABPersonViewController* persionView;
}

@end

@implementation WHCPhoneContactsController

@synthesize barBtnRight, appContacts = _appContacts;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)appContacts
{
    if(_appContacts == nil){
        _appContacts = [AppContact getAppContacts];
    }
    return _appContacts;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appContacts count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = nil;
    NSString *actionText = nil;
    if([indexPath row] == [self.appContacts count]) {
        CellIdentifier = @"SumCell";
    }else if([indexPath row] <= 10){
        CellIdentifier = @"AddCell";
        actionText = @"添加";
    } else if([indexPath row] <= 20){
        CellIdentifier = @"InviteCell";
        actionText = @"邀请";
    } else {
        CellIdentifier = @"FriendCell";
        actionText = @"已添加";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if( [cell isKindOfClass:[WHCPhoneABTableViewCell class]]){
        WHCPhoneABTableViewCell *viewCell = (WHCPhoneABTableViewCell *)cell;
        AppContact *appContact = (AppContact*)[self.appContacts objectAtIndex:[indexPath row]];
        [viewCell setCellText:appContact.phoneABName actionText:actionText];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"通讯录共 %lu 条记录", [self.appContacts count]];
    }
    
//    cell.textLabel.text = ab.name;

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.titleLabel.text = @"邀请";
//    [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//    cell.accessoryView = button;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    [self showABPersonView:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
-(void)showABPersonView:(NSInteger)index
{
    ABPersonViewController *pvc = [[ABPersonViewController alloc] init];
    //	pvc.navigationItem.leftBarButtonItem = BARBUTTON(@"取消", @selector(cancelBtnAction:));
	
    ABRecordRef person = (ABRecordRef)CFBridgingRetain([phoneContacts objectAtIndex:index]);
    pvc.displayedPerson = person;
	pvc.allowsEditing = YES;
    pvc.allowsActions = YES;
    
    pvc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil)
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(returnFromPersonView)];
    
    persionView = pvc;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self presentViewController:nav animated:YES completion:nil];

}
 */
- (void)returnFromPersonView
{
    [persionView dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addToFriend:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [btn titleLabel].text = @"等待批准";
    [btn setEnabled:NO];
}

@end
