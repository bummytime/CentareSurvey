//
//  CentareSurveyAppDelegate.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/11/10.
//  Copyright Nerddogs, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface CentareSurveyAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

