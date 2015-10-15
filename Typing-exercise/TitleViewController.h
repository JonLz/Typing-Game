//
//  TitleViewController.h
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypingGame.h"

@interface TitleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySelector;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@end
