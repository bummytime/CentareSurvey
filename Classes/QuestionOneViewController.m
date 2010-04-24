//
//  QuestionOneViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "QuestionOneViewController.h"
#import "Survey.h"

@implementation QuestionOneViewController

@synthesize rootViewController;
@synthesize yesButton;
@synthesize noButton;

- (int)questionNumber {
	return 1;
}

- (IBAction)answeredYes:(id)sender {
	if (![self.rootViewController.currentSurvey.question1Answer isEqualToString:@"Yes"]) {
		self.rootViewController.currentSurvey.question1Answer = @"Yes";
		[yesButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[noButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
	[self.rootViewController nextQuestion:self];
}

- (IBAction)answeredNo:(id)sender {
	if (![self.rootViewController.currentSurvey.question1Answer isEqualToString:@"No"]) {
		self.rootViewController.currentSurvey.question1Answer = @"No";
		[noButton setBackgroundImage:[UIImage imageNamed:@"purple_button_overlay.png"] forState:UIControlStateNormal];
		[yesButton setBackgroundImage:[UIImage imageNamed:@"transparent_button_overlay.png"] forState:UIControlStateNormal];
	}
	[self.rootViewController nextQuestion:self];
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
	[yesButton release];
	[noButton release];
    [super dealloc];
}


@end
