//
//  PhotoSession.m
//  photos
//
//  Created by Cevaris on 7/26/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSession.h"

@implementation PhotoSession


- (PhotoSession*) init {
    if (self = [super init]) {
        self.createdAt  = [NSDate date];
        self.attemptNum = 0;
        self.isSuccess  = NO;
        self.objectId   = nil;
        self.slug       = nil;
        self.url        = nil;
        self.eventId    = nil;
        self.eventSlug  = nil;
        self.db         = nil;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Photo: PhoneList=%@ Photos=[%@,%@,%@] CreatedAt=%@ AttemtNum=%d IsSuccess=%@ Url=%@",
            [self phoneList],
            [self photoOne], [self photoTwo], [self photoThree],
            [self createdAt],
            [self attemptNum], ([self isSuccess] ? @"YES" : @"NO"),
            [self url]];
}

@end
