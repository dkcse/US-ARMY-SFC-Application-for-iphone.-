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
}

-(void) storeContactCSVDataToCoreData
{
    FileReaderLineByLine *readerForContractsCSV = [[FileReaderLineByLine alloc] initWithFilePath:@"/Users/deepakkumar/US SFC/Contacts-Table.csv"];
    _lineOfContactCSV = nil;
    
    while ((_lineOfContactCSV = [readerForContractsCSV readLine]))
    {
        NSArray* allLinedStrings = [_lineOfContactCSV componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
       
        
        for (int lineCount = 18; lineCount < [allLinedStrings count]; lineCount++)
        {
            NSLog(@"All lined Strings for contacts - %@",[allLinedStrings objectAtIndex:lineCount]);
            NSArray *iterateLine = [[allLinedStrings objectAtIndex:lineCount] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
            NSLog(@"count no for iteration = %d",[iterateLine count]);
         
            NSArray *halfArray;
            NSRange theRange;
            NSMutableArray *subArray  = [[NSMutableArray alloc] initWithCapacity:23];
            
            for(int i=1;i<=23;i++)
            {   if(i==1)
                {
                   theRange.location = 0;  
                }
                theRange.length = 5;
                halfArray = [iterateLine subarrayWithRange:theRange];
                
                theRange.location += 5;
                [subArray addObject:halfArray];
            }
            NSLog(@"subarray : %@",subArray);
            
            for (int iterateLineCount = 1;iterateLineCount < [iterateLine count]; iterateLineCount++)
            {
//                ContactType *contactType = (ContactType *)[NSEntityDescription insertNewObjectForEntityForName:@"contactType" inManagedObjectContext:_managedObjectContext];
//                if(count<5)
//                {
//                    //old product
//                    count++;
//                }
//                else 
//                {
//                    count = 0;
//                    //new one
//                }
//                NSLog(@"data after semi: %@",[iterateLine objectAtIndex:iterateLineCount]);
//                
//                contactType.contactName = [iterateLine objectAtIndex:<#(NSUInteger)#>
//                
//            }
        
//            
            }
        
        
                
//        ContactType *contactType = (ContactType *)[NSEntityDescription insertNewObjectForEntityForName:@"contactType" inManagedObjectContext:_managedObjectContext];
//        contactType.productName = 
//        contactType.contactName = 
        
        
        //   NSArray *data1 = [[allLinedStrings objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
        //  NSArray *data2 = [[allLinedStrings objectAtIndex:1] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
        //  NSLog(@"%@",[data2 objectAtIndex:1]);
        // NSLog(@"count = %d-",[data1 count]);

    
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