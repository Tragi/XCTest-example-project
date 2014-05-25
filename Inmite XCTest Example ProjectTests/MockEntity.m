//
//  MockEntity.m
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 06.05.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import "MockEntity.h"

@implementation MockEntity

+ (id)mockEntityWithEntity:(Entity *)entity {
    return [self new];
}

- (NSNumber *)identifier {
    return @(2);
}

- (void)setIdentifier:(NSNumber *)identifier {
    
}

- (NSString *)name {
    return @"MockEntity";
}

- (void)setName:(NSString *)name {
    
}

@end
