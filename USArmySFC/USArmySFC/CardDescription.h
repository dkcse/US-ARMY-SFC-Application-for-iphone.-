//
//  CardDescription.h
//  USArmySFC
//
//  Created by Deepak Kumar on 14/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorites.h"

@interface CardDescription : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *cardLogoImage;
@property (strong, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *favoriteSelectionImage;
@property (strong, nonatomic) IBOutlet UITableView *cardDescriptionTableView;
@property (nonatomic,strong) NSString *cardName;

@property (nonatomic,strong) UITapGestureRecognizer *tapToAddIntoFavorites;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;


- (BOOL) searchForNameInCoreData : (NSString *)name;
@end
