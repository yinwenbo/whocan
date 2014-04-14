//
//  WHCModelStore.h
//  whocan
//
//  Created by Yin Wenbo on 14-3-5.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WHCModelStore : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

+ (void)saveContext;
+ (WHCModelStore *) getInstance;
+ (id)insertEntity:(NSString*)entityName;
+ (void)deleteEntity:(id)entity;
+ (NSArray *)queryEntitys:(NSString*)entityName predicate:(NSPredicate*)predicate sort:(NSArray*)sort;

@end
