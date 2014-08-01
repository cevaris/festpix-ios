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

@interface CPhotoSessions : NSObject

+ (NSArray*)loadAll;
+ (BOOL)save:(PhotoSession*)ps;

@end
