//
//  AppUser.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * mobileNo;

- (instancetype)initWithValues: (NSString*)name userid:(NSString*)userId mobileNo:(NSString*)mobileNo;

@end
