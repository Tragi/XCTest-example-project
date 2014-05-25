//
//  ContentManager.h
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 22.04.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;

@interface ContentManager : NSObject

+ (instancetype)manager;

- (void)getEntitiesWithParameters:(NSString *)parameters completion:(void (^)(NSArray* entities, NSError *error))completion;

- (void)getEntityWithIdentifier:(NSNumber *)identifier completion:(void (^)(Entity* entitiy, NSError *error))completion;

- (void)updateEntity:(Entity *)entity completion:(void (^)(NSError *error))completion;

- (void)deleteEntityWithIdentifier:(NSNumber *)identifier completion:(void (^)(NSError *error))completion;

- (void)addEntity:(Entity *)entity completion:(void (^)(Entity *entity, NSError *error))completion;


- (void)archiveEntity:(Entity *)entity;

- (Entity *)unarchiveEntityWithIdentifier:(NSNumber *)identifier;

@end

extern NSString *const ContentManagerBadParameters;
extern NSString *const ContentManagerGoodParameters;