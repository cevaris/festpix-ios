//
//  GlobalState.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "GlobalState.h"

@implementation GlobalState

@synthesize events;

+ (id)sharedState {
    static GlobalState *state = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        state = [[self alloc] init];
    });
    return state;
}

- (id)init {
    if (self = [super init]) {
        events = [[[EventsRequest alloc]init] getEvents];
    }
    return self;
}

@end
