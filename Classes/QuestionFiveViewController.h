//
//  QuestionFiveViewController.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface QuestionFiveViewController : UIViewController <QuestionViewController, AutoAdjustingOrientation> {
	RootViewController *rootViewController;
	UISlider *slidy;
}

- (IBAction)answeredQuestion:(id)sender;

@property (retain, nonatomic) IBOutlet RootViewController *rootViewController;
@property (retain, nonatomic) IBOutlet UISlider *slidy;

@end
