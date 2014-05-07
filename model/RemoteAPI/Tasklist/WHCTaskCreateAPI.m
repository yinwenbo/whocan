//
//  WHCTaskCreateAPI.m
//  whocan
//
//  Created by Yin Wenbo on 14-4-29.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCTaskCreateAPI.h"

@implementation WHCTaskCreateAPI

+(WHCTaskCreateAPI *)getInstance:(id<WHCJsonAPIDelegate>)delegate
                           title:(NSString *)title
                         groupId:(NSString *)groupId
                     description:(NSString *)description
                            rate:(NSInteger)rate
                             top:(NSInteger)top
                           owner:(NSString *)owner
                        deadline:(NSDate *)deadline
                          status:(NSString *)status
                        parentId:(NSString *)parentId
                            type:(NSString *)type
{
    /*
     private String title;
     private String groupId;
     private String description;
     private int rate;
     private int top;
     private String createUser;
     private String owner;
     private long deadline;
     private String status;
     private String parentId;
     private String type;
     */

    NSMutableDictionary *params = [WHCJsonAPI createParameter];
    [params setObject:title forKey:@"title"];
    [params setObject:groupId forKey:@"groupId"];
    [params setObject:description forKey:@"description"];
    [params setObject:owner forKey:@"owner"];
    [params setObject:deadline forKey:@"deadline"];
    [params setObject:status forKey:@"status"];
    [params setObject:parentId forKey:@"parentId"];
    [params setObject:type forKey:@"type"];
    [params setObject:[NSNumber numberWithInteger:rate] forKey:@"rete"];
    [params setObject:[NSNumber numberWithInteger:top] forKey:@"top"];

    return [[WHCTaskCreateAPI alloc] initWithJsonDelegate:@"task/create"
                                                   params:params
                                                 delegate:delegate];
}

- (void)successJsonResult
{

}
@end
