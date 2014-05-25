//
//  IMTXCTestCase.m
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 22.04.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import "IMTXCTestCase.h"

@interface IMTXCTestCase ()

@property (nonatomic) BOOL _waitUntilAsyncDone;

@end

@implementation IMTXCTestCase

- (void)setUp {
    [super setUp];
    __waitUntilAsyncDone = YES;
}

- (void)tearDown {
    [super tearDown];
}

- (void)pauseThread {
    while (__waitUntilAsyncDone) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    __waitUntilAsyncDone = YES;
}

- (void)continueThread {
    __waitUntilAsyncDone = NO;
}

@end
