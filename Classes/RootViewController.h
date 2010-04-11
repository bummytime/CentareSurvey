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

/*
 SubstitutableDetailViewController defines the protocol that detail view controllers must adopt. The protocol specifies methods to hide and show the bar button item controlling the popover.
 
 */
@protocol QuestionViewController
	- (int)questionNumber;
@end

@interface RootViewController : UIViewController {
	UINavigationBar *navigationBar;
	QuestionOneViewController *questionOneViewController;
	QuestionTwoViewController *questionTwoViewController;
	QuestionThreeViewController *questionThreeViewController;
}

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (retain, nonatomic) QuestionOneViewController *questionOneViewController;
@property (retain, nonatomic) QuestionTwoViewController *questionTwoViewController;
@property (retain, nonatomic) QuestionThreeViewController *questionThreeViewController;

- (IBAction)previousQuestion:(id)sender;
- (IBAction)nextQuestion:(id)sender;

@end
