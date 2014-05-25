//
//  Inmite_XCTest_Example_ProjectTests.m
//  Inmite XCTest Example ProjectTests
//
//  Created by Lukas Mareda on 22.04.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import "ContentManager.h"
#import "IMTXCTestCase.h"
#import "Entity.h"

#import "MockEntity.h"

@interface Inmite_XCTest_Example_ProjectTests : IMTXCTestCase

@end

@implementation Inmite_XCTest_Example_ProjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//all testing method (cases) must have prefix "test"
- (void)testAsynchronousOperations {
    
    __weak typeof(self)weakSelf = self;

    //test of REST api single endpoint with all methods
    [[ContentManager manager] getEntitiesWithParameters:ContentManagerGoodParameters completion:^(NSArray *entities, NSError *error) {
        
        XCTAssert(entities.count == 2, @"Entity count should be 2");
        XCTAssert(!error, @"There should not be any error");
        
        Entity *entity = [entities firstObject];
        entity.name = @"Updated entity";
        
        [[ContentManager manager] updateEntity:entity completion:^(NSError *error) {
            
            XCTAssert(!error, @"There should not be any error");
            XCTAssert([entity.name isEqualToString:@"Updated entity"], @"Entity should has different name");
            
            Entity *entity = [[Entity alloc] init];
            entity.name = @"Brand new entity";
            
            [[ContentManager manager] addEntity:entity completion:^(Entity *entity, NSError *error) {
                
                XCTAssert(!error, @"There should not be any error");
                XCTAssert([entity.name isEqualToString:@"Brand new entity"], @"Entity should has different name");
                XCTAssert([entity.identifier isEqualToNumber:@(3)], @"Entity should has different identifier");
                
                [[ContentManager manager] deleteEntityWithIdentifier:@(1) completion:^(NSError *error) {

                    XCTAssert(!error, @"There should not be any error");
                    
                    [[ContentManager manager] getEntitiesWithParameters:ContentManagerGoodParameters completion:^(NSArray *entities, NSError *error) {
                        
                        XCTAssert(entities.count == 2, @"Entity count should be 2");
                        XCTAssert(!error, @"There should not be any error");
                        
                        [weakSelf continueThread];
                    }];
                    
                }];
            }];
        }];
    }];
    
    
    [self pauseThread];
}

- (void)testDataConsistency {
    Entity *entity = [Entity new];
    entity.identifier = @(1);
    
    [[ContentManager manager] archiveEntity: entity];
    Entity *unarchivedEntity = [[ContentManager manager] unarchiveEntityWithIdentifier:@(1)];
    
    XCTAssert([entity.identifier isEqualToNumber:unarchivedEntity.identifier], @"Entity should be unarchived correctly");
}

- (void)testSomeMockObject {
    //i recomend using of http://ocmock.org/ which is most popular mocking library
    //this example is mocking with simple mock object
    
    Entity *entity = [Entity new];
    entity.identifier = @(1);
    [[ContentManager manager] archiveEntity: entity];
    
    MockEntity *mockEntity = [MockEntity mockEntityWithEntity:[[ContentManager manager] unarchiveEntityWithIdentifier:@(1)]];
    
    XCTAssert([mockEntity.identifier isEqualToNumber:@(2)], @"Mock object should not touch the real environment");
    
}

@end
