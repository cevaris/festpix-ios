//
//  GlobalState.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "GlobalState.h"

NSString *CURRENT_EVENT = @"events";
NSString *EVENTS = @"events";

@implementation GlobalState

@synthesize currentEvent;
@synthesize events;

+ (id)sharedState {
    static GlobalState *state = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        state = [[self alloc] init];
    });
    // Reload state
    [state load];
    return state;
}

- (void) load {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:EVENTS]){
        events = [[NSUserDefaults standardUserDefaults]objectForKey:EVENTS];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_EVENT]){
        currentEvent = [[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_EVENT];
    }
}
- (void) commit {
    [[NSUserDefaults standardUserDefaults] setObject:events forKey:EVENTS];
    [[NSUserDefaults standardUserDefaults] setObject:currentEvent forKey:CURRENT_EVENT];
}

- (id)init {
    if (self = [super init]) {
        events = [[[EventsRequest alloc]init] getEvents];
    }
    return self;
}

@end


