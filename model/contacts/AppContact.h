//
//  AppContact.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-18.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppContact : NSManagedObject

@property (nonatomic) int32_t phoneABId;
@property (nonatomic, retain) NSString * phoneABName;
@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * appName;
@property (nonatomic) BOOL isAppFriend;
@property (nonatomic) BOOL isAppUser;
@property (nonatomic, retain) NSString * contactId;
@property (nonatomic, retain) NSString * appMobileNo;
@property (nonatomic, retain) NSString * appMail;

@end
