//
//  WelcomeViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/15/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface WelcomeViewController : UIViewController <AutoAdjustingOrientation>{
	UITextField *surveyParticipantName;
	UITextField	*surveyParticipantEmail;
	RootViewController *rootViewController;
}

- (IBAction)startSurvey:(id)sender;
- (IBAction)launchAdminStuff:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;
@property (retain, nonatomic) IBOutlet UITextField *surveyParticipantName;
@property (retain, nonatomic) IBOutlet UITextField *surveyParticipantEmail;

@end
