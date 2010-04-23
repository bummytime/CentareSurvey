    //
//  QuestionTwoViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "QuestionTwoViewController.h"
#import "Survey.h"


@implementation QuestionTwoViewController

@synthesize rootViewController;
@synthesize androidButton;
@synthesize iPhoneButton;
@synthesize blackBerryButton;
@synthesize otherButton;

- (int)questionNumber {
	return 2;
}

- (IBAction)answeredAndroid:(id)sender {
	if (![self.rootViewController.currentSurvey.question2Answer isEqualToString:@"Android"]) {
		self.rootViewController.currentSurvey.question2Answer = @"Android";
		[androidButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[iPhoneButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[blackBerryButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[otherButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)answerediPhone:(id)sender {
	if (![self.rootViewController.currentSurvey.question2Answer isEqualToString:@"iPhone"]) {
		self.rootViewController.currentSurvey.question2Answer = @"iPhone";
		[iPhoneButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[androidButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[blackBerryButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[otherButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)answeredBlackBerry:(id)sender {	
	if (![self.rootViewController.currentSurvey.question2Answer isEqualToString:@"BlackBerry"]) {
		self.rootViewController.currentSurvey.question2Answer = @"BlackBerry";
		[blackBerryButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[androidButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[iPhoneButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[otherButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)answeredOther:(id)sender {
	if (![self.rootViewController.currentSurvey.question2Answer isEqualToString:@"Other"]) {
		self.rootViewController.currentSurvey.question2Answer = @"Other";
		[otherButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[androidButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[blackBerryButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
		[iPhoneButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
}


#pragma mark -
#pragma mark View management

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
		[self supportPortrait];
	} else {
		[self supportLandscape];
	}
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)supportPortrait {
	self.view.frame = CGRectMake(0, 0, 768, 960); 
}

- (void)supportLandscape {
	self.view.frame = CGRectMake(0, 0, 1024, 715); 
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[rootViewController release];
	[androidButton release];
	[iPhoneButton release];
	[blackBerryButton release];
	[otherButton release];
    [super dealloc];
}


@end
