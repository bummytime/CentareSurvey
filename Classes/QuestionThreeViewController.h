//
//  QuestionThreeViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface QuestionThreeViewController : UIViewController <QuestionViewController, AutoAdjustingOrientation> {
	RootViewController *rootViewController;
	UIButton *yesButton;
	UIButton *noButton;
}

- (IBAction)answeredYes:(id)sender;
- (IBAction)answeredNo:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;
@property (retain, nonatomic) IBOutlet UIButton *yesButton;
@property (retain, nonatomic) IBOutlet UIButton *noButton;

@end
