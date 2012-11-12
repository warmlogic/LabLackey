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
#import "EXStimulus.h"

@interface EXExperiment () {
    NSInteger stimulusCounter;
    NSInteger numberToTransferFromStudyToTest;
}

@property NSInteger currentPhaseIndex;
@property (nonatomic, strong) NSArray *experimentPhases;
@property (nonatomic, strong) NSArray *stimuli;
@property (nonatomic, strong) NSArray *selectedStimuli;

@end

@implementation EXExperiment

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        [self setupImagePool];
        
        _name = name;
        _cross = [UIImage imageNamed:@"cross.jpg"];
        
        numberToTransferFromStudyToTest = 5;
        
        [self reset];
    }
    return self;
}

-(void)setupImagePool {
    //hardcoded stimuli
    _images = @[[UIImage imageNamed:@"0.png"], [UIImage imageNamed:@"1.png"], [UIImage imageNamed:@"2.png"], [UIImage imageNamed:@"3.png"], [UIImage imageNamed:@"4.png"], [UIImage imageNamed:@"5.png"], [UIImage imageNamed:@"6.png"], [UIImage imageNamed:@"7.png"], [UIImage imageNamed:@"8.png"], [UIImage imageNamed:@"9.png"]];

    NSMutableArray *tempStimuli = [NSMutableArray arrayWithCapacity:_images.count];
    EXStimulus *s;
    for (int i=0; i<_images.count; i++) {
        s = [[EXStimulus alloc] init];
        s.image = _images[i];
        s.name = [NSString stringWithFormat:@"%d",i];
        [tempStimuli addObject:s];
    }
    self.stimuli = tempStimuli;
}

-(EXExperimentPhase *) currentPhase {
    return _experimentPhases[_currentPhaseIndex];
}

-(EXStimulus *)nextStimulus {
    EXStimulus *stimulus = [[self currentPhase] stimulusSet][stimulusCounter];
    
    stimulusCounter++;
    // debug
    //NSLog(@"%d", stimulusCounter);
    
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
    self.selectedStimuli = [[NSArray randomizedArrayFromArray:self.stimuli] objectsAtIndexes:totalStimulusRange];
    
    
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

-(void)logResponse:(EXTrialData *)response {
    //debug
    NSLog(@"%@, %@, %@, %f, %f, %f",response.time, response.stimulusName, response.side, response.location.x, response.location.y, response.reactionTime);
    [_experimentData addObject:response];
}

-(void)writeData {
    NSString *dataToWrite = @"";
    for (EXTrialData *event in _experimentData) {
        dataToWrite = [dataToWrite stringByAppendingFormat:@"%f, %@, %f, %@, %f, %f, %f\n",
                       [event.stimulusOnsetTime timeIntervalSince1970],event.stimulusName,[event.time timeIntervalSince1970], event.side, event.location.x, event.location.y, event.reactionTime];
    }
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    directory = [directory stringByAppendingPathComponent:self.name];
    NSString *fileName = [_experimentStartTime.description stringByAppendingPathExtension:@"csv"];
    NSString *saveFile = [directory stringByAppendingPathComponent:fileName];
    //debug
    //NSLog(@"File to save: %@",saveFile);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL success = [manager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    if (success)
    {
        // debug
        //NSLog(@"Output directory successfully set to: %@",directory);
        [dataToWrite writeToFile:saveFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

@end
