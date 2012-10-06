//
//  EXExperiment.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXExperimentPhase.h"

@interface EXExperiment : NSObject

@property NSString *name;
@property UIImage *cross;
@property (readonly) EXExperimentPhase *currentPhase;

@property UIImage *image;

-(id)initWithName:(NSString *)name;

-(void)currentPhaseCompleted;

@end
