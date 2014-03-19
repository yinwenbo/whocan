//
//  WHCAppContacts.m
//  whocan
//
//  Created by Yin Wenbo on 14-3-17.
//  Copyright (c) 2014年 Yin Wenbo. All rights reserved.
//

#import "WHCAppContactsStore.h"

static WHCAppContactsStore * appContactsStore;



@implementation WHCAppContactsStore


+ (WHCAppContactsStore *) getInstance
{
    if (appContactsStore == nil){
        appContactsStore = [[WHCAppContactsStore alloc] init];
    }
    return appContactsStore;
}


- (NSArray *) getAppUsers
{
    return [[NSArray alloc] initWithObjects:
            [[AppUser alloc] initWithValues:@"余超" userid:@"1" mobileNo:@"15321508861"],
            [[AppUser alloc] initWithValues:@"张靖乐" userid:@"2" mobileNo:@"18600242598"],
            [[AppUser alloc] initWithValues:@"李晓峰" userid:@"3" mobileNo:@"18500190692"],
            nil];
}

- (AppContact *) createAppContact
{
    NSManagedObjectContext *context = [WHCModelStore getInstance].managedObjectContext;
    AppContact * contact = (AppContact *)[NSEntityDescription insertNewObjectForEntityForName:@"AppContact" inManagedObjectContext:context];
    contact.contactId = [[[NSUUID alloc] init] UUIDString];
    return contact;
}

- (void) saveContext
{
    NSManagedObjectContext *context = [WHCModelStore getInstance].managedObjectContext;
    NSError *error;
    if(![context save:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

}

- (NSArray *)getAppContacts
{
    return [self getAppContacts:nil sort:nil];
}

- (AppContact *)findAppContactByABId:(int32_t)recordId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phoneABId = %i", recordId];
    NSArray *results = [self getAppContacts:predicate sort:nil];
    if ([results count] >0 ){
        return [results objectAtIndex:0];
    }
    return nil;
}

- (NSArray *)getAppContacts:(NSPredicate*)predicate sort:(NSArray*)sort
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSManagedObjectContext * context = [WHCModelStore getInstance].managedObjectContext;
    NSEntityDescription *myEntityQuery = [NSEntityDescription
                                          entityForName:@"AppContact"
                                          inManagedObjectContext:context];
    [request setEntity:myEntityQuery];
    if (predicate != nil){
        [request setPredicate:predicate];
    }
    if (sort != nil){
        [request setSortDescriptors:sort];
    }
    NSError *error = nil;
    NSArray * result = [context executeFetchRequest:request error:&error];
    
    return result;
}
@end
