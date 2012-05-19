//
//  SearchTableViewController.h
//  UW4
//
//  Created by Andrew Thomson on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainFilterController : UITableViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
- (IBAction)resetButton:(id)sender;
@end
