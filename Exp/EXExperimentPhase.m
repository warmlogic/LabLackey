//
//  EXExperimentPhase.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperimentPhase.h"

@implementation EXExperimentPhase

-(id)init {
    self = [super init];
    if (self) {
        //hardcoded defaults
        _instructions = @"This is what is going to happen during the study!";
        _fixationDuration = 0.5; /* Seconds */
        _fixationJitter = 0.0; /* Seconds */
        _interStimulusInterval = 0.5; /* Seconds */
        _interStimulusIntervalJitter = 0.0; /* Seconds */
        _stimulusDuration = 1.0; /* Seconds */
        _stimulusJitter = 0.0; /* Seconds */
        _nTrials = 4;
    }
    return self;
}

+(EXExperimentPhase *)studyPhase {
    EXExperimentPhase *phase = [[EXExperimentPhase alloc] init];
    phase.instructions = @"Study phase instructions:\n\nRemember the folloiwng list of items.";
    phase.responseRequired = NO;
    phase.nTrials = 5;
    phase.fixationJitter = 0.0;
    phase.interStimulusIntervalJitter = 0.5;
    phase.stimulusJitter = 0.0;
    return phase;
}

+(EXExperimentPhase *)testPhase {
    EXExperimentPhase *phase = [[EXExperimentPhase alloc] init];
    phase.instructions = @"Test phase instructions:\n\nDecide whether each upcoming item is\nOld: was on the prior list, or\nNew: was not on the prior list.";
    phase.responseRequired = YES;
    phase.nTrials = 10;
    phase.fixationJitter = 0.0;
    phase.interStimulusIntervalJitter = 0.5;
    phase.stimulusJitter = 0.0;
    return phase;
}

//+(EXExperimentPhase *)experimentWithConfiguration:(NSDictionary *)config {
//    EXExperimentPhase *phase = [[EXExperimentPhase alloc] init];
//    
//    // Set up object from dictionary
//    phase.instructions = [config objectForKey:@"instructions"];
//    
//    return phase;
//}

@end
