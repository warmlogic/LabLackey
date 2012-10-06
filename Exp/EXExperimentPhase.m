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
        _instructions = @"This is what is going to happen during the study!";
        _fixationDuration = 0.5; /* Seconds */
        _interStimulusInterval = 0.5; /* Seconds */
        _stimulusDuration = 1; /* Seconds */
        _nTrials = 2;
    }
    return self;
}

+(EXExperimentPhase *)testPhase {
    EXExperimentPhase *phase = [[EXExperimentPhase alloc] init];
    phase.instructions = @"The instructions for the testing phase,";
    return phase;
}

+(EXExperimentPhase *)studyPhase {
    EXExperimentPhase *phase = [[EXExperimentPhase alloc] init];
    phase.instructions = @"The instructions for the study phase,";
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
