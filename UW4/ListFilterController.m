//
//  ListFilterController.m
//  UW4
//
//  Created by Andrew Thomson on 17/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListFilterController.h"
#import "Products.h"

@implementation ListFilterController

NSArray *potentialOptions;

@synthesize selection;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Store the current name of the filter and update navigation title
    NSString *filterName = [selection valueForKey:@"object"];
    self.title = filterName;
    
    // Create a local copy of the filters. However, remove the current filter from the collection of filters are we are going to change it
    NSMutableArray *localFilters = [[NSMutableArray alloc] initWithArray:filters copyItems:YES];
    NSUInteger index = 0;
    for (NSMutableArray *localFilter in localFilters) {
        if ([[localFilter valueForKey:@"Name"] isEqualToString:filterName]){
            index = [localFilters indexOfObject:localFilter];
            break;
        }
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[localFilters objectAtIndex:index]];
    [dict setObject:@"All" forKey:@"Value"];
    [localFilters replaceObjectAtIndex:index withObject:dict];

    // Apply local filter and then retrieve and store potential options
    NSArray *filteredProducts = [Products applyFilters:allProducts :localFilters];
    potentialOptions = [[Products getUniqueValuesForKey:[dict valueForKey:@"Accessor"] :filteredProducts] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [potentialOptions count] + 1; // remember 'ALL' 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"other";
    NSInteger tag = 2;
    
    if (indexPath.row == 0) { 
        tag = 1;
        CellIdentifier = @"all"; 
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:tag];
    if (indexPath.row == 0){ titleLabel.text = @"All"; }
    else { 
        NSUInteger i = indexPath.row - 1;
        titleLabel.text = (NSString *)[potentialOptions objectAtIndex:i]; 
    }
    
    for (NSArray *f in filters) {
        if ([[f valueForKey:@"Name"] isEqualToString:self.title]){
            if ([[f valueForKey:@"Value"] isEqualToString:titleLabel.text]){
               cell.accessoryType = UITableViewCellAccessoryCheckmark; 
            }
            else {
               cell.accessoryType = UITableViewCellAccessoryNone; 
            }
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    NSUInteger index = 0;
    for (NSMutableArray *filter in filters) {
        if ([[filter valueForKey:@"Name"] isEqualToString:self.title]){
            index = [filters indexOfObject:filter];
            break;
        }
    }
       
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[filters objectAtIndex:index]];
    [dict setObject:text forKey:@"Value"];
    [filters replaceObjectAtIndex:index withObject:dict];
    
    [tableView reloadData];
}

@end
