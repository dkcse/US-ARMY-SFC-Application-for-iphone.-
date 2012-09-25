//
//  CardDescription.h
//  USArmySFC
//
//  Created by Deepak Kumar on 14/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorites.h"
#import "DetailDescriptionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FileReaderLineByLine.h"
#import "ContactType.h"
#import "Contact_details.h"
#import "Product.h"

@interface CardDescription : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) IBOutlet UIView *commonView;
@property (strong,nonatomic) IBOutlet UIView *guidelineView;
@property (strong,nonatomic) IBOutlet UIView *POCView;
@property (strong,nonatomic) IBOutlet UIView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *cardLogoImage;
@property (strong, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (strong,nonatomic) IBOutlet UILabel *cardSubtitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *favoriteSelectionImage;
@property (strong, nonatomic) IBOutlet UITableView *cardDescriptionTableView;
@property (nonatomic,strong) NSString *cardName;
@property (nonatomic,strong) NSString *cardSubTitle;
@property (nonatomic,strong) NSMutableArray *cardDetails;
@property (nonatomic,strong) NSMutableArray *detailDescription;

@property (nonatomic,strong) UITapGestureRecognizer *tapToAddIntoFavorites;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
- (IBAction)goBack:(id)sender;

- (IBAction)guidelineDescription:(id)sender;
- (IBAction)POCDescription:(id)sender;
- (IBAction)mapDescription:(id)sender;

- (BOOL) searchForNameInCoreData : (NSString *)name;
@end
