//
//  Products.h
//  UW4
//
//  Created by Andrew Thomson on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSArray *allProducts;
extern NSMutableArray *filters;

@interface Products : NSObject

+(NSArray *)importData: (NSString *) fileName;

+(NSArray *) getUniqueValuesForKey: (NSString *)key : (NSArray *)dictionary;

+(NSString *) getValueForKey: (NSString *)key : (NSArray *)dictionary;

+(NSArray *) applyFilters: (NSArray *)list: (NSArray *) filters;

@end
