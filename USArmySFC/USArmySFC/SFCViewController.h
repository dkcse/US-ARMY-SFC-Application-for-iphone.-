//
//  SFCViewController.h
//  USArmySFC
//
//  Created by Deepak Kumar on 12/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "CardDescription.h"

@interface SFCViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,customDelegate>

@property (strong, nonatomic) IBOutlet UIView *favoritesView;
@property (strong, nonatomic) IBOutlet UIView *moreView;
@property (strong, nonatomic) IBOutlet UIView *cardsView;
@property (strong, nonatomic) IBOutlet UITableView *cardsTableView;
@property (strong, nonatomic) IBOutlet UITextView *moreTextView;
@property (strong, nonatomic) IBOutlet UIScrollView *moreScrollView;
@property (strong, nonatomic) IBOutlet UIButton *moreViewButton;

- (IBAction)showFavoriteView:(id)sender;
- (IBAction)showMoreOption:(id)sender;
- (IBAction)showAvailableCards:(id)sender;

@end
