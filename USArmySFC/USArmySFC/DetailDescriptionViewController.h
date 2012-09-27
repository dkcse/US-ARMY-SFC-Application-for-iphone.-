//
//  DetailDescriptionViewController.h
//  USArmySFC
//
//  Created by Deepak Kumar on 24/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NSString+RemoveQuotes.h"

@interface DetailDescriptionViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView *descriptionMainView;
@property (nonatomic,strong) IBOutlet UIImageView *descriptionBackgroundImage;
@property (nonatomic,strong) IBOutlet UIView *descriptionSubview;
@property (nonatomic,strong) IBOutlet UITextView *descriptionTextView;
@property (nonatomic,strong) IBOutlet UILabel *descriptionHeading;

@property (nonatomic,strong) NSString *detailViewHeading;
@property (nonatomic,strong) NSString *detailHeading;
@property (nonatomic,strong) NSString *detailDescription;
- (IBAction)goBack:(id)sender;

@end
