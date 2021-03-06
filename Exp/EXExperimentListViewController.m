//
//  EXExperimentListViewController.m
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import "EXExperimentListViewController.h"

#import "EXExperimentViewController.h"

#import "EXExperiment.h"

@interface EXExperimentListViewController () {
    NSArray *_experiments;
}
@end

@implementation EXExperimentListViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)loadConfiguration
{
    // configuration file "config.json" is installed using iTunes File Sharing, in the app's Documents directory.
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [@"config" stringByAppendingPathExtension:@"json"];
    NSString *configFile = [directory stringByAppendingPathComponent:fileName];
    // debug
    //NSLog(@"configFile should be located at: %@",configFile);
    
    NSData *config;
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL success = [manager fileExistsAtPath:configFile];
    if (success) {
        // debug
        //NSLog(@"Config file successfully found at: %@",configFile);
        config = [NSData dataWithContentsOfFile:configFile];
    }
    else {
        // if we don't find the user-supplied config file in the Documents directory
        NSLog(@"Config file not found at: %@",configFile);
        
        // use the one included in the app bundle so we can compile and run
        configFile = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
        NSLog(@"Using default config file: %@",configFile);
        config = [NSData dataWithContentsOfFile:configFile];
    }
    
    // turn the entire config file into data we can read
    NSError *error = nil;
    NSArray *experimentArray = [NSJSONSerialization JSONObjectWithData:config options:0 error:&error];
    
    NSMutableArray *temporaryExperimentArray = [NSMutableArray array];
    
    for (NSDictionary *experimentDescription in experimentArray) {        
        [temporaryExperimentArray addObject:[EXExperiment experimentFromDictionaryDescription:experimentDescription]];
    }

    _experiments = [NSArray arrayWithArray:temporaryExperimentArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadConfiguration];
    
    self.detailViewController = (EXExperimentViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // hardcoded
    self.title = @"Experiments";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _experiments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    EXExperiment *experiment = _experiments[indexPath.row];
    cell.textLabel.text = experiment.name;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        EXExperiment *experiment = _experiments[indexPath.row];
//        self.detailViewController.experiment = experiment;
//    }
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showInstructions"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EXExperiment *experiment = _experiments[indexPath.row];
        
        // create the array to hold data about the entire experiment
        experiment.experimentData = [NSMutableArray arrayWithCapacity:10];
        
        experiment.experimentStartTime = [NSDate date];
        
        // debug
        //NSLog(@"experimentData: %@", experiment.experimentData);
        NSLog(@"Experiment chosen: %@", experiment.name);
        
        [[segue destinationViewController] setExperiment:experiment];
    }
}

@end
