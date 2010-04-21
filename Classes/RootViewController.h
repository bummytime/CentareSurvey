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
@class QuestionFourViewController;
@class QuestionFiveViewController;
@class QuestionSixViewController;
@class WelcomeViewController;
@class FMDatabase;
@class Survey;


@protocol QuestionViewController
	- (int)questionNumber;
@end

@protocol AutoAdjustingOrientation
	- (void)supportPortrait;
	- (void)supportLandscape;
@end

#define kFilename    @"centaresurveydata.sqlite3"

@interface RootViewController : UIViewController {
	FMDatabase *db;
	UINavigationBar *navigationBar;
	WelcomeViewController *welcomeViewController;
	QuestionOneViewController *questionOneViewController;
	QuestionTwoViewController *questionTwoViewController;
	QuestionThreeViewController *questionThreeViewController;
	QuestionFourViewController *questionFourViewController;
	QuestionFiveViewController *questionFiveViewController;
	QuestionSixViewController *questionSixViewController;
	Survey *currentSurvey;
}

@property (retain, nonatomic) FMDatabase *db;
@property (retain, nonatomic) WelcomeViewController *welcomeViewController;
@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) QuestionOneViewController *questionOneViewController;
@property (retain, nonatomic) QuestionTwoViewController *questionTwoViewController;
@property (retain, nonatomic) QuestionThreeViewController *questionThreeViewController;
@property (retain, nonatomic) QuestionFourViewController *questionFourViewController;
@property (retain, nonatomic) QuestionFiveViewController *questionFiveViewController;
@property (retain, nonatomic) QuestionSixViewController *questionSixViewController;
@property (retain, nonatomic) Survey *currentSurvey;


- (IBAction)previousQuestion:(id)sender;
- (IBAction)nextQuestion:(id)sender;
- (void) clearAllButtons;
- (void) createOnlyPreviousButton;
- (void) createOnlyNextButton;
- (void) createPreviousNextButton;
- (void) beginSurvey;
- (void) endSurvey;
- (void) saveCurrentSurvey;
- (NSString *)dataFilePath;

@end
