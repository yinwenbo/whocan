//
//  WHCTaskCreateAPI.h
//  whocan
//
//  Created by Yin Wenbo on 14-4-29.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCJsonAPI.h"

@interface WHCTaskCreateAPI : WHCJsonAPI

+ (WHCTaskCreateAPI*) getInstance:(id<WHCJsonAPIDelegate>)delegate
                            title:(NSString *)title
                          groupId:(NSString *)groupId
                      description:(NSString *)description
                             rate:(NSInteger)rete
                              top:(NSInteger)top
                            owner:(NSString *)owner
                         deadline:(NSDate *)deadline
                           status:(NSString *)status
                         parentId:(NSString *)parentId
                             type:(NSString *)type;

@end
