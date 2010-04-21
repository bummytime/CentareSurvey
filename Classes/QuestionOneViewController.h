//
//  QuestionOneViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface QuestionOneViewController : UIViewController <QuestionViewController, AutoAdjustingOrientation> {
	RootViewController *rootViewController;
}

- (IBAction)answeredYes:(id)sender;
- (IBAction)answeredNo:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;

@end
