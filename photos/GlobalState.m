//
//  GlobalState.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "GlobalState.h"

NSString *CURRENT_EVENT = @"currentData";
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
        NSData *eventsData = [[NSUserDefaults standardUserDefaults] objectForKey:EVENTS];
        events = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:eventsData];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_EVENT]){
        NSData *currentEventData = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_EVENT];
        currentEvent = (Event*) [NSKeyedUnarchiver unarchiveObjectWithData:currentEventData];
    }

//    if ([[NSUserDefaults standardUserDefaults] objectForKey:EVENTS]){
//        events = (NSDictionary*) [[NSUserDefaults standardUserDefaults]objectForKey:EVENTS];
//    }
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_EVENT]){
//        currentEvent = (Event*) [[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_EVENT];
//    }
}
- (void) commit {
    NSData *eventsData = [NSKeyedArchiver archivedDataWithRootObject:events];
    [[NSUserDefaults standardUserDefaults] setObject:eventsData forKey:EVENTS];
    
    NSData *currentEventData = [NSKeyedArchiver archivedDataWithRootObject:currentEvent];
    [[NSUserDefaults standardUserDefaults] setObject:currentEventData forKey:CURRENT_EVENT];

//    [[NSUserDefaults standardUserDefaults] setObject:events forKey:EVENTS];
//    [[NSUserDefaults standardUserDefaults] setObject:currentEvent forKey:CURRENT_EVENT];
}

- (id)init {
    if (self = [super init]) {
        events = [[[EventsRequest alloc]init] getEvents];
    }
    return self;
}

@end


