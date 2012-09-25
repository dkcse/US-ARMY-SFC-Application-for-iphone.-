//
//  Product.h
//  USArmySFC
//
//  Created by Deepak Kumar on 25/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactType, Description;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * productNo;
@property (nonatomic, retain) Description *productDetail;
@property (nonatomic, retain) NSSet *contactDetail;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addContactDetailObject:(ContactType *)value;
- (void)removeContactDetailObject:(ContactType *)value;
- (void)addContactDetail:(NSSet *)values;
- (void)removeContactDetail:(NSSet *)values;

@end
