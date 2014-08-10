//
//  CPhotoSessions.h
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "PhotoSession.h"

@interface PhotoSessionPersistence : NSObject

+ (NSArray*)loadAll;
+ (BOOL)deleteAll;
+ (BOOL)save:(PhotoSession*)ps;
//+ (BOOL)update:(PhotoSession*)ps;

@end
