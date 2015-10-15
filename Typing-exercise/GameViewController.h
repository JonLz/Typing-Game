//
//  GameViewController.h
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypingGame.h"

@interface GameViewController : UIViewController <UITextFieldDelegate>

@property(strong,nonatomic)TypingGame *game;

@end
