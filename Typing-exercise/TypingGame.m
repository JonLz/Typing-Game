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
            _timeAllowed = self.gameText.length / 3;
        }else{
            _timeAllowed = self.gameText.length / 4;
        }
        _time = self.timeAllowed;
        _gameStarted = NO;
    }
    return self;
}

+(NSString *)gameTextForDifficulty:(NSUInteger)difficulty{
    
    NSString *gameText = [self getRandomStoryLineWithDifficulty:difficulty];
    
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

+(NSString *)getRandomStoryLineWithDifficulty:(NSUInteger)difficulty{
    
    NSArray *easyStoryLines = @[@"Work hard. Dream big.", @"Veni, vici, vidi!",
                                @"Live for yourself.", @"Life is short. Live passionately.",
                                @"Life is a one time offer, use it well."];
    NSArray *mediumStoryLines = @[@"I don't want to earn my living; I want to live.",
                                  @"It does not matter how slowly you go as long as you do not stop.",
                                  @"What screws us up the most in life is the picture in our head of how it is supposed to be.",
                                  @"Life shrinks or expands in proportion to one's courage.",
                                  @"Life must be lived forwards, but can only be understood backwards."];
    NSArray *hardStoryLines = @[@"If you live long enough, you'll make mistakes. But if you learn from them, you'll be a better person. It's how you handle adversity, not how it affects you. The main thing is never quit, never quit, never quit.",
                                @"Deep into that darkness peering, long I stood there, wondering, fearing, doubting, dreaming dreams no mortal ever dared to dream before.",
                                @"Photography is a way of feeling, of touching, of loving. What you have caught on film is captured forever... it remembers little things, long after you have forgotten everything.",
                                @"Men go abroad to wonder at the heights of mountains, at the huge waves of the sea, at the long courses of the rivers, at the vast compass of the ocean, at the circular motions of the stars, and they pass by themselves without wondering."];
    
    if (!difficulty) {
        NSUInteger ran = arc4random_uniform((int)easyStoryLines.count);
        return easyStoryLines[ran];
    }else if (difficulty == 1){
        NSUInteger ran = arc4random_uniform((int)mediumStoryLines.count);
        return mediumStoryLines[ran];
    }else{
        NSUInteger ran = arc4random_uniform((int)hardStoryLines.count);
        return hardStoryLines[ran];
    }
}
@end
