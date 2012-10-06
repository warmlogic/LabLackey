//
//  EXMasterViewController.h
//  Exp
//
//  Created by Matt Mollison on 10/6/12.
//  Copyright (c) 2012 Matt Mollison. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EXDetailViewController;

@interface EXMasterViewController : UITableViewController

@property (strong, nonatomic) EXDetailViewController *detailViewController;

@end
