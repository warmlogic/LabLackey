//
//  EXExperiment.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperiment.h"

@implementation EXExperiment

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _instructions = @"This is what is going to happen!";
    }
    return self;
}

@end
