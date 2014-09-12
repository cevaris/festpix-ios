//
//  GlobalState.h
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventsRequest.h"

@interface GlobalState : NSObject

@property (nonatomic, retain) NSArray *events;
@property (nonatomic, retain) Event *currentEvent;

+ (id)sharedState;
- (void) commit;

@end
