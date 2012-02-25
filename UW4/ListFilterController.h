//
//  ListFilterController.h
//  UW4
//
//  Created by Andrew Thomson on 17/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListFilterController : UITableViewController
@property (copy, nonatomic) NSArray *selection;
@property (weak, nonatomic) id delegate;
@end
