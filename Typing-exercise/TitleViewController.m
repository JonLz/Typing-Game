//
//  TitleViewController.m
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "TitleViewController.h"
#import "GameViewController.h"

@interface TitleViewController ()

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"typing"];
    self.titleImage.image = image;
    
    [self.difficultySelector.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.titleImage.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSUInteger difficulty = self.difficultySelector.selectedSegmentIndex;
    TypingGame *game = [[TypingGame alloc] initGameWithDifficuty:difficulty];
    
    GameViewController *desinationVC = segue.destinationViewController;
    
    desinationVC.game = game;

}

@end
