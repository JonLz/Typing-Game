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
        if (self.diffulty == 0) {
            _timeAllowed = self.gameText.length;
        }else if (self.diffulty == 1){
            _timeAllowed = self.gameText.length / 4;
        }else{
            _timeAllowed = self.gameText.length / 8;
        }
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
//    NSLog(@"Time update called. Time is %lu", self.time);
    return self.time;
}

-(CGFloat)calculatedWPM:(NSString *)string
{
    CGFloat time = self.timeAllowed - self.time;
    //CGFloat length = self.gameText.length;
    CGFloat elem = [self wordCount:string];
    return elem/time*60;
}

- (NSUInteger)wordCount:(NSString *)string {
    NSCharacterSet *separators = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [string componentsSeparatedByCharactersInSet:separators];
    
    NSIndexSet *separatorIndexes = [words indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isEqualToString:@""];
    }];
    
    return [words count] - [separatorIndexes count];
}
@end
