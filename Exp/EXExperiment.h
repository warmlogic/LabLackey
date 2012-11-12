//
//  EXExperiment.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXExperimentPhase.h"
#import "EXResponse.h"
#import "EXStimulus.h"

@interface EXExperiment : NSObject

@property NSString *name;
@property UIImage *cross;
@property (readonly) EXExperimentPhase *currentPhase;
@property (readonly) BOOL isCompleted;
@property (nonatomic) NSMutableArray *experimentData;
@property (nonatomic, readonly) NSArray *images;
@property NSDate *experimentStartTime;

@property UIImage *image;

-(id)initWithName:(NSString *)name;

-(void)currentPhaseCompleted;

-(void)reset;

-(void)logResponse:(EXResponse *)response;

-(EXStimulus *)nextStimulus;

-(void)writeData;

@end
