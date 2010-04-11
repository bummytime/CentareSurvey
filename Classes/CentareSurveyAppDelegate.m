//
//  CentareSurveyAppDelegate.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright Nerddogs, Inc. 2010. All rights reserved.
//

#import "CentareSurveyAppDelegate.h"
#import "RootViewController.h"

@implementation CentareSurveyAppDelegate

@synthesize window;
@synthesize rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch
	[window addSubview:rootViewController.view];
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)dealloc {
    [window release];
	[rootViewController release];
    [super dealloc];
}


@end
