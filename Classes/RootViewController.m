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
	[self createOnlyNextButton];
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
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if (fromInterfaceOrientation == UIInterfaceOrientationPortrait ||
		fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) { 
		[questionOneViewController supportLandscape];
		[questionTwoViewController supportLandscape];
		[questionThreeViewController supportLandscape];
	} 
	if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
		fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) { 
		[questionOneViewController supportPortrait];
		[questionTwoViewController supportPortrait];
		[questionThreeViewController supportPortrait];
	}
}
																							

#pragma mark -
#pragma mark Navigation button bunk

- (void) createOnlyNextButton {
	//Remove the current UINavigationItem
	[navigationBar popNavigationItemAnimated:NO];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next Question"
																   style:UIBarButtonItemStyleBordered
																  target:self 
																  action:@selector(nextQuestion:)];
	UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Centare Group Survey"];
	item.rightBarButtonItem = nextButton;
	item.hidesBackButton = YES;
	[navigationBar pushNavigationItem:item animated:NO];
	[nextButton release];	
	[item release];
}

- (void) createOnlyPreviousButton {
	//Remove the current UINavigationItem
	[navigationBar popNavigationItemAnimated:NO];
	UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous Question"
																   style:UIBarButtonItemStyleBordered
																  target:self 
																  action:@selector(previousQuestion:)];
	UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Centare Group Survey"];
	item.leftBarButtonItem = previousButton;
	item.hidesBackButton = YES;
	[navigationBar pushNavigationItem:item animated:NO];
	[previousButton release];	
	[item release];
}

- (void) createPreviousNextButton {
	//Remove the current UINavigationItem
	[navigationBar popNavigationItemAnimated:NO];
	UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous Question"
																	   style:UIBarButtonItemStyleBordered
																	  target:self 
																	  action:@selector(previousQuestion:)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next Question"
																   style:UIBarButtonItemStyleBordered
																  target:self 
																  action:@selector(nextQuestion:)];
	UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Centare Group Survey"];
	item.leftBarButtonItem = previousButton;
	item.rightBarButtonItem = nextButton;
	item.hidesBackButton = YES;
	[navigationBar pushNavigationItem:item animated:NO];
	[previousButton release];
	[nextButton release];
	[item release];
}

#pragma mark -
#pragma mark Actions

- (IBAction)previousQuestion:(id)sender {
	//Declare animation block
	[UIView beginAnimations:@"View Flip" context:nil]; 
	[UIView setAnimationDuration:.50]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	if (self.questionOneViewController.view.superview != nil) { 
		//On #1, can't circle back to #3
	} else if (self.questionTwoViewController.view.superview != nil) { //On #2, go to #1
		if (self.questionOneViewController == nil) {
			QuestionOneViewController *q1ViewController = [[QuestionOneViewController alloc] 
															 initWithNibName:@"QuestionOneView" bundle:nil];
			self.questionOneViewController = q1ViewController;
			[q1ViewController release];
		}
		[self createOnlyNextButton];
		[questionTwoViewController viewWillAppear:YES]; 
		[questionOneViewController viewWillDisappear:YES];
		[questionTwoViewController.view removeFromSuperview];
		[self.view insertSubview:questionOneViewController.view atIndex:0];
		[questionOneViewController viewDidDisappear:YES]; 
		[questionTwoViewController viewDidAppear:YES];		
		
	} else { //On #3, go to #2
		if (self.questionTwoViewController == nil) {
			QuestionTwoViewController *q2ViewController = [[QuestionTwoViewController alloc] 
														   initWithNibName:@"QuestionTwoView" bundle:nil];
			self.questionTwoViewController = q2ViewController;
			[q2ViewController release];
		}
		[self createPreviousNextButton];
		[questionThreeViewController viewWillAppear:YES]; 
		[questionTwoViewController viewWillDisappear:YES];
		[questionThreeViewController.view removeFromSuperview];
		[self.view insertSubview:questionTwoViewController.view atIndex:0];
		[questionTwoViewController viewDidDisappear:YES]; 
		[questionThreeViewController viewDidAppear:YES];
	}
	
	[UIView commitAnimations];
}

- (IBAction)nextQuestion:(id)sender {
	//Declare animation block
	[UIView beginAnimations:@"View Flip" context:nil]; 
	[UIView setAnimationDuration:.50]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	
	if (self.questionOneViewController.view.superview != nil) { //On #1, go to #2 
		if (self.questionTwoViewController == nil) {
			QuestionTwoViewController *q2ViewController = [[QuestionTwoViewController alloc] 
														   initWithNibName:@"QuestionTwoView" bundle:nil];
			self.questionTwoViewController = q2ViewController;
			[q2ViewController release];
		}
		[self createPreviousNextButton];
		[questionOneViewController viewWillAppear:YES]; 
		[questionTwoViewController viewWillDisappear:YES];
		[questionOneViewController.view removeFromSuperview]; 
		[self.view insertSubview:questionTwoViewController.view atIndex:0]; 
		[questionTwoViewController viewDidDisappear:YES]; 
		[questionOneViewController viewDidAppear:YES];
		
	} else if (self.questionTwoViewController.view.superview != nil) { //On #2, go to #3 
		if (self.questionThreeViewController == nil) {
			QuestionThreeViewController *q3ViewController = [[QuestionThreeViewController alloc] 
														   initWithNibName:@"QuestionThreeView" bundle:nil];
			self.questionThreeViewController = q3ViewController;
			[q3ViewController release];
			
		}
		[self createOnlyPreviousButton];
		[questionTwoViewController viewWillAppear:YES]; 
		[questionThreeViewController viewWillDisappear:YES];
		[questionTwoViewController.view removeFromSuperview];
		[self.view insertSubview:questionThreeViewController.view atIndex:0];
		[questionThreeViewController viewDidDisappear:YES]; 
		[questionTwoViewController viewDidAppear:YES];
		
	} else {
		//On #3, can't circle back to #1
	}
	
	[UIView commitAnimations];
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
