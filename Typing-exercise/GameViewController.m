//
//  GameViewController.m
//  Typing-exercise
//
//  Created by Kevin Lin on 10/15/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "GameViewController.h"
#import "UIImage+AnimatedGIF.h"
@interface GameViewController ()

@property (weak, nonatomic) IBOutlet UITextView *storyTextView;
@property (weak, nonatomic) IBOutlet UITextField *userInputField;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property(strong, nonatomic)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (nonatomic, assign) NSUInteger correctIndex;
@property (weak, nonatomic) IBOutlet UILabel *wpmLabel;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storyTextView.text = self.game.gameText;
    self.timerLabel.text = [NSString stringWithFormat:@"%lu", self.game.timeAllowed];
    
    self.userInputField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    //Overriding UITextField delegate
    self.userInputField.delegate = self;
    
    self.exitButton.hidden = YES;
    
//    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://33.media.tumblr.com/7e71f3316e44417e20e10ea3620c6a76/tumblr_my8dm6J64M1ro8ysbo1_500.gif"]];
//    self.gameImage.image = mygif;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"typing" withExtension:@"gif"];
    self.gameImage.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.gameImage.contentMode = UIViewContentModeScaleAspectFit;
    self.correctIndex = 0;
    [self.userInputField addTarget:self
                  action:@selector(updateTextView)
        forControlEvents:UIControlEventEditingChanged];
    self.wpmLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (!self.game.gameStarted) {
        self.game.gameStarted = YES;
        NSLog(@"Game started! Yes!");
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [self.timer fire];
    }
    
    NSString *fieldText = self.userInputField.text;
    NSString *resultString;
    
    if (self.game.gameText.length <= fieldText.length && string.length) {
        return NO;
    }
    else if (!string.length) {
        NSString *stringAfterDelete = [fieldText substringToIndex:fieldText.length-1];
        resultString =  [NSString stringWithString:stringAfterDelete];
    }
    else{
        resultString = [NSString stringWithFormat:@"%@%@",fieldText,string];
    }
    
    [self changeTimerColor:resultString];
    if ([self inputStringMatch:resultString] && [self textLengthMatch:resultString]) {
        NSLog(@"You passed!");
        [self.timer invalidate];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInputField.userInteractionEnabled = NO;
            [self.userInputField resignFirstResponder];
            self.exitButton.hidden = NO;
        });
        
//        UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"https://media.giphy.com/media/13phyG5Y1MAeDm/giphy.gif"]];
//        self.gameImage.image = mygif;
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"gif"];
        self.gameImage.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        
        [self displayWPMLabel];
    }
    
    return YES;
}


-(void)gameOver{
    [self.timer invalidate];
    self.userInputField.userInteractionEnabled = NO;
    [self.userInputField resignFirstResponder];
    self.exitButton.hidden = NO;
    [self displayWPMLabel];
    
//    UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"https://media.giphy.com/media/33iqmp5ATXT5m/giphy.gif"]];
//    self.gameImage.image = mygif;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"lose" withExtension:@"gif"];
    self.gameImage.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
}

-(void)displayWPMLabel
{
    self.wpmLabel.text = [NSString stringWithFormat:@"Words Per Minute: %@", [NSString stringWithFormat:@"%0.1f",[self.game calculatedWPM:self.userInputField.text]]];
    self.wpmLabel.hidden = NO;
}

-(void)updateTimer{
    NSUInteger currentTime = [self.game timeUpdate];
    if (!currentTime) {
        [self gameOver];
    }
    self.timerLabel.text = [NSString stringWithFormat:@"%lu", currentTime];
}

-(void)changeTimerColor:(NSString *)inputFieldText{
    if (!inputFieldText.length) {
        self.timerLabel.textColor = [UIColor greenColor];
    }
    else if ([self inputStringMatch:inputFieldText] ) {
        self.timerLabel.textColor = [UIColor greenColor];
    }
    else{
        self.timerLabel.textColor = [UIColor redColor];
    }
}

-(void)updateTextView
{
    NSString *gameText = self.game.gameText;
    NSString *currentUserInput = self.userInputField.text;
    NSUInteger currentIndex = self.userInputField.text.length;
    NSString *currentString = [gameText substringToIndex:currentIndex];
    NSUInteger correctIndex = [currentString rangeOfString:currentUserInput].length;
//    NSLog(@"%@ %@", self.userInputField.text, [gameText substringToIndex:correctIndex]);
//    NSLog(@"%@",self.game.gameText);

    if (correctIndex) {
        self.correctIndex = correctIndex;
    }
    if (!currentUserInput.length) {
        self.correctIndex = 0;
    }
    
    NSRange correctRange = NSMakeRange(0, self.correctIndex);
    NSRange incorrectRange = NSMakeRange(correctRange.length, currentUserInput.length-correctRange.length);
    NSRange remainingRange = NSMakeRange(correctRange.length + incorrectRange.length, self.game.gameText.length - correctRange.length - incorrectRange.length);
    
    NSString *correctString = [gameText substringWithRange:correctRange];
    NSString *incorrectString = [gameText substringWithRange:incorrectRange];
    NSString *remainingString = [gameText substringWithRange:remainingRange];

    NSAttributedString *csa = [[NSAttributedString alloc] initWithString:correctString attributes:[self textAttributesWithColor:[UIColor greenColor]]];
    NSAttributedString *icsa = [[NSAttributedString alloc] initWithString:incorrectString attributes:[self textAttributesWithColor:[UIColor redColor]]];
    NSAttributedString *rsa = [[NSAttributedString alloc] initWithString:remainingString attributes:[self textAttributesWithColor:[UIColor blackColor]]];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    if (csa.length > 0) {
        [string appendAttributedString:csa];
    }
    
    if (icsa.length > 0) {
        [string appendAttributedString:icsa];
    }
    
    if (rsa.length > 0) {
        [string appendAttributedString:rsa];
    }
    
    self.storyTextView.attributedText = string;
    self.storyTextView.textAlignment = NSTextAlignmentCenter;
}

-(NSDictionary *)textAttributesWithColor:(UIColor *)color
{
    return @{ NSForegroundColorAttributeName : color,
              NSFontAttributeName : self.storyTextView.font};
}

-(BOOL)inputStringMatch:(NSString *)inputFieldText{
    NSString *gameText = self.game.gameText;
    return [[gameText substringToIndex:inputFieldText.length] isEqualToString:inputFieldText];
}

-(BOOL)textLengthMatch:(NSString *)inputFieldText{
    NSString *gameText = self.game.gameText;
    return gameText.length == inputFieldText.length;
}

- (IBAction)exitGame:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
