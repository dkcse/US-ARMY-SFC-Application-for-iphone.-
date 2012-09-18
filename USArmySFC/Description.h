//
//  Description.h
//  USArmySFC
//
//  Created by Deepak Kumar on 18/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DetailDescription, Product;

@interface Description : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Product *productDescription;
@property (nonatomic, retain) NSSet *detailDescriptionOfCard;
@end

@interface Description (CoreDataGeneratedAccessors)

- (void)addDetailDescriptionOfCardObject:(DetailDescription *)value;
- (void)removeDetailDescriptionOfCardObject:(DetailDescription *)value;
- (void)addDetailDescriptionOfCard:(NSSet *)values;
- (void)removeDetailDescriptionOfCard:(NSSet *)values;

@end
