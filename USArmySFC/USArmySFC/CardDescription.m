//
//  CardDescription.m
//  USArmySFC
//
//  Created by Deepak Kumar on 14/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CardDescription.h"

@interface CardDescription()

@property (nonatomic) NSInteger pressCount;
@property (nonatomic) BOOL favoriteImageStatus;
@property (nonatomic,strong) NSString *lineOfContactCSV;
@property (nonatomic,strong) NSMutableArray *contactDetails1;
@property (nonatomic,strong) NSMutableArray *contactDetails2;
@property (nonatomic,strong) NSMutableArray *contactDetails3;
@property (nonatomic,strong) NSMutableArray *contactDetails4;
@property (nonatomic,strong) NSMutableArray *contactDetails5;
@property (nonatomic,strong) NSMutableArray *contactDetails6;
@property (nonatomic,strong) NSMutableArray *contactDetails7;
@property (nonatomic,strong) NSMutableArray *contactDetails8;
@property (nonatomic,strong) NSMutableArray *contactDetails9;
@property (nonatomic,strong) NSMutableArray *contactDetails10;
@property (nonatomic,strong) NSMutableArray *contactDetails11;
@property (nonatomic,strong) NSMutableArray *contactDetails12;
@property (nonatomic,strong) NSMutableArray *contactDetails13;
@property (nonatomic,strong) NSMutableArray *contactDetails14;
@property (nonatomic,strong) NSMutableArray *contactDetails15;
@property (nonatomic,strong) NSMutableArray *contactDetails16;
@property (nonatomic,strong) NSMutableArray *contactDetails17;
@property (nonatomic,strong) NSMutableArray *contactDetails18;
@property (nonatomic,strong) NSMutableArray *contactDetails19;
@property (nonatomic,strong) NSMutableArray *contactDetails20;
@property (nonatomic,strong) NSMutableArray *contactDetails21;
@property (nonatomic,strong) NSMutableArray *contactDetails22;
@property (nonatomic,strong) NSMutableArray *contactDetails23;
@property (nonatomic) NSMutableArray *productNameFromContactCSV;

@end

@implementation CardDescription

@synthesize pressCount = _pressCount;
@synthesize cardLogoImage = _cardLogoImage;
@synthesize cardNameLabel = _cardNameLabel;
@synthesize favoriteSelectionImage = _favoriteSelectionImage;
@synthesize cardDescriptionTableView = _cardDescriptionTableView;
@synthesize cardName = _cardName;
@synthesize cardSubtitleLabel = _cardSubtitleLabel;
@synthesize tapToAddIntoFavorites = _tapToAddIntoFavorites;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize favoriteImageStatus = _favoriteImageStatus;
@synthesize cardDetails = _cardDetails;
@synthesize cardSubTitle = _cardSubTitle;
@synthesize detailDescription = _detailDescription;
@synthesize lineOfContactCSV = _lineOfContactCSV;

//setting views
@synthesize commonView = _commonView;
@synthesize guidelineView = _guidelineView;
@synthesize POCView = _POCView;
@synthesize mapView = _mapView;

//for contact detail
@synthesize contactDetails1,contactDetails2,contactDetails3,contactDetails4,contactDetails5,contactDetails6,contactDetails7,contactDetails8,contactDetails9,contactDetails10,contactDetails11,contactDetails12,contactDetails13,contactDetails14,contactDetails15,contactDetails16,contactDetails17,contactDetails18,contactDetails19,contactDetails20,contactDetails21,contactDetails22,contactDetails23;
@synthesize productNameFromContactCSV = _productNameFromContactCSV;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"hello");
    _guidelineView.hidden = NO;
    self.cardDescriptionTableView.delegate = self;
    self.cardDescriptionTableView.dataSource = self;
    _cardDescriptionTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _cardLogoImage.image = [UIImage imageNamed:@"icon.png"]; 
    
    if([self searchForNameInCoreData : _cardName])
    {
        NSLog(@"name present in coredata");
        _favoriteSelectionImage.image = [UIImage imageNamed:@"star.png"];
    }
    else 
    {
        NSLog(@"not present in coredata");
        _favoriteSelectionImage.image = [UIImage imageNamed:@"star_normal.png"];
    }
    _cardNameLabel.text = _cardName;
    NSLog(@"sub title = %@",_cardSubTitle);
    _cardSubtitleLabel.text = _cardSubTitle;
    _cardSubtitleLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _cardNameLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _cardDescriptionTableView.backgroundColor = [UIColor clearColor];
    [self.cardDescriptionTableView reloadData];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)guidelineDescription:(id)sender
{
    _guidelineView.hidden = NO;
    _POCView.hidden = YES;
    _mapView.hidden = YES;
    NSLog(@"guideline description");
}

