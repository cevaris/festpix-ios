//
//  PhotoSession.h
//  photos
//
//  Created by Cevaris on 7/26/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSession : NSObject


@property NSDate    *createdAt;
@property NSString  *phoneList;
@property NSString  *photoOne;
@property NSString  *photoTwo;
@property NSString  *photoThree;
@property int       attemptNum;
@property BOOL      isSuccess;

@end
