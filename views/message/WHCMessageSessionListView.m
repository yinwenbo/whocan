//
//  WHCMessageGroupViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageSessionListView.h"
#import "WHCProjectViewController.h"

#import "WHCModelStore.h"

@interface WHCMessageSessionListView (){
    NSArray * _messageSessions;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self initMessageSessions];
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if ([api isKindOfClass:[WHCAllMessageSessionAPI class]]) {
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
    [[WHCAllMessageSessionAPI getInstance:self] asynchronize];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MessageSession * session = [_messageSessions objectAtIndex:[indexPath row]];
    [cell.textLabel setText:session.title];
    [cell.detailTextLabel setText:session.detail];
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = [segue destinationViewController];
    if([viewController isKindOfClass:[WHCMessageSessionView class]]){
        WHCMessageSessionView *sessionView = (WHCMessageSessionView *) viewController;
        [sessionView setMessageSession:_selectedSession];
    }
}


-(void)initMessageSessions
{
    _messageSessions = [MessageSession getAllSession];
    [self.tableView reloadData];
}


@end
