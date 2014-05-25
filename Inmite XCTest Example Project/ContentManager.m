//
//  ContentManager.m
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 22.04.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import "ContentManager.h"
#import "Entity.h"

NSString *const ContentManagerBadParameters = @"ContentManagerBadParameters";
NSString *const ContentManagerGoodParameters = @"ContentManagerGoodParameters";


@implementation ContentManager  {
    Entity *_archivedEntity;
}

+ (instancetype)manager {
	static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    
	return _sharedInstance;
}


- (void)getEntitiesWithParameters:(NSString *)parameters completion:(void (^)(NSArray* entities, NSError *error))completion {
    
    NSParameterAssert(parameters);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) {
            if ([parameters isEqualToString:ContentManagerGoodParameters]) {

                completion(@[({Entity *entity = [Entity new]; entity.identifier = @(1); entity.name = @"E1"; entity;}), ({Entity *entity = [Entity new]; entity.identifier = @(2); entity.name = @"E2"; entity;})], nil);

            } else if ([parameters isEqualToString:ContentManagerBadParameters]) {
                
                completion(nil, [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Entities with given parameters not found"}]);
            }
        }
    });
}

- (void)getEntityWithIdentifier:(NSNumber *)identifier completion:(void (^)(Entity* entitiy, NSError *error))completion {
    
    NSParameterAssert(identifier);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) {
            if ([identifier isEqualToNumber:@(1)]) {
                
                completion(({Entity *entity = [Entity new]; entity.identifier = @(1); entity.name = @"E1"; entity;}), nil);
                
            } else {
                
                completion(nil, [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Entity with given identifier not found"}]);
            }
        }
    });
}

- (void)updateEntity:(Entity *)entity completion:(void (^)(NSError *error))completion {
    
    NSParameterAssert(entity);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) {
            if ([entity.identifier isEqualToNumber:@(1)]) {
                
                completion(nil);
                
            } else {
                
                completion([[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Entity with given identifier not found"}]);
            }
        }
    });
}

- (void)deleteEntityWithIdentifier:(NSNumber *)identifier completion:(void (^)(NSError *error))completion {
 
    NSParameterAssert(identifier);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) {
            if ([identifier isEqualToNumber:@(1)]) {
                
                completion(nil);
                
            } else {
                
                completion([[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Entity with given identifier not found"}]);
            }
        }
    });
}

- (void)addEntity:(Entity *)entity completion:(void (^)(Entity *entity, NSError *error))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (completion) {
            if (!entity.identifier) {
                
                completion(({entity.identifier = @(3); entity;}), nil);
                
            } else {
                
                completion(nil, [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey: @"Entity with given identifier not found"}]);
            }
        }
    });
}

- (void)archiveEntity:(Entity *)entity {
    _archivedEntity = entity;
}

- (Entity *)unarchiveEntityWithIdentifier:(NSNumber *)identifier {
    if ([identifier isEqualToNumber:_archivedEntity.identifier]) {
        return _archivedEntity;
    }
    
    return nil;
}


@end
