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
#import "QuestionFourViewController.h"
#import "QuestionFiveViewController.h"
#import "QuestionSixViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "Survey.h"

@implementation RootViewController

@synthesize db;
@synthesize navigationBar;
@synthesize welcomeViewController;
@synthesize questionOneViewController;
@synthesize questionTwoViewController;
@synthesize questionThreeViewController;
@synthesize questionFourViewController;
@synthesize questionFiveViewController;
@synthesize questionSixViewController;
@synthesize currentSurvey;

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); return 123; } }

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
    
	db = [FMDatabase databaseWithPath:[self dataFilePath]];
    if (![db open]) {
        NSLog(@"Could not open db.");
		NSAssert(0, @"Error opening DB");
    }
	
	[db retain];
	
    [db setShouldCacheStatements:YES];
	NSString *createTableSQL = @"CREATE TABLE IF NOT EXISTS SURVEY (NAME TEXT,EMAIL TEXT,QUESTION1ANSWER TEXT,QUESTION2ANSWER TEXT,QUESTION3ANSWER TEXT,QUESTION4ANSWER TEXT,QUESTION5ANSWER TEXT,QUESTION6ANSWER TEXT);";
    [db executeUpdate:createTableSQL];
	[createTableSQL release];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		NSAssert(0, @"Error creating table in DB");
    }
	
	UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification 
                                               object:app];
	
	[super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)applicationWillTerminate:(NSNotification *)notification {
	[db close];
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
		[questionFourViewController supportLandscape];
		[questionFiveViewController supportLandscape];
		[questionSixViewController supportLandscape];
		[welcomeViewController supportLandscape];
	} 
	if (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || 
		fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight) { 
		[questionOneViewController supportPortrait];
		[questionTwoViewController supportPortrait];
		[questionThreeViewController supportPortrait];
		[questionFourViewController supportPortrait];
		[questionFiveViewController supportPortrait];
		[questionSixViewController supportPortrait];
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
		//On #1, can't circle back to #6
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
		
	
	}  else if (self.questionThreeViewController.view.superview != nil) { //On #3, go to #2
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
		
	}  else if (self.questionFourViewController.view.superview != nil) { //On #4, go to #3
		if (self.questionThreeViewController == nil) {
			QuestionThreeViewController *q3ViewController = [[QuestionThreeViewController alloc] 
														   initWithNibName:@"QuestionThreeView" bundle:nil];
			self.questionThreeViewController = q3ViewController;
			[q3ViewController release];
			
			// save a pointer to this controller
			self.questionThreeViewController.rootViewController = self;
		}
		[self createPreviousNextButton];
		[questionFourViewController viewWillAppear:YES]; 
		[questionThreeViewController viewWillDisappear:YES];
		[questionFourViewController.view removeFromSuperview];
		[self.view insertSubview:questionThreeViewController.view atIndex:0];
		[questionThreeViewController viewDidDisappear:YES]; 
		[questionFourViewController viewDidAppear:YES];		
		
	}  else if (self.questionFiveViewController.view.superview != nil) { //On #5, go to #4
		if (self.questionFourViewController == nil) {
			QuestionFourViewController *q4ViewController = [[QuestionFourViewController alloc] 
														   initWithNibName:@"QuestionFourView" bundle:nil];
			self.questionFourViewController = q4ViewController;
			[q4ViewController release];
			
			// save a pointer to this controller
			self.questionFourViewController.rootViewController = self;
		}
		[self createPreviousNextButton];
		[questionFiveViewController viewWillAppear:YES]; 
		[questionFourViewController viewWillDisappear:YES];
		[questionFiveViewController.view removeFromSuperview];
		[self.view insertSubview:questionFourViewController.view atIndex:0];
		[questionFourViewController viewDidDisappear:YES]; 
		[questionFiveViewController viewDidAppear:YES];		
		
	} else { //On #6, go to #5
		if (self.questionFiveViewController == nil) {
			QuestionFiveViewController *q5ViewController = [[QuestionFiveViewController alloc] 
														   initWithNibName:@"QuestionFiveView" bundle:nil];
			self.questionFiveViewController = q5ViewController;
			[q5ViewController release];
			
			// save a pointer to this controller
			self.questionFiveViewController.rootViewController = self;
		}
		[self createPreviousNextButton];
		[questionSixViewController viewWillAppear:YES]; 
		[questionFiveViewController viewWillDisappear:YES];
		[questionSixViewController.view removeFromSuperview];
		[self.view insertSubview:questionFiveViewController.view atIndex:0];
		[questionFiveViewController viewDidDisappear:YES]; 
		[questionSixViewController viewDidAppear:YES];
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
		[self createPreviousNextButton];
		[questionTwoViewController viewWillAppear:YES]; 
		[questionThreeViewController viewWillDisappear:YES];
		[questionTwoViewController.view removeFromSuperview];
		[self.view insertSubview:questionThreeViewController.view atIndex:0];
		[questionThreeViewController viewDidDisappear:YES]; 
		[questionTwoViewController viewDidAppear:YES];
		
	}  else if (self.questionThreeViewController.view.superview != nil) { //On #3, go to #4 
		if (self.questionFourViewController == nil) {
			QuestionFourViewController *q4ViewController = [[QuestionFourViewController alloc] 
															 initWithNibName:@"QuestionFourView" bundle:nil];
			self.questionFourViewController = q4ViewController;
			[q4ViewController release];
			
			// save a pointer to this controller
			self.questionFourViewController.rootViewController = self;
		}
		[self createPreviousNextButton];
		[questionThreeViewController viewWillAppear:YES]; 
		[questionFourViewController viewWillDisappear:YES];
		[questionThreeViewController.view removeFromSuperview];
		[self.view insertSubview:questionFourViewController.view atIndex:0];
		[questionFourViewController viewDidDisappear:YES]; 
		[questionThreeViewController viewDidAppear:YES];
		
	} else if (self.questionFourViewController.view.superview != nil) { //On #4, go to #5 
		if (self.questionFiveViewController == nil) {
			QuestionFiveViewController *q5ViewController = [[QuestionFiveViewController alloc] 
															 initWithNibName:@"QuestionFiveView" bundle:nil];
			self.questionFiveViewController = q5ViewController;
			[q5ViewController release];
			
			// save a pointer to this controller
			self.questionFiveViewController.rootViewController = self;
		}
		[self createPreviousNextButton];
		[questionFourViewController viewWillAppear:YES]; 
		[questionFiveViewController viewWillDisappear:YES];
		[questionFourViewController.view removeFromSuperview];
		[self.view insertSubview:questionFiveViewController.view atIndex:0];
		[questionFiveViewController viewDidDisappear:YES]; 
		[questionFourViewController viewDidAppear:YES];
		
	} else if (self.questionFiveViewController.view.superview != nil) { //On #5, go to #6 
		if (self.questionSixViewController == nil) {
			QuestionSixViewController *q6ViewController = [[QuestionSixViewController alloc] 
															 initWithNibName:@"QuestionSixView" bundle:nil];
			self.questionSixViewController = q6ViewController;
			[q6ViewController release];
			
			// save a pointer to this controller
			self.questionSixViewController.rootViewController = self;
		}
		[self createOnlyPreviousButton];
		[questionFiveViewController viewWillAppear:YES]; 
		[questionSixViewController viewWillDisappear:YES];
		[questionFiveViewController.view removeFromSuperview];
		[self.view insertSubview:questionSixViewController.view atIndex:0];
		[questionSixViewController viewDidDisappear:YES]; 
		[questionFiveViewController viewDidAppear:YES];
		[questionSixViewController.generalCommentBlock becomeFirstResponder];
		
	} else {
		//On #6, can't circle back to #1
	}
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Misc

