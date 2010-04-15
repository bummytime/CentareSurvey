//
//  QuestionOneViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "QuestionOneViewController.h"


@implementation QuestionOneViewController

- (int)questionNumber {
	return 1;
}

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
	NSLog(@"current view before %@",self.view); 
	self.view.frame = CGRectMake(0, 0, 768, 960); 
	NSLog(@"current view after %@",self.view); 
}

- (void)supportLandscape {
	NSLog(@"current view before %@",self.view); 
	self.view.frame = CGRectMake(0, 0, 1024, 715); 
	NSLog(@"current view after %@",self.view); 
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [super dealloc];
}


@end
