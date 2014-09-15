//
//  CPhotoSessions.m
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSessionPersistence.h"

@implementation PhotoSessionPersistence

+ (NSArray*) loadAll {
    
//    http://stackoverflow.com/questions/12992129/core-data-issue-unable-to-store-nsnumber
    
    
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PhotoSessions"];
//    
//    NSPredicate  *predicate = [NSPredicate predicateWithFormat:@"1==1"];
//    [request setPredicate:predicate];
//    
//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
//    
//    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
//    
//    NSError *error = nil;
//    NSArray *data = [context executeFetchRequest:request error:&error];
//    
//    if(error){
//        NSLog(@"%@", error);
//    }
//    
//    return data;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:descriptor];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"PhotoSessions" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSManagedObject *info in fetchedObjects) {
//        NSLog(@"PhotoSesion: %@", info);
        PhotoSession *ps = [[PhotoSession alloc] init];
    
        [ps setCreatedAt:(NSDate *) [info valueForKey:@"createdAt"]];
        [ps setAttemptNum:(int)[info valueForKey:@"attemptNum"]];
        [ps setObjectId:[info valueForKey:@"objectId"]];
        [ps setSlug:[info valueForKey:@"slug"]];
        [ps setUrl:[info valueForKey:@"url"]];
        [ps setPhoneList: [info  valueForKey:@"phoneList"]];
        [ps setIsSuccess:[(NSNumber*)[info  valueForKey:@"isSuccess"] boolValue]];
        [ps setPhotoOne:[info valueForKey:@"photoOne"]];
        [ps setPhotoTwo:[info valueForKey:@"photoTwo"]];
        [ps setPhotoThree:[info valueForKey:@"photoThree"]];
        [ps setEventId:[info valueForKey:@"eventId"]];
        [ps setEventSlug:[info valueForKey:@"eventSlug"]];
        [ps setDb:info];
      
        [results addObject:ps];
    }
    return results;
}

+ (BOOL) deleteAll {

    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"PhotoSessions" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject * obj in fetchedObjects) {
        [context deleteObject:obj];
    }
    
    [context save:&error];

    if (error) {
        NSLog(@"The error was: %@", [error localizedDescription]);
        return NO;
    } else {
        NSLog(@"Successfull save");
        return YES;
    }
    
    
}

//+ (BOOL) update:(PhotoSession*)ps {
//    NSError *error = nil;
//
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [appDelegate managedObjectContext];
//    
//    [context save:&error];
//    
//    if (error) {
//        NSLog(@"The error was: %@", [error localizedDescription]);
//        return NO;
//    } else {
//        NSLog(@"Successfull update");
//        return YES;
//    }
//}

+ (BOOL) save:(PhotoSession*)ps {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *mObject;
    
    if([ps db]) {
        mObject = [ps db];
        
    } else {
        mObject = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoSessions"
                                                inManagedObjectContext:context];
    }
    
    NSLog(@"Saving PhotoSession: %@", ps);
    
    [mObject setValue:[ps url]  forKey:@"url"];
    [mObject setValue:[ps objectId]  forKey:@"objectId"];
    [mObject setValue:[ps slug]  forKey:@"slug"];
    [mObject setValue:[ps eventId]  forKey:@"eventId"];
    [mObject setValue:[ps eventSlug]  forKey:@"eventSlug"];
    [mObject setValue:[ps createdAt]  forKey:@"createdAt"];
    [mObject setValue:[ps phoneList]  forKey:@"phoneList"];
    [mObject setValue:[ps photoOne]   forKey:@"photoOne"];
    [mObject setValue:[ps photoTwo]   forKey:@"photoTwo"];
    [mObject setValue:[ps photoThree] forKey:@"photoThree"];
    [mObject setValue:[NSNumber numberWithInt:[ps attemptNum]] forKey:@"attemptNum"];
    [mObject setValue:[NSNumber numberWithBool:[ps isSuccess]]  forKey:@"isSuccess"];

//    [ps setCreatedAt:  (NSDate*) [mObject valueForKey:@"createdAt"]];
//    [ps setPhoneList:  [mObject valueForKey:@"phoneList"]];
//    [ps setPhotoOne:   [mObject valueForKey:@"photoOne"]];
//    [ps setPhotoTwo:   [mObject valueForKey:@"photoTwo"]];
//    [ps setPhotoThree: [mObject valueForKey:@"photoThree"]];
//    [ps setAttemptNum: [[mObject valueForKey:@"attemptNum"] intValue]];
    
    NSError *error;

    [context save:&error];
    
    if (error) {
        NSLog(@"The error was: %@", [error localizedDescription]);
        return NO;
    } else {
        NSLog(@"Successfull save");
        return YES;
    }
    
    return YES;
}

@end
