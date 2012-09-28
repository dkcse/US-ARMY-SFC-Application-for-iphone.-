//
//  ContactDetailDescription.h
//  USArmySFC
//
//  Created by Deepak Kumar on 26/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ContactType.h"
#import "Contact_details.h"
#import "Product.h"
#import "NSString+RemoveQuotes.h"

@interface ContactDetailDescription : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic,strong) IBOutlet UIView *contactDetailView;
@property (nonatomic,strong) IBOutlet UILabel *contactDetailLabelForProduct;
@property (nonatomic,strong) IBOutlet UILabel *contactDetailLabelForContactType;
@property (nonatomic,strong) IBOutlet UITableView *contactDetailTableView;
@property (nonatomic,strong) NSString *contactOfProductName;
@property (nonatomic,strong) NSString *contactTypeName;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSMutableArray *contactDetailDSN;
@property (nonatomic,strong) NSMutableArray *contactDetailCivilion;
@property (nonatomic,strong) NSMutableArray *contactDetailFrequency;
@property (nonatomic,strong) NSMutableArray *contactDetailContactName;
@property (nonatomic,strong) NSMutableArray *contactDetailsName;
@property (nonatomic,strong) NSMutableArray *productNameFromContactDetail;
@property (nonatomic) NSInteger productIndex;
@property (nonatomic,strong) NSMutableArray *cellTextLabelArray;
@property (nonatomic,strong) NSMutableArray *cellTextDetailArray;
- (IBAction)goBack:(id)sender;

@end
