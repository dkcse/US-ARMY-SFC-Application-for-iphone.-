//
//  SFCCustomCellForFavoritesTable.h
//  USArmySFC
//
//  Created by Deepak Kumar on 16/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDescription.h"
#import "Product.h"
#import "Description.h"
#import "NSString+RemoveQuotes.h"


@protocol customFavoriteTableDelegate <NSObject>

- (UINavigationController *) sendNavigationControllerInstance;
- (NSDictionary *) sendAttributeAndDescription:(Product *)selectedProduct;

@end

@interface SFCCustomCellForFavoritesTable : UITableViewCell <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView *insideTableView;
@property (strong,nonatomic) IBOutlet UILabel *cellDataLabel;
@property (strong,nonatomic) IBOutlet UIButton *plusButton;
@property (strong,nonatomic) IBOutlet UIImageView *divider;
@property (retain,nonatomic) id <customFavoriteTableDelegate> celldelegate;
@property (strong,nonatomic) NSArray *languageArray;
@property (nonatomic) NSInteger index;
@property (nonatomic,strong) NSMutableArray *cardArrayForTableView;
@property (nonatomic,strong) NSMutableArray *productNameFromMainView;
@property (nonatomic,strong) NSMutableArray *languageArrayFromMainView;
@property (nonatomic,strong) NSMutableArray *attributeArray;
@property (nonatomic,strong) NSMutableArray *descriptionArray;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic) NSDictionary *description;
@property (nonatomic,strong) Product *selectedProduct;
@property (nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
