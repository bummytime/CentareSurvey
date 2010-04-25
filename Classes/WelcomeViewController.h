//
//  WelcomeViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/15/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>
#import "RootViewController.h"

#define kAdminPassword    @"edvskevin"

@interface WelcomeViewController : UIViewController <AutoAdjustingOrientation, 
									UITextFieldDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>{
	UITextField *surveyParticipantName;
	UITextField	*surveyParticipantEmail;
	RootViewController *rootViewController;
	UITextField *textfieldAdminPassword;
}

- (IBAction)startSurvey:(id)sender;
- (IBAction)launchAdminStuff:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;
@property (retain, nonatomic) IBOutlet UITextField *surveyParticipantName;
@property (retain, nonatomic) IBOutlet UITextField *surveyParticipantEmail;

@end
