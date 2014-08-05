//
//  CPhotoSessions.m
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "CPhotoSession.h"

@implementation CPhotoSession

+ (NSArray*) loadAll {
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
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"PhotoSessions" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"PhotoSesion: %@", info);
        PhotoSession *ps = [[PhotoSession alloc] init];
        [ps setCreatedAt:(NSDate *) [info valueForKey:@"createdAt"]];
        [ps setAttemptNum:[info valueForKey:@"attemptNum"]];
        [ps setPhoneList:[info  valueForKey:@"phoneList"]];
        [ps setIsSuccess:[info  valueForKey:@"isSuccess"]];
//        ps set:[info valueForKey:@""];
//        ps set:[info valueForKey:@""];
//        ps set:[info valueForKey:@""];
        
        [results addObject:ps];
//        NSLog(@"CreatedAt: %@", [info valueForKey:@"createdAt"]);
//        NSManagedObject *details = [info valueForKey:@"details"];
//        NSLog(@"phoneList: %@", [details valueForKey:@"phoneList"]);
    }
    return results;
}

+ (BOOL) deleteAll {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    for (NSManagedObject * obj in [CPhotoSession loadAll]) {
        [context deleteObject:obj];
    }
    NSError *error = nil;
    [context save:&error];

    if (error) {
        NSLog(@"The error was: %@", [error localizedDescription]);
        return NO;
    } else {
        NSLog(@"Successfull save");
        return YES;
    }
    
    
}

+ (BOOL) save:(PhotoSession*)ps {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *mObject;
    
    mObject = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoSessions"
                                            inManagedObjectContext:context];
    
    NSLog(@"Saving PhotoSession: %@", ps);
    
    [mObject setValue:[ps createdAt]  forKey:@"createdAt"];
    [mObject setValue:[ps phoneList]  forKey:@"phoneList"];
    [mObject setValue:[ps photoOne]   forKey:@"photoOne"];
    [mObject setValue:[ps photoTwo]   forKey:@"photoTwo"];
    [mObject setValue:[ps photoThree] forKey:@"photoThree"];
    [mObject setValue:[ps attemptNum] forKey:@"attemptNum"];
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
