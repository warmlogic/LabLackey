//
//  EXResponse.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXResponse : NSObject

@property CGPoint location;
@property NSString *side;
@property NSDate *time;
@property NSTimeInterval reactionTime;
@property NSString *stimulusName;
@property NSDate *stimulusOnsetTime;

@end
