//
//  IMTXCTestCase.h
//  Inmite XCTest Example Project
//
//  Created by Lukas Mareda on 22.04.14.
//  Copyright (c) 2014 Inmite. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface IMTXCTestCase : XCTestCase

/**
 For asynchronous testing its need to be paused main thread until asynchronous operation is complete.
 The pauseThread method needs to be called at the end of testing method. There is infinity loop which pausing mainthread in each iteration.
 */

- (void)pauseThread;

/**
 When asynchonous operation is complete there needs to be infinity loop ended, otherwise testing is never ended.
 */
- (void)continueThread;

@end
