//
//  Product.h
//  USArmySFC
//
//  Created by Deepak Kumar on 22/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Description;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * productNo;
@property (nonatomic, retain) Description *productDetail;

@end
