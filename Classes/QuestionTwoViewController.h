//
//  QuestionTwoViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface QuestionTwoViewController : UIViewController <QuestionViewController, AutoAdjustingOrientation> {
	RootViewController *rootViewController;
	UIButton *androidButton;
	UIButton *iPhoneButton;
	UIButton *blackBerryButton;
	UIButton *otherButton;
}

- (IBAction)answeredAndroid:(id)sender;
- (IBAction)answerediPhone:(id)sender;
- (IBAction)answeredBlackBerry:(id)sender;
- (IBAction)answeredOther:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;
@property (retain, nonatomic) IBOutlet UIButton *androidButton;
@property (retain, nonatomic) IBOutlet UIButton *iPhoneButton;
@property (retain, nonatomic) IBOutlet UIButton *blackBerryButton;
@property (retain, nonatomic) IBOutlet UIButton *otherButton;

@end
