//
//  Message.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * messageId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * senderId;
@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * status;

@end
