//
//  TableViewCell.h
//  USArmySFC
//
//  Created by Deepak Kumar on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDescription.h"

@protocol customDelegate <NSObject>

- (UINavigationController *) sendNavigationControllerInstance;

@end

@interface TableViewCell : UITableViewCell <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView *insideTableView;
@property (strong,nonatomic) IBOutlet UILabel *cellDataLabel;
@property (strong,nonatomic) IBOutlet UIButton *plusButton;
@property (strong,nonatomic) IBOutlet UIImageView *divider;
@property (retain,nonatomic) id <customDelegate> celldelegate;
@property (strong,nonatomic) NSArray *languageArray;
@property (nonatomic) NSInteger index;
@property (nonatomic,strong) NSMutableArray *cardArrayForTableView;
@property (nonatomic,strong) NSMutableArray *productNameFromMainView;
@property (nonatomic,strong) NSMutableArray *languageArrayFromMainView;
@property (nonatomic,strong) NSMutableArray *attributeArray;
@property (nonatomic,strong) NSMutableArray *descriptionArray;
@property (nonatomic) NSInteger selectedRow;

@end
