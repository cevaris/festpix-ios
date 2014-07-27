//
//  PhotoSession.m
//  photos
//
//  Created by Cevaris on 7/26/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSession.h"
#import "AppDelegate.h"

@implementation PhotoSession



- (bool) save {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
   
    NSManagedObject *newContact;
    
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"PhotoSessions"
                  inManagedObjectContext:context];
    [newContact setValue: _timestamp.text forKey:@"timestamp"];
    [newContact setValue: _photoOne.text forKey:@"photoOne"];
//    [newContact setValue: _phone.text forKey:@"phone"];
    _name.text = @"";
    _address.text = @"";
    _phone.text = @"";
    NSError *error;
    [context save:&error];
    _status.text = @"Contact saved";
    
    return YES;
}

@end
