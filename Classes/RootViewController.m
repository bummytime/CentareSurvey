//
//  RootViewController.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "WelcomeViewController.h"
#import "QuestionOneViewController.h"
#import "QuestionTwoViewController.h"
#import "QuestionThreeViewController.h"


@implementation RootViewController
@synthesize navigationBar;
@synthesize welcomeViewController;
@synthesize questionOneViewController;
@synthesize questionTwoViewController;
@synthesize questionThreeViewController;


#pragma mark -
#pragma mark View management

- (void)viewDidLoad {
	WelcomeViewController *welcomeController = [[WelcomeViewController alloc]
												initWithNibName:@"Welcome" bundle:nil];
	self.welcomeViewController = welcomeController;
	[welcomeController release];
	[self.view insertSubview:welcomeViewController.view atIndex:0];
	[self clearAllButtons];
	
	// save a pointer to this controller
	self.welcomeViewController.rootViewController = self; 
    
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
		[welcomeViewController supportLandscape];
	} 
	if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
		fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) { 
		[questionOneViewController supportPortrait];
		[questionTwoViewController supportPortrait];
		[questionThreeViewController supportPortrait];
		[welcomeViewController supportPortrait];
	}
}
																							

#pragma mark -
#pragma mark Navigation bar creation

- (void) clearAllButtons {
	[navigationBar popNavigationItemAnimated:NO];
	UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Centare Group Survey"];
	item.hidesBackButton = YES;
	[navigationBar pushNavigationItem:item animated:NO];	
	[item release];
}

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

- (void) createPreviousDoneButton {
	//Remove the current UINavigationItem
	[navigationBar popNavigationItemAnimated:NO];
	UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous Question"
																	   style:UIBarButtonItemStyleBordered
																	  target:self 
																	  action:@selector(previousQuestion:)];
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																   style:UIBarButtonItemStyleDone
																  target:self 
																  action:@selector(endSurvey)];
	UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Centare Group Survey"];
	item.leftBarButtonItem = previousButton;
	item.rightBarButtonItem = doneButton;
	item.hidesBackButton = YES;
	[navigationBar pushNavigationItem:item animated:NO];
	[previousButton release];
	[doneButton release];
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
			
			// save a pointer to this controller
			self.questionOneViewController.rootViewController = self;
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
			
			// save a pointer to this controller
			self.questionTwoViewController.rootViewController = self;
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
			
			// save a pointer to this controller
			self.questionTwoViewController.rootViewController = self;
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
			
			// save a pointer to this controller
			self.questionThreeViewController.rootViewController = self;
		}
		[self createPreviousDoneButton];
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
#pragma mark Misc

- (void) beginSurvey {
	
	//Declare animation block
	[UIView beginAnimations:@"View Curl" context:nil]; 
	[UIView setAnimationDuration:.65]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	
	if (self.questionOneViewController == nil) {
		QuestionOneViewController *q1ViewController = [[QuestionOneViewController alloc] 
													   initWithNibName:@"QuestionOneView" bundle:nil];
		self.questionOneViewController = q1ViewController;
		[q1ViewController release];
		
		// save a pointer to this controller
		self.questionOneViewController.rootViewController = self;
	}
	[self createOnlyNextButton];
	[welcomeViewController viewWillAppear:YES]; 
	[questionOneViewController viewWillDisappear:YES];
	[welcomeViewController.view removeFromSuperview];
	[self.view insertSubview:questionOneViewController.view atIndex:0];
	[questionOneViewController viewDidDisappear:YES]; 
	[welcomeViewController viewDidAppear:YES];		
	
	[UIView commitAnimations];
}

- (void) endSurvey {
	//Declare animation block
	[UIView beginAnimations:@"View Curl" context:nil]; 
	[UIView setAnimationDuration:.65]; 
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	
	if (self.welcomeViewController == nil) {
		WelcomeViewController *welcomeController = [[WelcomeViewController alloc] 
													   initWithNibName:@"Welcome" bundle:nil];
		self.welcomeViewController = welcomeController;
		[welcomeController release];
		
		// save a pointer to this controller
		self.welcomeViewController.rootViewController = self;
	}
	[self clearAllButtons];
	[questionThreeViewController viewWillAppear:YES]; 
	[welcomeViewController viewWillDisappear:YES];
	[questionThreeViewController.view removeFromSuperview];
	[self.view insertSubview:welcomeViewController.view atIndex:0];
	[welcomeViewController viewDidDisappear:YES]; 
	[questionThreeViewController viewDidAppear:YES];		
	
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
	[welcomeViewController release];
	[questionOneViewController release];
	[questionTwoViewController release];
	[questionThreeViewController release];
    [super dealloc];
}


@end
