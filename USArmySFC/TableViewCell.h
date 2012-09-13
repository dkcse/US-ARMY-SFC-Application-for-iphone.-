//
//  TableViewCell.h
//  USArmySFC
//
//  Created by Deepak Kumar on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) IBOutlet UITableView *insideTableView;
@property (strong,nonatomic) IBOutlet UILabel *cellDataLabel;
@property (strong,nonatomic) IBOutlet UIButton *plusButton;
@property (strong,nonatomic) NSArray *languageArray;

@property (strong,nonatomic) IBOutlet UIImageView *divider;

@end