- (IBAction)POCDescription:(id)sender
{
    NSLog(@"POC description");
    _POCView.hidden = NO;
    _mapView.hidden = YES;
    _guidelineView.hidden = YES;
    _POCView.backgroundColor = [UIColor clearColor];
    
}

- (IBAction)mapDescription:(id)sender
{
    NSLog(@"maps description");
    _mapView.hidden = NO;
    _guidelineView.hidden = YES;
    _POCView.hidden = NO;
    _mapView.backgroundColor = [UIColor clearColor];
}

- (BOOL) searchForNameInCoreData:(NSString *)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedResults;
    
    if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        //        for(Favorites *obj in fetchedResults)
        //        {
        //            if([obj.name isEqualToString:_cardNameLabel.text])
        //            {
        //                NSLog(@"found : %@",_cardNameLabel);
        //                return YES;
        //            }
        //            else 
        //            {
        //                return NO;
        //            }
        //        }
        NSLog(@"%@",fetchedResults);
        
        if(![_managedObjectContext save:&error])
        {
            NSLog(@"Could NOt Save changes : %@ , %@",[error description],[error userInfo]);
        }
    }
    else
    {
        NSLog(@"error : %@  and %@",[error description],[error userInfo]); 
    }
    if([fetchedResults count]>0)
        return YES;
    else 
    {
        return NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // contact detail
    _productNameFromContactCSV = [[NSMutableArray alloc]init];
    contactDetails1 = [[NSMutableArray alloc]init];
    contactDetails2 = [[NSMutableArray alloc]init];
    contactDetails3 = [[NSMutableArray alloc]init];
    contactDetails4 = [[NSMutableArray alloc]init];
    contactDetails5 = [[NSMutableArray alloc]init];
    contactDetails6 = [[NSMutableArray alloc]init];
    contactDetails7 = [[NSMutableArray alloc]init];
    contactDetails8 = [[NSMutableArray alloc]init];
    contactDetails9 = [[NSMutableArray alloc]init];
    contactDetails10 = [[NSMutableArray alloc]init];
    contactDetails11 = [[NSMutableArray alloc]init];
    contactDetails12 = [[NSMutableArray alloc]init];
    contactDetails13 = [[NSMutableArray alloc]init];
    contactDetails14 = [[NSMutableArray alloc]init];
    contactDetails15 = [[NSMutableArray alloc]init];
    contactDetails16 = [[NSMutableArray alloc]init];
    contactDetails17 = [[NSMutableArray alloc]init];
    contactDetails18 = [[NSMutableArray alloc]init];
    contactDetails19 = [[NSMutableArray alloc]init];
    contactDetails20 = [[NSMutableArray alloc]init];
    contactDetails21 = [[NSMutableArray alloc]init];
    contactDetails22 = [[NSMutableArray alloc]init];
    contactDetails23 = [[NSMutableArray alloc]init];
    //setting default view that is guideline view
    
    _commonView.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:23.0/255.0 blue:21.0/255.0 alpha:1.0];
    
    _POCView.hidden = YES;
    _mapView.hidden = YES;
    _guidelineView.hidden = NO;
    _commonView.layer.cornerRadius = 10;
    _guidelineView.backgroundColor = [UIColor clearColor]; 
    _commonView.layer.masksToBounds = YES;
    
    
    // delegate and managed object setting
    
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    _pressCount = 0;
    self.cardDescriptionTableView.delegate = self;
    self.cardDescriptionTableView.dataSource = self;
    _cardDescriptionTableView.userInteractionEnabled = YES;
    _favoriteSelectionImage.userInteractionEnabled = YES;
    _tapToAddIntoFavorites.delegate = self;
    _tapToAddIntoFavorites = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapToAddIntoFavorites:)];
    [self.favoriteSelectionImage addGestureRecognizer:_tapToAddIntoFavorites];
    [self.cardDescriptionTableView reloadData];
    [self storeContactCSVDataToCoreData];
    [self fetchContactInformationFromCoreData];
}


