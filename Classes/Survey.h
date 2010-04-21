//
//  Survey.h
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/21/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define    kIsCompleteKey			@"IsComplete"
#define    kNameKey					@"SurveyTakerName"
#define    kEmailKey				@"SurveyTakerEmail"
#define    kQuestion1AnswerKey		@"Question1Answer"
#define    kQuestion2AnswerKey		@"Question2Answer"
#define    kQuestion3AnswerKey		@"Question3Answer"
#define    kQuestion4AnswerKey		@"Question4Answer"
#define    kQuestion5AnswerKey		@"Question5Answer"
#define    kQuestion6AnswerKey		@"Question6Answer"

@interface Survey : NSObject <NSCoding, NSCopying> {

	BOOL		isComplete;
	NSString	*surveyTakerName;
	NSString	*surveyTakerEmail;
	NSString	*question1Answer;
	NSString	*question2Answer;
	NSString	*question3Answer;
	NSString	*question4Answer;
	NSString	*question5Answer;
	NSString	*question6Answer;
}

@property (nonatomic, assign) BOOL isComplete;
@property (nonatomic, retain) NSString *surveyTakerName;
@property (nonatomic, retain) NSString *surveyTakerEmail;
@property (nonatomic, retain) NSString *question1Answer;
@property (nonatomic, retain) NSString *question2Answer;
@property (nonatomic, retain) NSString *question3Answer;
@property (nonatomic, retain) NSString *question4Answer;
@property (nonatomic, retain) NSString *question5Answer;
@property (nonatomic, retain) NSString *question6Answer;

@end
