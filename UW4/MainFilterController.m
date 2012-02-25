//
//  SearchTableViewController.m
//  UW4
//
//  Created by Andrew Thomson on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainFilterController.h"
#import "Products.h"
#import "ProductDetailsController.h"

NSMutableArray *scannedProduct;

@implementation MainFilterController

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
    allProducts = [Products importData:@"data"];
    filters = [[NSMutableArray alloc] initWithArray:[Products importData:@"filter"] copyItems:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO; 
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    
    if ([destination respondsToSelector:@selector(setDelegate:)]){
        [destination setValue:self forKey:@"delegate"];
    }
    
    if ([destination respondsToSelector:@selector(setSelection:)]) {
        
        if ([[segue identifier] isEqualToString:@"scanned"]){
            id object = scannedProduct;
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                       object, @"object",
                                       nil];
            [destination setValue:selection forKey:@"selection"];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            id object = [[filters objectAtIndex:indexPath.row] valueForKey:@"Name"];
            NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                       indexPath, @"indexPath",
                                       object, @"object",
                                       nil];
            [destination setValue:selection forKey:@"selection"];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
    
    if (section == 0) {
        return @"Product Filters";
    }
    
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) { 
        return [filters count];
    }
    
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0){
        filters = [[NSMutableArray alloc] initWithArray:[Products importData:@"filter"] copyItems:YES];
        
        ZBarReaderViewController *reader = [ZBarReaderViewController new];
        reader.readerDelegate = self;
        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        
        ZBarImageScanner *scanner = reader.scanner;
        
        [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
        [self presentModalViewController: reader animated: YES]; 
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"main";
    
    if (indexPath.section == 1) { 
                CellIdentifier = @"scan";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0){
        NSArray *filter = [filters objectAtIndex:indexPath.row];
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
        UILabel *detailsLabel = (UILabel *)[cell viewWithTag:12];

        titleLabel.text = [filter valueForKey:@"Name"];
        NSString *val = [filter valueForKey:@"Value"];
        detailsLabel.text = val;
    }
    else {
       UILabel *titleLabel = (UILabel *)[cell viewWithTag:13];
       titleLabel.text = @"Scan Barcode"; 
    }
    
    return cell;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results) { break; }
    
    NSString *resultText = symbol.data;
    
    // see if we can find the correct part
    NSMutableDictionary *partFilter = [NSMutableDictionary dictionary];
    [partFilter setObject: @"BOCS No"  forKey: @"Name"];
    [partFilter setObject: @"BPCSNo"  forKey: @"Accessor"];
    [partFilter setObject: resultText  forKey: @"Value"];
    
    NSArray *filter = [[NSArray alloc] initWithObjects:partFilter,nil];
    NSArray *foundProducts = [Products applyFilters:allProducts :filter];
    
    if ([foundProducts count] > 0) {
        scannedProduct = [foundProducts objectAtIndex:0];
        [self performSegueWithIdentifier:@"scanned" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Barcode not recognised" message:@"Cannot find selected item in product guide"
                                                       delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    [reader dismissModalViewControllerAnimated: YES];
}

- (IBAction)resetButton:(id)sender {
    filters = [[NSMutableArray alloc] initWithArray:[Products importData:@"filter"] copyItems:YES];
    [self.tableView reloadData];
}
@end
