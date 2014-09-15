//
//  PhotoSession.h
//  photos
//
//  Created by Cevaris on 7/26/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSession : NSObject


@property NSString  *objectId;
@property NSString  *slug;
@property NSString  *url;
@property NSDate    *createdAt;
@property NSString  *phoneList;
@property NSString  *photoOne;
@property NSString  *photoTwo;
@property NSString  *photoThree;
@property NSString  *eventId;
@property NSString  *eventSlug;
@property int       attemptNum;
@property BOOL      isSuccess;

@property NSManagedObject *db;

- (NSString *)description;
@end
