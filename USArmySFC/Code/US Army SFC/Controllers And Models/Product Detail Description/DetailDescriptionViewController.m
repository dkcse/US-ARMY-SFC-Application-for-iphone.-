//
//  DetailDescriptionViewController.m
//  USArmySFC
//
//  Created by Deepak Kumar on 24/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailDescriptionViewController.h"

#pragma mark -

@implementation DetailDescriptionViewController

@synthesize descriptionMainView = _descriptionMainView;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize descriptionBackgroundImage = _descriptionBackgroundImage;
@synthesize descriptionSubview = _descriptionSubview;
@synthesize descriptionHeading = _descriptionHeading;
@synthesize detailViewHeading = _detailViewHeading;
@synthesize detailDescription = _detailDescription;
@synthesize detailHeading = _detailHeading;


-(void) viewWillAppear:(BOOL)animated
{
    // navigation title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:34.0/255.0 green:36.0/255.0 blue:24.0/255.0 alpha:1.0];
   
    label.text = _detailViewHeading;
    NSArray *firstSubstring = [label.text componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];

    label.text = [[firstSubstring objectAtIndex:0]substringFromIndex:1];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    //view settings
    
    _descriptionSubview.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:23.0/255.0 blue:21.0/255.0 alpha:1.0];
    _descriptionSubview.layer.cornerRadius = 10;
    _descriptionSubview.layer.masksToBounds = YES;
    _descriptionTextView.backgroundColor = [UIColor clearColor];
    _descriptionHeading.backgroundColor = [UIColor clearColor];
    _descriptionHeading.text = _detailHeading;
    _descriptionHeading.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _descriptionTextView.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _descriptionTextView.text = [_detailDescription stringByRemoveLeadingAndTrailingQuotes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)goBack:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end