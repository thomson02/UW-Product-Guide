//
//  ProductDetailsController.h
//  UW4
//
//  Created by Andrew Thomson on 15/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsController : UITableViewController

@property (copy, nonatomic) NSArray *selection;
@property (weak, nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UILabel *generalDescription;
@property (strong, nonatomic) IBOutlet UILabel *generalManufacturer;
@property (strong, nonatomic) IBOutlet UILabel *generalModel;
@property (strong, nonatomic) IBOutlet UILabel *screenPlatform;
@property (strong, nonatomic) IBOutlet UILabel *screenFrame;
@property (strong, nonatomic) IBOutlet UILabel *screenLength;
@property (strong, nonatomic) IBOutlet UILabel *screenWidth;
@property (strong, nonatomic) IBOutlet UILabel *meshLayers;
@property (strong, nonatomic) IBOutlet UILabel *meshCount;
@property (strong, nonatomic) IBOutlet UILabel *meshApi;
@property (strong, nonatomic) IBOutlet UILabel *meshKd;
@property (strong, nonatomic) IBOutlet UILabel *meshArea;
@property (strong, nonatomic) IBOutlet UILabel *meshType;
@property (strong, nonatomic) IBOutlet UILabel *orderPart;
@property (strong, nonatomic) IBOutlet UILabel *orderFob;
@property (strong, nonatomic) IBOutlet UILabel *orderPerBox;
@property (strong, nonatomic) IBOutlet UILabel *price2012;
@property (strong, nonatomic) IBOutlet UILabel *price2011;

@end
