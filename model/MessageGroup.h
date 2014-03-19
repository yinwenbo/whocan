//
//  MessageGroup.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-3.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageGroup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * unread;

@end
