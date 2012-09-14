//
//  CardDescription.m
//  USArmySFC
//
//  Created by Deepak Kumar on 14/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CardDescription.h"

@interface CardDescription()

@property (nonatomic,strong) NSArray *descriptionArray1;
@property (nonatomic,strong) NSArray *descriptionArray2;
@property (nonatomic,strong) NSArray *description;


@end

@implementation CardDescription
@synthesize cardLogoImage = _cardLogoImage;
@synthesize cardNameLabel = _cardNameLabel;
@synthesize favoriteSelectionImage = _favoriteSelectionImage;
@synthesize cardDescriptionTableView = _cardDescriptionTableView;
@synthesize description = _description;
@synthesize descriptionArray1 = _descriptionArray1;
@synthesize descriptionArray2 = _descriptionArray2;
@synthesize cardName = _cardName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }

    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"hello");
    self.cardDescriptionTableView.delegate = self;
    self.cardDescriptionTableView.dataSource = self;
    _cardDescriptionTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];

    _cardLogoImage.image = [UIImage imageNamed:@"icon.png"]; 
    _favoriteSelectionImage.image = [UIImage imageNamed:@"star_normal.png"];
       _cardNameLabel.text = _cardName;
    _cardNameLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];

    
    _descriptionArray1 = [[NSArray alloc]initWithObjects:@"About",@"Enter Services",@"Fire Prevention",@"Hazardous Materials and POL",@"Training Areas DOs And DON'Ts",@"Vehicle Movement",@"Washrack Procedure", nil];
    _descriptionArray2 = [[NSArray alloc] initWithObjects:@"Risk Assessment Model", nil];
    
    _description = [[NSArray alloc]initWithObjects:_descriptionArray1,_descriptionArray2,nil];
     _cardDescriptionTableView.backgroundColor = [UIColor clearColor];
    [self.cardDescriptionTableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"hello");
    self.cardDescriptionTableView.delegate = self;
    self.cardDescriptionTableView.dataSource = self;
   
    

    _descriptionArray1 = [[NSArray alloc]initWithObjects:@"About",@"Enter Services",@"Fire Prevention",@"Hazardous Materials and POL",@"Training Areas DOs And DON'Ts",@"Vehicle Movement",@"Washrack Procedure", nil];
    _descriptionArray2 = [[NSArray alloc] initWithObjects:@"Risk Assessment Model", nil];
    
    _description = [[NSArray alloc]initWithObjects:_descriptionArray1,_descriptionArray2,nil];
    [self.cardDescriptionTableView reloadData];
    
}

- (void)viewDidUnload
{
    [self setCardLogoImage:nil];
    [self setCardNameLabel:nil];
    [self setFavoriteSelectionImage:nil];
    [self setCardDescriptionTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *sectionNo = [self.description objectAtIndex:section];
    NSInteger rows = [sectionNo count];
    
    return rows;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return [self.description count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellData = @"actionData";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellData];
    }
    
    NSArray *menu= [self.description objectAtIndex : indexPath.section];
    
    //NSArray *keys = [menu allKeys];
    //NSArray *values = [menu allValues];
    
    
    //NSArray *tempArray = [self.arrayForImages objectAtIndex:indexPath.section];
    //cell.backgroundColor = [UIColor Color];
    cell.textLabel.text = [menu objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = [keys objectAtIndex:indexPath.row];
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)]; 
    accessoryButton.tag = indexPath.row;
    UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
    [accessoryButton setImage:imageView forState:UIControlStateNormal];
    [accessoryButton addTarget:self action:@selector(accessoryButtonDisclosureTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:accessoryButton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    accessoryButton.tag = indexPath.row;
    
    cell.textLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor clearColor]; 
                            //cell.imageView.image = [UIImage imageNamed:[tempArray objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}


- (void) accessoryButtonDisclosureTapped : (UIButton *)sender
{
    NSLog(@"hello disclosure pressed");
    
    
}


@end