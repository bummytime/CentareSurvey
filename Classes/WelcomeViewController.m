    //
//  WelcomeViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/15/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Survey.h"

@implementation WelcomeViewController

@synthesize rootViewController;
@synthesize surveyParticipantName;
@synthesize surveyParticipantEmail;

#pragma mark -
#pragma mark View management

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
#pragma mark Actions

- (IBAction)startSurvey:(id)sender {
	[self.rootViewController beginSurvey];
	self.rootViewController.currentSurvey.surveyTakerName = surveyParticipantName.text;
	self.rootViewController.currentSurvey.surveyTakerEmail = surveyParticipantEmail.text;	
}

- (IBAction)launchAdminStuff:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Admin Button Pressed" message:@"You pressed the admin icon!" delegate:nil cancelButtonTitle:@"Yep, I did." otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[surveyParticipantName release];
	[surveyParticipantEmail release];
	[rootViewController release];
    [super dealloc];
}


@end
