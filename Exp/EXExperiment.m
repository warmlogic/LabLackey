//
//  EXExperiment.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperiment.h"
#import "EXExperimentPhase.h"

@interface EXExperiment ()

@property NSInteger currentPhaseIndex;
@property (nonatomic, strong) NSArray *experimentPhases;

@end

@implementation EXExperiment

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _cross = [UIImage imageNamed:@"cross.jpg"];
        _image = [UIImage imageNamed:@"Goats.JPG"];
            
        EXExperimentPhase *study = [EXExperimentPhase studyPhase];
        EXExperimentPhase *test = [EXExperimentPhase testPhase];
        
        _experimentPhases = [NSArray arrayWithObjects:test, study, nil];
        _currentPhaseIndex = 0;
    }
    return self;
}

-(EXExperimentPhase *) currentPhase {
    return _experimentPhases[_currentPhaseIndex];
}

-(void)currentPhaseCompleted {
    _currentPhaseIndex++;
}

-(BOOL)isCompleted {
    return _currentPhaseIndex >= _experimentPhases.count;
}

-(void)reset {
    _currentPhaseIndex = 0;
}

@end