-(void) fetchContactInformationFromCoreData
{
    NSLog(@"fetching from coredat");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchResults = [[NSArray alloc]init];
    NSError *error;
    if((fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        //NSLog(@"description are:%@",fetchResults);
        NSLog(@"name==== %@",[[fetchResults objectAtIndex:0] contactDetail]);
    }
    for (Product *obj in fetchResults)
    {
        NSLog(@"contact detail are: %@",obj.contactDetail);
        for (ContactType *contactObj in obj.contactDetail)
        {
            NSLog(@"contact name==== %@",contactObj.contactName);
        }
    }
}

-(void) storeContactCSVDataToCoreData
{
    FileReaderLineByLine *readerForContractsCSV = [[FileReaderLineByLine alloc] initWithFilePath:@"/Users/deepakkumar/US SFC/Contacts-Table.csv"];
    _lineOfContactCSV = nil;
    

    while ((_lineOfContactCSV = [readerForContractsCSV readLine]))
    {
        NSArray *contactIndex1 = [[NSArray alloc]init];
        NSArray* allLinedStrings = [_lineOfContactCSV componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        contactIndex1 = [[allLinedStrings objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];

        //storing product name from CSV file
        int count = 1;
        while(count < ([contactIndex1 count]))
        {
            [_productNameFromContactCSV addObject:[contactIndex1 objectAtIndex:count]];
            count += 5;
        }
        //Contact type starts from 18th index in CSV reading one by one
        for (int lineCount = 18; lineCount < [allLinedStrings count]-1; lineCount++)
        {
            NSLog(@"All lined Strings for contacts - %@",[allLinedStrings objectAtIndex:lineCount]);
            NSArray *iterateLine = [[allLinedStrings objectAtIndex:lineCount] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
            NSLog(@"count no for iteration = %d",[iterateLine count]);
            
            NSArray *halfArray;
            NSRange theRange;
            NSMutableArray *subArray  = [[NSMutableArray alloc] initWithCapacity:23];
            
            //dividing each contact type into array of arrays of contacts for each product
            for(int i=0;i<23;i++)
            {   if(i == 0)
                {
                theRange.location = 0; 
                }
                theRange.length = 5;
                halfArray = [iterateLine subarrayWithRange:theRange];
                theRange.location += 5;
                [subArray addObject:halfArray];
                NSLog(@"sub array : %@",[subArray objectAtIndex:0]);
            } 
            // storing contacts for product in seperate array 
            [contactDetails1 addObject:[subArray objectAtIndex:0]];
            [contactDetails2 addObject:[subArray objectAtIndex:1]];
            [contactDetails3 addObject:[subArray objectAtIndex:2]];
            [contactDetails4 addObject:[subArray objectAtIndex:3]];
            [contactDetails5 addObject:[subArray objectAtIndex:4]];
            [contactDetails6 addObject:[subArray objectAtIndex:5]];
            [contactDetails7 addObject:[subArray objectAtIndex:6]];
            [contactDetails8 addObject:[subArray objectAtIndex:7]];
            [contactDetails9 addObject:[subArray objectAtIndex:8]];
            [contactDetails10 addObject:[subArray objectAtIndex:9]];
            [contactDetails11 addObject:[subArray objectAtIndex:10]];
            [contactDetails12 addObject:[subArray objectAtIndex:11]];
            [contactDetails13 addObject:[subArray objectAtIndex:12]];
            [contactDetails14 addObject:[subArray objectAtIndex:13]];
            [contactDetails15 addObject:[subArray objectAtIndex:14]];
            [contactDetails16 addObject:[subArray objectAtIndex:15]];
            [contactDetails17 addObject:[subArray objectAtIndex:16]];
            [contactDetails18 addObject:[subArray objectAtIndex:17]];
            [contactDetails19 addObject:[subArray objectAtIndex:18]];
            [contactDetails20 addObject:[subArray objectAtIndex:19]];
            [contactDetails21 addObject:[subArray objectAtIndex:20]];
            [contactDetails22 addObject:[subArray objectAtIndex:21]];
            [contactDetails23 addObject:[subArray objectAtIndex:22]];
        }
    
        //storing contacts into database for each product
        for (int count1 = 0 ; count1 < [_productNameFromContactCSV count]-2; count1++)
        {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
            [fetchRequest setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",[_productNameFromContactCSV objectAtIndex:count1]];
            NSLog(@"predicat : %@",predicate);
            [fetchRequest setPredicate:predicate];
            NSError *error;    
            NSArray *fetchedResults = [[NSArray alloc] init];
            
                        
            if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
            {
                NSLog(@"product ed details are :%@",fetchedResults);
                NSLog(@"product name =%@",_productNameFromContactCSV);
            }
            else
            {
                NSLog(@"error : %@  and %@",[error description],[error userInfo]);  
            }
            
            //iterating through array of arrays for each product selected in outer loop
            for (int i = 0; i<23; i++)
            {
                ContactType *contactType = (ContactType *)[NSEntityDescription insertNewObjectForEntityForName:@"ContactType" inManagedObjectContext:_managedObjectContext];
                contactType.contactName = [[contactDetails1 objectAtIndex:i]objectAtIndex:1];
                Contact_details *contactDetails = (Contact_details *)[NSEntityDescription insertNewObjectForEntityForName:@"Contact_details" inManagedObjectContext:_managedObjectContext];
                contactDetails.contact = [[contactDetails1 objectAtIndex:i]objectAtIndex:1];
                contactDetails.dsn = [[contactDetails1 objectAtIndex:i]objectAtIndex:2];
                contactDetails.civilion = [[contactDetails1 objectAtIndex:i]objectAtIndex:3];
                contactDetails.frequency = [[contactDetails1 objectAtIndex:i]objectAtIndex:4];
                contactDetails.forContact = contactType;
                contactType.productRelation = [fetchedResults objectAtIndex:0];   
            }    
            [self.managedObjectContext save:&error];
        }
    }
}




-(void) handleTapToAddIntoFavorites:(UITapGestureRecognizer*)tapGesture
{
    NSLog(@"tapped");    
    if(_pressCount % 2 == 0 && _favoriteSelectionImage.image == [UIImage imageNamed:@"star_normal.png"])
    {
        _pressCount++;
        NSLog(@"count = %d",_pressCount);
        _favoriteSelectionImage.image = [UIImage imageNamed:@"star.png"];
        [self addToCoreData];
    }
    else
    {
        _pressCount++;
        _favoriteSelectionImage.image = [UIImage imageNamed:@"star_normal.png"];
        [self deleteFromCoreData];
    }
}

- (void) deleteFromCoreData
{
    NSLog(@"delete called");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedResults;
    
    if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        for(Favorites *obj in fetchedResults)
        {
            if([obj.name isEqualToString:_cardNameLabel.text])
            {
                NSLog(@"found : %@",_cardNameLabel);
                [_managedObjectContext deleteObject:obj];
                break;
            }
        }
        
        if(![_managedObjectContext save:&error])
        {
            NSLog(@"Could NOt Save changes : %@ , %@",[error description],[error userInfo]);
        }
    }
    else
    {
        NSLog(@"error : %@  and %@",[error description],[error userInfo]); 
    }
}

- (void) addToCoreData
{
    Favorites *favoriteObject = (Favorites *)[NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
    NSLog(@"name = %@",_cardNameLabel.text);
    [favoriteObject setName:_cardNameLabel.text];
    [self fetchFromCoreData];
}

- (void) fetchFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;    
    NSArray *fetchedResults;
    if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        NSArray *fetchedName = [[NSArray alloc]init];
        fetchedName = fetchedResults;
        NSMutableArray *copyOfFetchedName = [[NSMutableArray alloc]init];
        copyOfFetchedName = [fetchedName mutableCopy];
        
        if([copyOfFetchedName count])
        {
            NSLog(@"name of favorites are : %@",copyOfFetchedName);
        }
    }
    else
    {
        NSLog(@"error : %@  and %@",[error description],[error userInfo]);  
    }
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
    NSLog(@"card details count = %d",[_cardDetails count]);
    return [_cardDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellData = @"actionData";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellData];
    }
    
    cell.textLabel.text = [_cardDetails objectAtIndex:indexPath.row];
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
    return cell;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row selected are %@",indexPath.row);
}

- (void) accessoryButtonDisclosureTapped : (UIButton *)sender
{
    NSLog(@"hello disclosure pressed");
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    DetailDescriptionViewController *pushForDetail = [storyboard instantiateViewControllerWithIdentifier:@"detailDescriptor"]; 
    pushForDetail.detailViewHeading = _cardName;
    pushForDetail.detailHeading = [_cardDetails objectAtIndex:sender.tag];
    pushForDetail.detailDescription = [_detailDescription objectAtIndex:sender.tag];
    [self.navigationController pushViewController:pushForDetail animated:YES];
    
}



@end