- (void) beginSurvey {
	
	//Setup a new survey model
	currentSurvey = [[Survey alloc] init];
	//Quick HACK: Give the question with a UISlider a default answer.
	currentSurvey.question5Answer = @"5.0";
	
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

	[self saveCurrentSurvey];
	welcomeViewController.surveyParticipantName.text = @"";
	welcomeViewController.surveyParticipantEmail.text = @"";
	
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
	[questionSixViewController viewWillAppear:YES]; 
	[welcomeViewController viewWillDisappear:YES];
	[questionSixViewController.view removeFromSuperview];
	[self.view insertSubview:welcomeViewController.view atIndex:0];
	[welcomeViewController viewDidDisappear:YES]; 
	[questionSixViewController viewDidAppear:YES];		
	
	[UIView commitAnimations];
}


- (void) saveCurrentSurvey {
	
	//Save the survey in the db
	[db beginTransaction];
        [db executeUpdate:@"INSERT INTO SURVEY (NAME,EMAIL,QUESTION1ANSWER,QUESTION2ANSWER,QUESTION3ANSWER, QUESTION4ANSWER,QUESTION5ANSWER,QUESTION6ANSWER) values (?, ?, ?, ?, ?, ?, ?, ?)" ,
		 currentSurvey.surveyTakerName,
		 currentSurvey.surveyTakerEmail,
		 currentSurvey.question1Answer,
 		 currentSurvey.question2Answer,
 		 currentSurvey.question3Answer,
 		 currentSurvey.question4Answer,
 		 currentSurvey.question5Answer,
		 currentSurvey.question6Answer];
    [db commit];
	[currentSurvey release];
}


- (NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
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
	
	if (self.questionFourViewController.view.superview == nil) {
		self.questionFourViewController = nil;
	} 
	
	if (self.questionFiveViewController.view.superview == nil) {
		self.questionFiveViewController = nil;
	} 
	
	if (self.questionSixViewController.view.superview == nil) {
		self.questionSixViewController = nil;
	} 
}

- (void)dealloc {
	[navigationBar release];
	[welcomeViewController release];
	[questionOneViewController release];
	[questionTwoViewController release];
	[questionThreeViewController release];
	[questionFourViewController release];
	[questionFiveViewController release];
	[questionSixViewController release];
	[currentSurvey release];
	[db release];
    [super dealloc];
}


@end
