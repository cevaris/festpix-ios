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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    events = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:EVENTS]];
    currentEvent = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:CURRENT_EVENT]];
    
}
- (void) deleteAll {
    events = nil;
    currentEvent = nil;
    [self commit];
}

- (void) commit {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.events] forKey:EVENTS];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.currentEvent] forKey:CURRENT_EVENT];
    [userDefaults synchronize];
    
}

- (id)init {
    if (self = [super init]) {
        // Load previous state
        [self load];

        // Update state
        events = [[[EventsRequest alloc]init] getEvents];
        currentEvent = currentEvent ? currentEvent : @"festpix";
        
        NSLog(@"%@", events);
        
        // Save state
        [self commit];
    }
    return self;
}

@end


