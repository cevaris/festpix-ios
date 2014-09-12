//
//  Event.m
//  photos
//
//  Created by Adam Cardenas on 9/11/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "Event.h"

@implementation Event


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.objectId = [decoder decodeObjectForKey:@"objectId"];
        self.logo = [decoder decodeObjectForKey:@"logo"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.slug = [decoder decodeObjectForKey:@"slug"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.objectId forKey:@"objectId"];
    [encoder encodeObject:self.logo forKey:@"logo"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.slug forKey:@"slug"];
}


@end
