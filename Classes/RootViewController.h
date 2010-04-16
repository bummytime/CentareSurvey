//
//  RootViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuestionOneViewController;
@class QuestionTwoViewController;
@class QuestionThreeViewController;
@class WelcomeViewController;


@protocol QuestionViewController
	- (int)questionNumber;
@end

@protocol AutoAdjustingOrientation
	- (void)supportPortrait;
	- (void)supportLandscape;
@end

@interface RootViewController : UIViewController {
	UINavigationBar *navigationBar;
	WelcomeViewController *welcomeViewController;
	QuestionOneViewController *questionOneViewController;
	QuestionTwoViewController *questionTwoViewController;
	QuestionThreeViewController *questionThreeViewController;
}

@property (retain, nonatomic) WelcomeViewController *welcomeViewController;
@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) QuestionOneViewController *questionOneViewController;
@property (retain, nonatomic) QuestionTwoViewController *questionTwoViewController;
@property (retain, nonatomic) QuestionThreeViewController *questionThreeViewController;

- (IBAction)previousQuestion:(id)sender;
- (IBAction)nextQuestion:(id)sender;
- (void) clearAllButtons;
- (void) createOnlyPreviousButton;
- (void) createOnlyNextButton;
- (void) createPreviousNextButton;
- (void) beginSurvey;
- (void) endSurvey;

@end
