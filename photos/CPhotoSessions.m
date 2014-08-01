//
//  CPhotoSessions.m
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "CPhotoSessions.h"

@implementation CPhotoSessions

- (NSArray*) loadAll {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PhotoSessions"];
    
    NSPredicate  *predicate = [NSPredicate predicateWithFormat:@"1==1"];
    [request setPredicate:predicate];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSError *error = nil;
    NSArray *data = [context executeFetchRequest:request error:&error];
    
    if(error){
        NSLog(@"%@", error);
    }
    
    return data;
}

- (BOOL) save:(PhotoSession*)ps {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSManagedObject *mObject;
    
    mObject = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoSessions"
                                            inManagedObjectContext:context];
    [ps setCreatedAt:  (NSDate*) [mObject valueForKey:@"createdAt"]];
    [ps setPhoneList:  [mObject valueForKey:@"photoList"]];
    [ps setPhotoOne:   [mObject valueForKey:@"photoOne"]];
    [ps setPhotoTwo:   [mObject valueForKey:@"photoTwo"]];
    [ps setPhotoThree: [mObject valueForKey:@"photoThree"]];
    [ps setAttemptNum: [[mObject valueForKey:@"attemptNum"] intValue]];
    
    NSError *error;

    [context save:&error];
    
    if (error) {
        NSLog(@"The error was: %@", [error localizedDescription]);
    } else {
        NSLog(@"Successfull save");
    }
    
    return YES;
}

@end
