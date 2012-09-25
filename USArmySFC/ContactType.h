//
//  ContactType.h
//  USArmySFC
//
//  Created by Deepak Kumar on 25/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact_details, Product;

@interface ContactType : NSManagedObject

@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * contactName;
@property (nonatomic, retain) Contact_details *contactDetail;
@property (nonatomic, retain) Product *productRelation;

@end
