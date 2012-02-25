//
//  Products.m
//  UW4
//
//  Created by Andrew Thomson on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Products.h"

NSArray *allProducts;
NSMutableArray *filters;

@implementation Products

// Read data from json file
+ (NSArray *)importData: (NSString *) fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    NSError* error;
    return [NSJSONSerialization JSONObjectWithData:myData options:kNilOptions error:&error];
}

+(NSArray *) getUniqueValuesForKey: (NSString *)key : (NSArray *)dictionary
{
    return [[NSSet setWithArray:[dictionary valueForKey:key]] allObjects];
}

+(NSString *) getValueForKey: (NSString *)key : (NSArray *)dictionary
{
    return [dictionary valueForKey:key];
}

+(NSArray *) applyFilters: (NSArray *)list: (NSArray *) filters
{
    NSMutableArray *filteredList = [NSMutableArray array];
    
    for (NSArray *listItem in list) {
        BOOL ok = true;
        for (NSArray *filter in filters) {
            
            NSString *listItemFilterValue = [listItem valueForKey:[filter valueForKey:@"Accessor"]]; 
            
            if (![listItemFilterValue isEqualToString:[filter valueForKey:@"Value"]] && ![[filter valueForKey:@"Value"] isEqualToString:@"All"] ){
                ok = false;
                break;
            }
        }
        
        if (ok){
            [filteredList addObject:listItem];
        }
    }
    
    return filteredList;
}

@end
