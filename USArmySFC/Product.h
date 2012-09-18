//
//  Product.h
//  USArmySFC
//
//  Created by Deepak Kumar on 18/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Description;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *productDetail;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addProductDetailObject:(Description *)value;
- (void)removeProductDetailObject:(Description *)value;
- (void)addProductDetail:(NSSet *)values;
- (void)removeProductDetail:(NSSet *)values;

@end
