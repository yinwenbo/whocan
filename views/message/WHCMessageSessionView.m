//
//  WHCMessageViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageSessionView.h"
#import "WHCTextMessageCell.h"
#import "WHCSystemMessageCell.h"

@interface WHCMessageSessionView () {
    MessageSession * _session;
    NSMutableArray * _messages;
    NSTimer * _timer;
}

@end

@implementation WHCMessageSessionView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView registerClass:[WHCTextMessageCell class] forCellReuseIdentifier:@"TextMessageCell"];
    [_tableView registerClass:[WHCSystemMessageCell class] forCellReuseIdentifier:@"SystemMessageCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self loadMessages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)loadMessages
{
    [[WHCGetMessagesAPI getInstance:self sessionId:_session.sessionId] asynchronize];
}

- (void)setMessageSession:(MessageSession *)session
{
    _session = session;
    [self refreshTableView];
}

- (void)refreshTableView
{
    NSArray *messages = [MessageSession getMessages:_session.sessionId];
    if (messages) {
        _messages = [NSMutableArray arrayWithArray:messages];
    } else {
        _messages = [NSMutableArray array];
    }
    [_tableView reloadData];
}

- (void)setAppContact:(AppContact *)appContact
{
    MessageSession *session = nil;
    if (appContact.messageSessionId == nil){
        WHCGetMessageSessionAPI * sessionApi =[WHCGetMessageSessionAPI getInstance:self
                                                                          toUserId:appContact.appId];
        [sessionApi synchronize];
        appContact.messageSessionId = sessionApi.sessionId;
        [AppContact saveContext];
    }
    
    session = [MessageSession getSession:appContact.messageSessionId];
    if (session == nil) {
        
    }
    
    [self setMessageSession:session];
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if ([api isKindOfClass:[WHCGetMessagesAPI class]]) {
        [self refreshTableView];
        [self beginReloadTimer];
    }
}

- (void)onRequestIsFailed:(WHCHttpAPI *)api
{
}

- (void)beginReloadTimer
{
    if (_timer) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:10
                                              target:self
                                            selector:@selector(loadMessages)
                                            userInfo:nil
                                             repeats:NO];
    
}

- (IBAction)sendMessage:(id)sender
{
    WHCSendMessageAPI *sendMessage = [WHCSendMessageAPI getInstance:self
                                                          sessionId:_session.sessionId
                                                            content:_inputText.text];
    [_messages addObject:sendMessage.message];
    [sendMessage asynchronize];
    
    [_tableView reloadData];
    _inputText.text = @"";
//    [_tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *view = [segue destinationViewController];
    if ([view isKindOfClass:[WHCProjectTaskListView class]]) {
        [((WHCProjectTaskListView *)view) setProjectId:_session.sessionId];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messages count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * message = [_messages objectAtIndex:[indexPath row]];
    if ([message isSystemMessage]) {
        WHCSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemMessageCell" forIndexPath:indexPath];
        cell.textLabel.text = message.content;
        return cell;
    }
    WHCTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextMessageCell" forIndexPath:indexPath];
    
    AppContact *sender = [self findSender:message];
    UIImage *icon;
    if (sender.icon) {
        icon = [UIImage imageNamed:sender.icon];
    } else {
        icon = [UIImage imageNamed:@"icon_monsterinc_256"];
    }
    if ([message isMySend]) {
        [cell sendTextMessage:icon content:message.content];
    } else {
        [cell receiveTextMessage:icon content:message.content];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * message = [_messages objectAtIndex:[indexPath row]];
    if ([message isSystemMessage]) {
        return [WHCSystemMessageCell getCellHeight:message.content];
    } else {
        return [WHCTextMessageCell getCellHeight:message.content];
    }
}

- (AppContact *)findSender:(Message *)message
{
    if ([message isMySend]){
        return [AppContact findMySelf];
    }
    return [AppContact findAppContactByAppId:message.senderId];
}
@end
