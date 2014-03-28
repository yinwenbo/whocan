//
//  MessageSession.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-28.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageSession : NSManagedObject

@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * lastupdate;
@property (nonatomic, retain) NSNumber * unread;

@end
