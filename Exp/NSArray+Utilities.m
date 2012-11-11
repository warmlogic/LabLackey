//
//  NSArray+Utilities.m
//  Exp
//
//  Created by Matt Mollison on 11/11/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "NSArray+Utilities.h"

@implementation NSArray (Utilities)

+(NSArray *)randomizedArrayFromArray:(NSArray *) original {
    NSMutableArray *intermediate = [NSMutableArray arrayWithArray:original];
    
    NSUInteger count = [intermediate count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [intermediate exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return [NSArray arrayWithArray:intermediate];
}

@end
