//
//  MockEntity.h
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 06.05.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import "Entity.h"

@interface MockEntity : Entity


/**
    Create mock object from real object
    @warning Mock object behave like real objeck, but not change or touch real environment.
 */

+ (id)mockEntityWithEntity:(Entity *)entity;

@end
