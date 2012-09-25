//
//  Contact_details.h
//  USArmySFC
//
//  Created by Deepak Kumar on 25/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactType;

@interface Contact_details : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * civilion;
@property (nonatomic, retain) NSString * dsn;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) ContactType *forContact;

@end
