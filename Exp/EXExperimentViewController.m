//
//  EXExperimentViewController.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperimentViewController.h"

@interface EXExperimentViewController ()

@property (nonatomic) NSInteger nCompletedTrials;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation EXExperimentViewController

#pragma mark - Managing the detail item

- (void)setExperiment:(EXExperiment *)experiment
{
    if (_experiment != experiment) {
        _experiment = experiment;
        _nCompletedTrials = 0;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.experiment) {
        self.imageView.image = _experiment.cross;
    }
}

-(void)startExperiment {
    [self startFixation];
}

-(void)startFixation {
    self.imageView.image = _experiment.cross;
    
    [NSTimer scheduledTimerWithTimeInterval:_experiment.currentPhase.fixationDuration target:self selector:@selector(startISI) userInfo:nil repeats:NO];
}

-(void)startISI {
    self.imageView.image = nil;
    
    if (_nCompletedTrials < _experiment.currentPhase.nTrials) {
        [NSTimer scheduledTimerWithTimeInterval:_experiment.currentPhase.interStimulusInterval target:self selector:@selector(presentStimulus) userInfo:nil repeats:NO];
    } else {
        [NSTimer scheduledTimerWithTimeInterval:_experiment.currentPhase.interStimulusInterval target:self selector:@selector(finishPhase) userInfo:nil repeats:NO];
    }
}

-(void)presentStimulus {
    self.imageView.image = _experiment.image;
    _nCompletedTrials++;
    [NSTimer scheduledTimerWithTimeInterval:_experiment.currentPhase.stimulusDuration target:self selector:@selector(startFixation) userInfo:nil repeats:NO];
}

-(void)finishPhase {
    [_experiment currentPhaseCompleted];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){}];
}

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [self startExperiment];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void) viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
