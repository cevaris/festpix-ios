//
//  EventsRequest.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "EventsRequest.h"


@implementation EventsRequest



-(NSDictionary*) getEvents {
    NSMutableDictionary* events = [[NSMutableDictionary alloc] init];
    
    NSString *rootURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RootURL"];
    NSString *urlStr  = [NSString stringWithFormat:@"%@/events.json", rootURL];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if(!error){
        
        NSError *jsonParsingError = nil;
        NSArray *eventsJson = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0 error:&jsonParsingError];
        
        for (NSDictionary* eventJson in eventsJson) {
            Event *event = [[Event alloc] init];
            [event setObjectId: [eventJson objectForKey:@"id"]];
            [event setLogo: [eventJson objectForKey:@"logo"]];
            [event setName: [eventJson objectForKey:@"name"]];
            [event setSlug: [eventJson objectForKey:@"slug"]];
            [events setObject:event forKey:[event slug ]];
        }
        
    }
    
    return events;
}






 
@end
