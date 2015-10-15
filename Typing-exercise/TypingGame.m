//
//  TypingGame.m
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "TypingGame.h"

@interface TypingGame ()

@property(nonatomic, readwrite)NSUInteger score;
@property(nonatomic, readwrite)NSUInteger timeAllowed;
@property(strong, nonatomic, readwrite)NSString *gameText;
@property(nonatomic)NSUInteger time;

@end

@implementation TypingGame

-(instancetype)init{
    self = [self initGameWithDifficuty:0];
    return self;
}

-(instancetype)initGameWithDifficuty:(NSUInteger)difficulty{
    self = [super init];
    if (self) {
        _diffulty = difficulty;
        _score = 0;
        _gameText = [TypingGame gameTextForDifficulty:difficulty];
        _timeAllowed = self.gameText.length;
        _time = self.timeAllowed;
        _gameStarted = NO;
    }
    return self;
}

+(NSString *)gameTextForDifficulty:(NSUInteger)difficulty{
    
    NSString *gameText;
    switch (difficulty) {
        case 0:
            gameText = @"Work hard. Dream big.";
            break;
        case 1:
            gameText = @"It does not matter how slowly you go as long as you do not stop.";
            break;
        case 2:
            gameText = @"If you live long enough, you'll make mistakes. But if you learn from them, you'll be a better person. It's how you handle adversity, not how it affects you. The main thing is never quit, never quit, never quit.";
            break;
        default:
            break;
    }
    
    return gameText;
}

-(NSUInteger)timeUpdate{
    self.time -= 1;
    
    return self.time;
}

@end
