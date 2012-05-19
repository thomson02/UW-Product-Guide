//
//  ProductDetailsController.m
//  UW4
//
//  Created by Andrew Thomson on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailsController.h"
#import "Products.h"

@implementation ProductDetailsController

@synthesize selection;
@synthesize delegate;
@synthesize generalDescription;
@synthesize generalManufacturer;
@synthesize generalModel;
@synthesize screenPlatform;
@synthesize screenFrame;
@synthesize screenLength;
@synthesize screenWidth;
@synthesize meshLayers;
@synthesize meshCount;
@synthesize meshApi;
@synthesize meshKd;
@synthesize meshArea;
@synthesize meshType;
@synthesize orderPart;
@synthesize orderFob;
@synthesize orderPerBox;
@synthesize price2012;
@synthesize price2011;

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
    
    NSArray *product = [selection valueForKey:@"object"];
    generalDescription.text = [product valueForKey:@"Description"];
    generalManufacturer.text = [product valueForKey:@"Manufacturer"];
    generalModel.text = [product valueForKey:@"Model"];
    screenPlatform.text = [product valueForKey:@"Platform"];
    screenFrame.text = [product valueForKey:@"Frame"];
    screenLength.text = [product valueForKey:@"Length"];
    screenWidth.text = [product valueForKey:@"Width"];
    meshLayers.text = [product valueForKey:@"Layers"];
    meshCount.text = [product valueForKey:@"Count"];
    meshApi.text = [product valueForKey:@"APINo"];
    meshKd.text = [product valueForKey:@"kD"];
    meshArea.text = [product valueForKey:@"Area"];
    meshType.text = [product valueForKey:@"Type"];
    orderFob.text = [product valueForKey:@"FOB"];
    orderPart.text = [product valueForKey:@"BPCSNo"];
    orderPerBox.text = [product valueForKey:@"QuantityPerBox"];
    
    if (![[product valueForKey:@"Price2012"] isEqualToString:@"Unknown"]){
        price2012.text = [product valueForKey:@"Price2012"];
    }
    else {
        price2012.text = [product valueForKey:@"Price2012"];
    }
    
    if (![[product valueForKey:@"Price2011"] isEqualToString:@"Unknown"]){
        price2011.text = [product valueForKey:@"Price2011"];
    }
    else {
        price2011.text = [product valueForKey:@"Price2011"];
    }  
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setGeneralDescription:nil];
    [self setGeneralManufacturer:nil];
    [self setGeneralModel:nil];
    [self setScreenPlatform:nil];
    [self setScreenFrame:nil];
    [self setScreenLength:nil];
    [self setScreenWidth:nil];
    [self setMeshLayers:nil];
    [self setMeshCount:nil];
    [self setMeshApi:nil];
    [self setMeshKd:nil];
    [self setMeshArea:nil];
    [self setMeshType:nil];
    [self setOrderPart:nil];
    [self setOrderFob:nil];
    [self setOrderPerBox:nil];
    [self setPrice2012:nil];
    [self setPrice2011:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

@end
