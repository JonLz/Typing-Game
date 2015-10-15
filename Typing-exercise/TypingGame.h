//
//  TypingGame.h
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypingGame : NSObject

@property(nonatomic, readonly)NSUInteger score;
@property(nonatomic, readonly)NSUInteger timeAllowed;
@property(nonatomic)NSUInteger diffulty;
@property(strong, nonatomic, readonly)NSString *gameText;
@property(strong, nonatomic, readonly)NSString *timerLabel;
@property(nonatomic)BOOL gameStarted;

-(instancetype)initGameWithDifficuty:(NSUInteger)difficulty;
-(NSUInteger)timeUpdate;

@end
