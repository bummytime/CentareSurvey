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


#pragma mark -
#pragma mark View management

- (void)viewDidLoad {
	QuestionOneViewController *q1Controller = [[QuestionOneViewController alloc]
											   initWithNibName:@"QuestionOneView" bundle:nil];
	self.questionOneViewController = q1Controller;
	[self.view insertSubview:q1Controller.view atIndex:0];
	[q1Controller release];
    [super viewDidLoad];
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

#pragma mark -
#pragma mark Actions

- (IBAction)previousQuestion:(id)sender {
	if (self.questionOneViewController.view.superview != nil) { //On #1, go to #3
		if (self.questionThreeViewController == nil) {
			QuestionThreeViewController *q3ViewController = [[QuestionThreeViewController alloc] 
														   initWithNibName:@"QuestionThreeView" bundle:nil];
			self.questionThreeViewController = q3ViewController;
			[q3ViewController release];
		}
		[questionOneViewController.view removeFromSuperview];
		[self.view insertSubview:questionThreeViewController.view atIndex:0];
		
	} else if (self.questionTwoViewController.view.superview != nil) { //On #2, go to #1
		if (self.questionOneViewController == nil) {
			QuestionOneViewController *q1ViewController = [[QuestionOneViewController alloc] 
															 initWithNibName:@"QuestionOneView" bundle:nil];
			self.questionOneViewController = q1ViewController;
			[q1ViewController release];
		}
		[questionTwoViewController.view removeFromSuperview];
		[self.view insertSubview:questionOneViewController.view atIndex:0];
		
	} else { //On #3, go to #2
		if (self.questionTwoViewController == nil) {
			QuestionTwoViewController *q2ViewController = [[QuestionTwoViewController alloc] 
														   initWithNibName:@"QuestionTwoView" bundle:nil];
			self.questionTwoViewController = q2ViewController;
			[q2ViewController release];
		}
		[questionThreeViewController.view removeFromSuperview];
		[self.view insertSubview:questionTwoViewController.view atIndex:0];		
	}
}

- (IBAction)nextQuestion:(id)sender {
	if (self.questionOneViewController.view.superview != nil) { //On #1, go to #2 
		if (self.questionTwoViewController == nil) {
			QuestionTwoViewController *q2ViewController = [[QuestionTwoViewController alloc] 
														   initWithNibName:@"QuestionTwoView" bundle:nil];
			self.questionTwoViewController = q2ViewController;
			[q2ViewController release];
		}
		[questionOneViewController.view removeFromSuperview];
		[self.view insertSubview:questionTwoViewController.view atIndex:0];
		
	} else if (self.questionTwoViewController.view.superview != nil) { //On #2, go to #3 
		if (self.questionThreeViewController == nil) {
			QuestionThreeViewController *q3ViewController = [[QuestionThreeViewController alloc] 
														   initWithNibName:@"QuestionThreeView" bundle:nil];
			self.questionThreeViewController = q3ViewController;
			[q3ViewController release];
		}
		[questionTwoViewController.view removeFromSuperview];
		[self.view insertSubview:questionThreeViewController.view atIndex:0];
		
	} else { //On #3, go back to #1
		if (self.questionOneViewController == nil) {
			QuestionOneViewController *q1ViewController = [[QuestionOneViewController alloc] 
														   initWithNibName:@"QuestionOneView" bundle:nil];
			self.questionOneViewController = q1ViewController;
			[q1ViewController release];
		}
		[questionThreeViewController.view removeFromSuperview];
		[self.view insertSubview:questionOneViewController.view atIndex:0];
		
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	if (self.questionOneViewController.view.superview == nil) {
		self.questionOneViewController = nil;
	} 
	
	if (self.questionTwoViewController.view.superview == nil) {
		self.questionTwoViewController = nil;
	} 
	
	if (self.questionThreeViewController.view.superview == nil) {
		self.questionThreeViewController = nil;
	} 
}

- (void)dealloc {
	[navigationBar release];
	[questionOneViewController release];
	[questionTwoViewController release];
	[questionThreeViewController release];
    [super dealloc];
}


@end
