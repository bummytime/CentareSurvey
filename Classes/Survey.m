//
//  Survey.m
//  CentareSurvey
//
//  Created by Matthew Bumgardner on 4/21/10.
//  Copyright 2010 Nerddogs, Inc. All rights reserved.
//

#import "Survey.h"


@implementation Survey

@synthesize isComplete;
@synthesize surveyTakerName;
@synthesize surveyTakerEmail;
@synthesize question1Answer;
@synthesize question2Answer;
@synthesize question3Answer;
@synthesize question4Answer;
@synthesize question5Answer;
@synthesize question6Answer;


#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeBool:isComplete forKey:kIsCompleteKey];
    [encoder encodeObject:surveyTakerName forKey:kNameKey];
	[encoder encodeObject:surveyTakerEmail forKey:kEmailKey];
    [encoder encodeObject:question1Answer forKey:kQuestion1AnswerKey];
	[encoder encodeObject:question2Answer forKey:kQuestion2AnswerKey];
	[encoder encodeObject:question3Answer forKey:kQuestion3AnswerKey];
	[encoder encodeObject:question4Answer forKey:kQuestion4AnswerKey];
	[encoder encodeObject:question5Answer forKey:kQuestion5AnswerKey];
	[encoder encodeObject:question6Answer forKey:kQuestion6AnswerKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.isComplete = [decoder decodeBoolForKey:kIsCompleteKey];
        self.surveyTakerName = [decoder decodeObjectForKey:kNameKey];
        self.surveyTakerEmail = [decoder decodeObjectForKey:kEmailKey];
        self.question1Answer = [decoder decodeObjectForKey:kQuestion1AnswerKey];
		self.question2Answer = [decoder decodeObjectForKey:kQuestion2AnswerKey];
		self.question3Answer = [decoder decodeObjectForKey:kQuestion3AnswerKey];
		self.question4Answer = [decoder decodeObjectForKey:kQuestion4AnswerKey];
		self.question5Answer = [decoder decodeObjectForKey:kQuestion5AnswerKey];
		self.question6Answer = [decoder decodeObjectForKey:kQuestion6AnswerKey];
    }
    return self;
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Survey *copy = [[[self class] allocWithZone: zone] init];
    copy.isComplete = self.isComplete;
	copy.surveyTakerName = [[self.surveyTakerName copyWithZone:zone] autorelease];
    copy.surveyTakerEmail = [[self.surveyTakerEmail	copyWithZone:zone] autorelease];
    copy.question1Answer = [[self.question1Answer copyWithZone:zone] autorelease];
    copy.question2Answer = [[self.question2Answer copyWithZone:zone] autorelease];
	copy.question3Answer = [[self.question3Answer copyWithZone:zone] autorelease];
	copy.question4Answer = [[self.question4Answer copyWithZone:zone] autorelease];
	copy.question5Answer = [[self.question5Answer copyWithZone:zone] autorelease];
	copy.question6Answer = [[self.question6Answer copyWithZone:zone] autorelease];
    return copy;
}



@end
