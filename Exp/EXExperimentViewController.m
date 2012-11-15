//
//  EXExperimentViewController.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperimentViewController.h"
#import "EXTrialData.h"

@interface EXExperimentViewController () {
    BOOL waitingForResponse;
}

@property EXTrialData *currentResponse;
@property (nonatomic) NSInteger nCompletedTrials;

@property NSDate *responseStartTime;

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
    waitingForResponse = NO;
}

-(void)startFixation {
    self.imageView.image = _experiment.cross;
    
    NSTimeInterval fixationDuration;
    if (_experiment.currentPhase.fixationJitter != 0.0) {
        // figure out the jitter time in milliseconds
        int jitterMS = arc4random_uniform((int)(_experiment.currentPhase.fixationJitter * 1000));
        // convert to seconds
        double jitterS = (double)jitterMS / 1000;
        // calculate the full fixationDuration
        fixationDuration = _experiment.currentPhase.fixationDuration + jitterS;
    }
    else {
        fixationDuration = _experiment.currentPhase.fixationDuration;
    }
    //debug
    //NSLog(@"full fixationDuration: %f",fixationDuration);
    
    [NSTimer scheduledTimerWithTimeInterval:fixationDuration target:self selector:@selector(startISI) userInfo:nil repeats:NO];
}

-(void)startISI {
    self.imageView.image = nil;
    
    NSTimeInterval interStimulusInterval;
    if (_experiment.currentPhase.interStimulusIntervalJitter != 0.0) {
        // figure out the jitter time in milliseconds
        int jitterMS = arc4random_uniform((int)(_experiment.currentPhase.interStimulusIntervalJitter * 1000));
        // convert to seconds
        double jitterS = (double)jitterMS / 1000;
        // calculate the full fixationDuration
        interStimulusInterval = _experiment.currentPhase.interStimulusInterval + jitterS;
    } else {
        interStimulusInterval = _experiment.currentPhase.interStimulusInterval;
    }
    //debug
    //NSLog(@"full interStimulusInterval: %f",interStimulusInterval);
    
    if (_nCompletedTrials < _experiment.currentPhase.nTrials) {
        [NSTimer scheduledTimerWithTimeInterval:interStimulusInterval target:self selector:@selector(presentStimulus) userInfo:nil repeats:NO];
    }
    else {
        [NSTimer scheduledTimerWithTimeInterval:interStimulusInterval target:self selector:@selector(finishPhase) userInfo:nil repeats:NO];
    }
}

-(void)presentStimulus {
    EXStimulus *stimulus = [_experiment nextStimulus];
    self.imageView.image = stimulus.image;
    _nCompletedTrials++;
    
    self.currentResponse = [[EXTrialData alloc] init];
    self.currentResponse.stimulusName = stimulus.name;
    _currentResponse.stimulusOnsetTime = [NSDate date];
    
    NSTimeInterval stimulusDuration;
    if (_experiment.currentPhase.stimulusJitter != 0.0) {
        // figure out the jitter time in milliseconds
        int jitterMS = arc4random_uniform((int)(_experiment.currentPhase.stimulusJitter * 1000));
        // convert to seconds
        double jitterS = (double)jitterMS / 1000;
        // calculate the full fixationDuration
        stimulusDuration = _experiment.currentPhase.stimulusDuration + jitterS;
    }
    else {
        stimulusDuration = _experiment.currentPhase.stimulusDuration;
    }
    //debug
    //NSLog(@"full stimulusDuration: %f",stimulusDuration);
    
    if (_experiment.currentPhase.responseRequired == YES) {
        [NSTimer scheduledTimerWithTimeInterval:stimulusDuration target:self selector:@selector(waitForResponse) userInfo:nil repeats:NO];
    }
    else  {
        [_experiment logResponse:_currentResponse];
        [NSTimer scheduledTimerWithTimeInterval:stimulusDuration target:self selector:@selector(startFixation) userInfo:nil repeats:NO];
    }
}

-(void)finishPhase {
    [_experiment currentPhaseCompleted];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(){}];
}

-(void)waitForResponse {
    waitingForResponse = YES;
    self.imageView.image = [UIImage imageNamed:@"oldnew"]; /* @"response" -> response.png or response@2x.png depending on device*/
    _responseStartTime = [NSDate date];
}

-(IBAction)handleTap:(UITapGestureRecognizer *)recognizer
{
    if (waitingForResponse) {
        CGPoint location = [recognizer locationInView:self.imageView];
        
        _currentResponse.time = [NSDate date];
        _currentResponse.location = location;
        _currentResponse.side = location.x<=self.imageView.frame.size.width/2?@"old":@"new";
        _currentResponse.reactionTime = [_currentResponse.time timeIntervalSinceDate:_responseStartTime];
        
        [self startFixation];
        waitingForResponse = NO;
        
        [_experiment logResponse:_currentResponse];
    }
}

#pragma mark - View Life Cycle

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
