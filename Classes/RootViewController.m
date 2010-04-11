//
//  RootViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "QuestionOneViewController.h"
#import "QuestionTwoViewController.h"
#import "QuestionThreeViewController.h"


@implementation RootViewController
@synthesize navigationBar;
@synthesize questionOneViewController;
@synthesize questionTwoViewController;
@synthesize questionThreeViewController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (IBAction)previousQuestion:(id)sender {
	//TODO: view switching logic
}

- (IBAction)nextQuestion:(id)sender {
	//TODO: view switching logic	
}

- (void)viewDidLoad {
	QuestionOneViewController *q1Controller = [[QuestionOneViewController alloc]
											   initWithNibName:@"QuestionOneView" bundle:nil];
	self.questionOneViewController = q1Controller;
	[self.view insertSubview:q1Controller.view atIndex:0];
	[q1Controller release];
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	if (self.questionOneViewController.view.superview == nil) {
		self.questionOneViewController = nil;
	} else if (self.questionTwoViewController.view.superview == nil) {
		self.questionTwoViewController = nil;
	} else {
		self.questionThreeViewController = nil;
	} 
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[navigationBar release];
	[questionOneViewController release];
	[questionTwoViewController release];
	[questionThreeViewController release];
    [super dealloc];
}


@end
