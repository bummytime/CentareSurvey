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
#pragma mark Actions and Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	if(theTextField == surveyParticipantEmail)
		[self startSurvey:nil];
	else
		[surveyParticipantEmail becomeFirstResponder];

	return YES;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		NSLog(@"Email Sent.");
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)startSurvey:(id)sender {
	if ([surveyParticipantName.text length] > 0 &&
			[surveyParticipantEmail.text length] > 0) {
		[self.rootViewController beginSurvey];
		self.rootViewController.currentSurvey.surveyTakerName = surveyParticipantName.text;
		self.rootViewController.currentSurvey.surveyTakerEmail = surveyParticipantEmail.text;	
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Please enter both a name and email address to begin the survey." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction)launchAdminStuff:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Administration" message:@"Please enter your password." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
	//Not public API...so sue me.
	[alert addTextFieldWithValue:@"" label:@"Password"];
	textfieldAdminPassword = [alert textFieldAtIndex:0];
	textfieldAdminPassword.secureTextEntry = YES;
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1 &&
		[textfieldAdminPassword.text isEqualToString:kAdminPassword] &&
		[MFMailComposeViewController canSendMail]) {
		
		//Let's just send an email with the SQLite DB attached
		NSData *attachedDb = [NSData dataWithContentsOfFile:[rootViewController dataFilePath]];
		
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:@"Centare Survey iPad app results DB"];
		[controller setMessageBody:@"SQLite database is attached." isHTML:NO]; 
		[controller addAttachmentData:attachedDb mimeType:@"application/octet-stream" fileName:@"surveyresults.db"];
		[self presentModalViewController:controller animated:YES];
		[controller release];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[textfieldAdminPassword release];
	[surveyParticipantName release];
	[surveyParticipantEmail release];
	[rootViewController release];
    [super dealloc];
}


@end
