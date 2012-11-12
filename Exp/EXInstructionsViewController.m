//
//  EXInstructionsViewController.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXInstructionsViewController.h"

@interface EXInstructionsViewController ()

@end

@implementation EXInstructionsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
 
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = _experiment.name;
    
    if (!_experiment.isCompleted) {
        _instructionsView.text = _experiment.currentPhase.instructions;
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [_experiment writeData];
        [_experiment reset];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showExperiment"]) {
        [[segue destinationViewController] setExperiment:_experiment];
    }
}

@end
