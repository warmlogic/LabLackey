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
@property NSTimeInterval fixationDuration;
@property NSTimeInterval interStimulusInterval;
@property NSTimeInterval stimulusDuration;
@property NSInteger nTrials;

+(EXExperimentPhase *)testPhase;
+(EXExperimentPhase *)studyPhase;

@end
