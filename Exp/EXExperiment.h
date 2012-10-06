//
//  EXExperiment.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXExperiment : NSObject

@property NSString *name;
@property NSString *instructions;

-(id)initWithName:(NSString *)name;

@end
