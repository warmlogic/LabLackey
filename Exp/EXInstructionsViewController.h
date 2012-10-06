//
//  EXInstructionsViewController.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXExperiment.h"

@interface EXInstructionsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *instructionsView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property EXExperiment *experiment;

@end
