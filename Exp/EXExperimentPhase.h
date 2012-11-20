//
//  EXExperimentPhase.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXExperimentPhase : NSObject

@property NSString *instructions;
@property NSInteger nTrials;
@property BOOL responseRequired;
@property NSTimeInterval fixationDuration;
@property NSTimeInterval fixationJitter;
@property NSTimeInterval interStimulusInterval;
@property NSTimeInterval interStimulusIntervalJitter;
@property NSTimeInterval stimulusDuration;
@property NSTimeInterval stimulusJitter;
@property NSArray *stimulusSet;

@property NSData *config;


//+(EXExperimentPhase *)testPhase;
//+(EXExperimentPhase *)studyPhase;
+(EXExperimentPhase *)experimentWithConfiguration:(NSDictionary *)experimentConfig forPhase:(NSString *)phaseName;

@end
