//
//  WHCSyncTask.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-21.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCSyncTask.h"

@interface WHCSyncTask(){
    NSTimer * _timer;
    SEL _currentExcute;
}

@end

@implementation WHCSyncTask

static WHCSyncTask * __syncTask;

+ (void)start
{
    if (__syncTask) {
        [__syncTask stop];
    }
    __syncTask = [[WHCSyncTask alloc] init];
    [__syncTask start];
}

+ (void)stop
{
    [__syncTask stop];
}

- (void)start
{
    [self runTimer:10 selector:@selector(syncMessage)];
}

- (void)stop
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)runTimer:(NSTimeInterval)interval selector:(SEL)selector
{
    [self stop];
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:selector userInfo:nil repeats:NO];
    _currentExcute = selector;
}

- (void)syncMessage
{
    [[WHCNewMessageAPI getInstance:self] asynchronize];
}

- (void)syncFriends
{
    [[WHCGetFriendsAPI getInstance:self] asynchronize];
}

- (void)onJsonParseFinished:(WHCJsonAPI *)api
{
    if ([api isKindOfClass:[WHCNewMessageAPI class]]) {
        [self nextSync:api next:@selector(syncFriends)];
    } else if ([api isKindOfClass:[WHCGetFriendsAPI class]]) {
        [self nextSync:api next:@selector(syncMessage)];
    }
}

- (void)nextSync:(WHCJsonAPI *)api next:(SEL)next
{
    if ([api hasError]) {
        [self runTimer:10 selector:_currentExcute];
    } else {
        [self runTimer:5 selector:next];
    }
}

@end
