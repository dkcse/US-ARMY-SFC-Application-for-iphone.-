//
//  DetailDescription.h
//  USArmySFC
//
//  Created by Deepak Kumar on 18/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Description;

@interface DetailDescription : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) Description *detailForEachDescription;

@end
