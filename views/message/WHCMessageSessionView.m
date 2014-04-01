//
//  WHCMessageViewController.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-27.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCMessageSessionView.h"

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
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardChangeFrame:)
                                                name:UIKeyboardWillChangeFrameNotification object:nil];
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
                                                            content:inputText.text];
    [_messages addObject:sendMessage.message];
    [sendMessage synchronize];
    
    [_tableView reloadData];
    inputText.text = @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ----键盘高度变化------
-(void)onKeyboardChangeFrame:(NSNotification *)aNotifacation
{
    //获取到键盘frame 变化之前的frame
    NSValue *keyboardBeginBounds=[[aNotifacation userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyboardBeginBounds CGRectValue];
    
    //获取到键盘frame变化之后的frame
    NSValue *keyboardEndBounds=[[aNotifacation userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endRect=[keyboardEndBounds CGRectValue];
    
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    //拿frame变化之后的origin.y-变化之前的origin.y，其差值(带正负号)就是我们self.view的y方向上的增量
    
    NSLog(@"deltaY:%f",deltaY);
    [CATransaction begin];
    [UIView animateWithDuration:0.4f
                     animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
        [_tableView setContentInset:UIEdgeInsetsMake(_tableView.contentInset.top-deltaY, 0, 0, 0)];
        
    }
                     completion:^(BOOL finished) {
        
    }];
    [CATransaction commit];
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
    WHCMessageCell *cell = (WHCMessageCell*)[tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    Message * message = [_messages objectAtIndex:[indexPath row]];
    cell.message = message.content;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message * message = [_messages objectAtIndex:[indexPath row]];
    return [WHCMessageCell getCellHeight:message.content];
}

@end
