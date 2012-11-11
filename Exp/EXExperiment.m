//
//  EXExperiment.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperiment.h"
#import "EXExperimentPhase.h"
#import "NSArray+Utilities.h"

@interface EXExperiment () {
    NSInteger stimulusCounter;
    NSInteger numberToTransferFromStudyToTest;
}

@property NSInteger currentPhaseIndex;
@property (nonatomic, strong) NSArray *experimentPhases;
@property (nonatomic, strong) NSArray *selectedStimuli;

@end

@implementation EXExperiment

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        [self setupImagePool];
        
        _name = name;
        _cross = [UIImage imageNamed:@"cross.jpg"];
        
        numberToTransferFromStudyToTest = 2;
        
        [self reset];
    }
    return self;
}

-(void)setupImagePool {
    _images = @[[UIImage imageNamed:@"0.png"], [UIImage imageNamed:@"1.png"], [UIImage imageNamed:@"2.png"], [UIImage imageNamed:@"3.png"], [UIImage imageNamed:@"4.png"], [UIImage imageNamed:@"5.png"], [UIImage imageNamed:@"6.png"], [UIImage imageNamed:@"7.png"], [UIImage imageNamed:@"8.png"], [UIImage imageNamed:@"9.png"]];
}

-(EXExperimentPhase *) currentPhase {
    return _experimentPhases[_currentPhaseIndex];
}


-(UIImage *)nextStimulus {
    UIImage *stimulus = [[self currentPhase] stimulusSet][stimulusCounter];
    
    stimulusCounter++;
    NSLog(@"%d", stimulusCounter);
    
    return stimulus;
}

-(void)currentPhaseCompleted {
    _currentPhaseIndex++;
    stimulusCounter = 0;
}

-(BOOL)isCompleted {
    return _currentPhaseIndex >= _experimentPhases.count;
}

-(void)reset {
    
    EXExperimentPhase *study = [EXExperimentPhase studyPhase];
    EXExperimentPhase *test = [EXExperimentPhase testPhase];

    NSInteger totalNumberOfStimuliNeeded = study.nTrials + test.nTrials - numberToTransferFromStudyToTest;
    
    // filter the stimuli
    NSIndexSet *totalStimulusRange = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, totalNumberOfStimuliNeeded)];
    self.selectedStimuli = [[NSArray randomizedArrayFromArray:_images] objectsAtIndexes:totalStimulusRange];
    
    
    NSIndexSet *studyStimulusRange = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, study.nTrials)];
    NSArray *studySet = [_selectedStimuli objectsAtIndexes:studyStimulusRange];
    [study setStimulusSet: [NSArray randomizedArrayFromArray:studySet]];
    
    NSIndexSet *testStimulusRange = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(study.nTrials-numberToTransferFromStudyToTest, test.nTrials)];
    NSArray *testSet = [_selectedStimuli objectsAtIndexes:testStimulusRange];
    [test setStimulusSet:[NSArray randomizedArrayFromArray:testSet]];
    
    
    _experimentPhases = [NSArray arrayWithObjects:study, test, nil];
    _currentPhaseIndex = 0;
    
    stimulusCounter = 0;
}

-(void)logResponse:(EXResponse *)response {
    NSLog(@"%@, %@, %f, %f, %f",response.time, response.side, response.location.x, response.location.y, response.reactionTime);
    [_experimentData addObject:response];
}

-(void)writeData {
    NSString *dataToWrite = @"";
    for (EXResponse *event in _experimentData) {
        dataToWrite = [dataToWrite stringByAppendingFormat:@"%f, %@, %f, %f, %f\n",[event.time timeIntervalSince1970], event.side, event.location.x, event.location.y, event.reactionTime];
    }
}

@end
