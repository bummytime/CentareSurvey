//
//  QuestionSixViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "QuestionSixViewController.h"
#import "Survey.h"

@implementation QuestionSixViewController

@synthesize rootViewController;
@synthesize generalCommentBlock;

- (int)questionNumber {
	return 6;
}

- (IBAction)answeredQuestion:(id)sender {
	self.rootViewController.currentSurvey.question6Answer = generalCommentBlock.text;
	[self.rootViewController endSurvey];
}

#pragma mark -
#pragma mark View management

- (void)viewWillAppear:(BOOL)animated {
	generalCommentBlock.backgroundColor = [UIColor whiteColor];	
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
	[generalCommentBlock release];
	[rootViewController release];
    [super dealloc];
}




@end
