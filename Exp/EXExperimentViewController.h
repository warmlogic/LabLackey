//
//  EXExperimentViewController.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EXExperiment.h"

@interface EXExperimentViewController : UIViewController <UIGestureRecognizerDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) EXExperiment *experiment;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(IBAction)handleTap:(id)sender;

@end
