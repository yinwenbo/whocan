//
//  WHCMessageGroupViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageSessionListView.h"

@interface WHCMessageSessionListView (){
    NSMutableArray * _messageSessions;
    MessageSession * _selectedSession;
}

@end

@implementation WHCMessageSessionListView

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
    [self initRefreshControl];
    [WHCNewMessageAPI registerNotify:self callback:@selector(onReceiveMessage)];
    if(![ClientInfo isSignIn]){
        UIViewController *signInVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInVC"];
        [self presentViewController:signInVc animated:YES completion:nil];
        return;
    }
    [[WHCUploadContactsAPI getInstance:self] asynchronize];    
    _messageSessions = [NSMutableArray arrayWithArray:[MessageSession getAllSession]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [WHCAnalytics viewIn:self];
    if ([ClientInfo isSignIn]) {
        [[WHCNewMessageAPI getInstance:self] asynchronize];
    }
    [WHCNewMessageAPI registerNotify:self callback:@selector(onReceiveMessage)];
    _messageSessions = [NSMutableArray arrayWithArray:[MessageSession getAllSession]];    
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [WHCAnalytics viewOut:self];
    [WHCNewMessageAPI removeNotify:self];
}

- (void)onReceiveMessage
{
    [self initMessageSessions];
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if ([api isKindOfClass:[WHCNewMessageAPI class]]) {
        [self finishedRefresh];
    }
    
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
    [[WHCNewMessageAPI getInstance:self] asynchronize];
}

- (void)finishedRefresh
{
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self initMessageSessions];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageSessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WHCMessageSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MessageSession * session = [_messageSessions objectAtIndex:[indexPath row]];
    if ( session.unread && [session.unread intValue] > 0l) {
        cell.badgeColor = [UIColor colorWithRed:0.792 green:0.197 blue:0.219 alpha:1.000];
        cell.badge.fontSize = 12;
        cell.badgeLeftOffset = 8;
        cell.badgeRightOffset = 40;
        cell.badgeString = [session.unread stringValue];
    } else {
        cell.badgeString = nil;
    }
    
    [cell.title setText:session.title];
    [cell.detail setText:session.detail];
    [cell.icon setImage:[session getIcon]];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedSession = [_messageSessions objectAtIndex:[indexPath row]];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
//    Project *project = (Project *)[groups objectAtIndex:indexPath.row];
//    [projectView setProject:project];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MessageSession * session = [_messageSessions objectAtIndex:[indexPath row]];
        [_messageSessions removeObject:session];
        [MessageSession deleteSession:session];
        [MessageSession saveContext];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = [segue destinationViewController];
    if([viewController isKindOfClass:[WHCMessageView class]]){
        WHCMessageView *sessionView = (WHCMessageView *)viewController;
        [sessionView setMessageSession:_selectedSession];
        [[WHCMakeMessageReadAPI getInstance:self sessionId:_selectedSession.sessionId] asynchronize];
    }
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender
{
    if ([fromViewController isKindOfClass:[WHCContactPickerView class]]) {
        WHCContactPickerView *pickerView = (WHCContactPickerView *)fromViewController;
        if (pickerView.selectedContacts.count == 0) {
            return NO;
        }
        WHCAddUserToSessionAPI *sessionApi = [WHCAddUserToSessionAPI getInstance:self
                                                                       sessionId:nil
                                                                            list:pickerView.selectedContacts];
        [sessionApi synchronize];
        if ([sessionApi isSuccess]) {
            [self initMessageSessions];
            return YES;
        }
        return NO;
    }
    return YES;
}

-(void)initMessageSessions
{
    _messageSessions = [NSMutableArray arrayWithArray:[MessageSession getAllSession]];
    [self.tableView reloadData];
}


@end
