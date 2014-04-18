//
//  WHCMessageViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageView.h"

@interface WHCMessageView () {
    MessageSession * _session;
    AppContact * _friend;
    NSMutableArray * _messages;
}

@end

@implementation WHCMessageView

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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([_messages count] > 1) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [_tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [WHCAnalytics viewIn:self];
    [WHCNewMessageAPI registerNotify:self callback:@selector(onMessageReceive)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [WHCAnalytics viewOut:self];
    [WHCNewMessageAPI removeNotify:self];
}

- (void)onMessageReceive
{
    NSArray *messages = [MessageSession getMessages:_session.sessionId];
    
    for ( NSInteger i = [_messages count]; i < [messages count]; i++) {
        [_messages addObject:[messages objectAtIndex:i]];
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }

    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]
                    atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (void)setMessageSession:(MessageSession *)session
{
    _session = session;
    [self refreshTableView];
}

- (void)setAppContact:(AppContact *)appContact
{
    _friend = appContact;
    [self setMessageSession:[MessageSession getSession:appContact.appId]];
}

- (void)refreshTableView
{
    NSArray *messages = nil;
    if (_session) {
        messages = [MessageSession getMessages:_session.sessionId];
    }
    if (messages) {
        _messages = [NSMutableArray arrayWithArray:messages];
    } else {
        _messages = [NSMutableArray array];
    }
    [_tableView reloadData];
}


- (void)onJsonParseFinished:(WHCJsonAPI *)api
{

}

- (IBAction)sendMessage:(id)sender
{
    NSString * content = _inputText.text;
    if (content.length == 0) {
        return;
    }
    if (_session == nil) {
        _session = [MessageSession createSession];
        _session.sessionId = _friend.appId;
        _session.title = _friend.appName;
        _session.detail = content;
        [MessageSession saveContext];
    }
    
    WHCSendMessageAPI *sendMessage = [WHCSendMessageAPI getInstance:self
                                                          sessionId:_session.sessionId
                                                            content:content];
    [_messages addObject:sendMessage.message];
    [sendMessage asynchronize];
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]]
                      withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0]
                  atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    _inputText.text = @"";
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *view = [segue destinationViewController];
    if ([view isKindOfClass:[WHCProjectTaskListView class]]) {
        [((WHCProjectTaskListView *)view) setProjectId:_session.sessionId];
    }
}

#pragma mark - tableview 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_messages) {
        return [_messages count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * message = [_messages objectAtIndex:[indexPath row]];
    WHCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIndentifierWithMessage:message]
                                                           forIndexPath:indexPath];
    if ([message isSystemMessage]){
        [cell setContent:message.content icon:nil];
    } else {
        AppContact *sender = [self findSender:message];
        [cell setContent:message.content icon:[sender getIcon]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * message = [_messages objectAtIndex:[indexPath row]];

    WHCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getCellIndentifierWithMessage:message]];
    return [cell getCellHeight:message.content];

}

- (NSString *)getCellIndentifierWithMessage:(Message *)message
{
    if ([message isSystemMessage]) {
        return @"SystemMessageCell";
    }
    if ([message isMySend]) {
        return @"SenderCell";
    }
    return @"ReceiverCell";
}

- (AppContact *)findSender:(Message *)message
{
    if ([message isMySend]){
        return [AppContact findMySelf];
    }
    return [AppContact findAppContactByAppId:message.senderId];
}
@end
