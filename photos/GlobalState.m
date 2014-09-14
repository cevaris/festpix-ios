//
//  GlobalState.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "GlobalState.h"

NSString *CURRENT_EVENT = @"currentEvent";
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
    return state;
}

- (void) load {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:EVENTS]){
        NSData *eventsData = [defaults objectForKey:EVENTS];
        events = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:eventsData];
    }
    if ([defaults objectForKey:CURRENT_EVENT]){
        NSData *currentEventData = [defaults objectForKey:CURRENT_EVENT];
        currentEvent = [NSKeyedUnarchiver unarchiveObjectWithData:currentEventData];
    }
    
}
- (void) deleteAll {
    events = nil;
    currentEvent = nil;
    [self commit];
}

- (void) commit {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *currentEventData = [NSKeyedArchiver archivedDataWithRootObject:currentEvent];
    [defaults setObject:currentEventData forKey:CURRENT_EVENT];
    
    NSData *eventsData = [NSKeyedArchiver archivedDataWithRootObject:events];
    [defaults setObject:eventsData forKey:EVENTS];
    
    
    [defaults synchronize];
}

- (id)init {
    if (self = [super init]) {
        events = [[[EventsRequest alloc]init] getEvents];
        // Commit any updates
        [self commit];
    }
    [self load];
    return self;
}

@end


