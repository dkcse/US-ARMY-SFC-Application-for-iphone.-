//
//  SFCViewController.m
//  USArmySFC
//
//  Created by Deepak Kumar on 12/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFCViewController.h"

@interface SFCViewController ()

@property (nonatomic,strong) NSMutableArray *listOfCards;
@property (nonatomic,strong) NSString *cardWithLanguage;
@property (strong,nonatomic) TableViewCell *tableCell;
@property (strong,nonatomic) UIButton *accessoryButton;
@property (strong,nonatomic) NSMutableArray *storeFetchedName;
@property (nonatomic) NSInteger indexRow;
@property (nonatomic) NSInteger numberOfRows;
@property (nonatomic) BOOL checkForTableViewHidden;
@property (nonatomic,strong) NSMutableArray *productNameUnique;

//variable declared for storing fetched value from .csv

@property (nonatomic,strong) NSString *lineOfGuidelineCSV;
@property (nonatomic,strong) NSMutableArray *cardName;
@property (nonatomic,strong) NSDictionary *cardNameWithLanguage;
@property (nonatomic,strong) NSMutableArray *cardNoWithDiffLang;

//variable for detail view
@property (nonatomic,strong) NSString *selectedCardName;
@property (nonatomic,strong) NSString *selectedCardSubtitle;
@property (nonatomic,strong) NSMutableArray *attributeArray;
@property (nonatomic,strong) NSMutableArray *descriptionArray;
@property (nonatomic,strong) Product *selectedProduct;
@property (nonatomic) NSInteger selectedCellToExpand;


@end

@implementation SFCViewController

@synthesize listOfCards = _listOfCards;
@synthesize favoritesView = _favoritesView;
@synthesize cardsView = _cardsView;
@synthesize moreView = _moreView;
@synthesize cardsTableView = _cardsTableView;
@synthesize moreTextView = _moreTextView;
@synthesize moreScrollView = _moreScrollView;
@synthesize moreViewButton = _moreViewButton;
@synthesize cardWithLanguage = _cardWithLanguage;
@synthesize indexRow = _indexRow;
@synthesize numberOfRows = _numberOfRows;
@synthesize checkForTableViewHidden = _checkForTableViewHidden;
@synthesize tableCell = _tableCell;
@synthesize accessoryButton = _accessoryButton;
@synthesize moreNavigationButton = _moreNavigationButton;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize storeFetchedName = _storeFetchedName;
@synthesize favoriteTableView = _favoriteTableView;
@synthesize productNameUnique = _productNameUnique;
@synthesize test = _test;

//for csv file


@synthesize lineOfGuidelineCSV = _lineOfGuidelineCSV;
@synthesize cardName = _cardName;
@synthesize cardNameWithLanguage = _cardNameWithLanguage;
@synthesize cardNameFromCoreData = _cardNameFromCoreData;
@synthesize cardNoWithDiffLang = _cardNoWithDiffLang;

//detail view
@synthesize selectedCardName = _selectedCardName;
@synthesize selectedCardSubtitle = _selectedCardSubtitle;
@synthesize attributeArray = _attributeArray;
@synthesize descriptionArray = _descriptionArray;
@synthesize selectedProduct = _selectedProduct;
@synthesize selectedCellToExpand = _selectedCellToExpand;



- (void)viewDidLoad
{
    [super viewDidLoad];
    _cardsTableView.delegate = self;
    _cardsTableView.dataSource = self;
    _favoriteTableView.delegate = self;
    _favoriteTableView.dataSource = self;
    
    _attributeArray = [[NSMutableArray alloc]init];
    _descriptionArray = [[NSMutableArray alloc]init];
    // for csv file
    _cardName = [[NSMutableArray alloc]init];
    _cardNoWithDiffLang = [[NSMutableArray alloc]init] ;
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SFC_content_formatted" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    xmlParser.delegate = self;
    BOOL successInParsingTheXMLDocument = [xmlParser parse];
    
    if(successInParsingTheXMLDocument)
    {
        NSLog(@"No Errors In Parsing ");
    }
    else
    {
        UIAlertView *noInternetConnectionAlert = [[UIAlertView alloc]initWithTitle:@"No Connection" message:@"Unable to retrieve data.An Internet Connection is required." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Learn More", nil];
        [noInternetConnectionAlert show];
    }
    
# pragma mark
#pragma more view setting 
    
    _moreTextView.text = @"\nContact the USAREUR SRP ITAM office for product support.\n\ne-mail:\nusareur.srp.contact@us.army.mil\nDSN : 314 475 8675\nCiv : +89 8876 88 5544\nFor additional products and services visit our websites:\nhttps://srp.usareur.army.mil\n\nMailing Address:\nHQ, 7th US Army JMTC\nAttn: AETT-TS(Bldg 3007)\nUnit 28130, Camp Normandy\nAPO AE 09554-8790\n   ";
    
    [self.moreScrollView setContentSize:CGSizeMake(_moreScrollView.frame.size.width, _moreScrollView.frame.size.height + 0)];
    self.moreScrollView.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:23.0/255.0 blue:21.0/255.0 alpha:1.0];
    
    _moreScrollView.layer.cornerRadius = 8;
    _moreScrollView.layer.masksToBounds = YES;
    
    self.moreTextView.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.moreTextView.backgroundColor = [UIColor clearColor];
    UIImage *imageView = [UIImage imageNamed:@"btn_request_normal.png"];
    [self.moreViewButton setImage:imageView forState:UIControlStateNormal];
    [_tableCell.plusButton addTarget:self action:@selector(requestProductButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
# pragma mark
#pragma CardsView setting
    
    [self.cardsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Bg.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    //self.navigationItem.titleView = label;
    self.navigationItem.title = @"All Field Cards";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:48.0/255.0 green:49.0/255.0 blue:37.0/255.0 alpha:1.0],UITextAttributeTextColor, nil]];
    label.text = @"All Field Cards";
    [label sizeToFit];
    _checkForTableViewHidden = YES;
    self.moreNavigationButton.hidden = YES;
    
    _listOfCards = [[NSMutableArray alloc]init]; 
    _numberOfRows = 14;
    _cardsTableView.backgroundColor = [UIColor blackColor];
    
    _cardsTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];   
    self.moreView.hidden = YES;
    self.favoritesView.hidden = YES;
    self.cardsTableView.backgroundColor = [UIColor clearColor];
    [self.cardsTableView reloadData];
    
    
# pragma favoriteView setting

    _favoritesView.backgroundColor = [UIColor clearColor];
    _favoriteTableView.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:23.0/255.0 blue:21.0/255.0 alpha:1.0];
    _favoriteTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _favoriteTableView.layer.cornerRadius = 8;
    _favoriteTableView.layer.masksToBounds = YES;
    
# pragma csv parsing
    
    FileReaderLineByLine * readerForGuidelinesCSV = [[FileReaderLineByLine alloc] initWithFilePath:@"/Users/deepakkumar/US SFC/Guidelines_Table.csv"];
    _lineOfGuidelineCSV = nil;
    
    while ((_lineOfGuidelineCSV = [readerForGuidelinesCSV readLine]))
    {
        NSArray* allLinedStrings = [_lineOfGuidelineCSV componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
        for (int i = 27; i<=612; i = i+27)
        {
            [_listOfCards addObject:[allLinedStrings objectAtIndex:i]];
        }
        NSLog(@"real count  = %d",[_listOfCards count]); 

        for (int j=0; j<18; j++)
        {
            if([[_listOfCards objectAtIndex:j] isEqualToString:[_listOfCards objectAtIndex:j+1]])
            {
                [_listOfCards removeObjectAtIndex:j+1];
                NSLog(@"language = %@",[allLinedStrings objectAtIndex:((27*(j+1))+5)]);
                NSLog(@"language = %@",[allLinedStrings objectAtIndex:((27*(j+2))+5)]);
            }
        }
       
        [self deleteAllEntities];
        [self storeGuidelineCSVDataToCoreData];
        [self fetchProductNameFromCoreData];
        [self.cardsTableView reloadData];
    }
    
}

- (void) deleteAllEntities
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityProduct = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Description" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entityProduct];
    
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *product in fetchedObjects) 
    {
        [_managedObjectContext deleteObject:product];
    }
    [fetchRequest setEntity:entityDescription];
    fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *description in fetchedObjects) 
    {
        [_managedObjectContext deleteObject:description];
    }
}


-(void) storeGuidelineCSVDataToCoreData
{
    NSInteger indexForCard,count;
    NSArray* allLinedStrings = [_lineOfGuidelineCSV componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
    for (count = 1; count <= 21; count++)
    {
        indexForCard =  count;
        
        Product *productObject = (Product *)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:_managedObjectContext];
        [productObject setName:[allLinedStrings objectAtIndex:indexForCard*27]];
        
        Description *descriptionObject = (Description *)[NSEntityDescription insertNewObjectForEntityForName:@"Description" inManagedObjectContext:_managedObjectContext];
        //NSLog(@"string at this place = %@",[allLinedStrings objectAtIndex:((indexForCard*27))]);
        [descriptionObject setSfc_name:[allLinedStrings objectAtIndex:indexForCard*27]];
        [descriptionObject setProduct_title:[allLinedStrings objectAtIndex:((indexForCard*27)+28)]];
        [descriptionObject setSlogan:[allLinedStrings objectAtIndex:((indexForCard*27)+29)]];
        [descriptionObject setSfc_main_title:[allLinedStrings objectAtIndex:((indexForCard*27)+30)]];
        [descriptionObject setSfc_subtitle:[allLinedStrings objectAtIndex:((indexForCard*27)+31)]];
        [descriptionObject setLanguage:[allLinedStrings objectAtIndex:((indexForCard*27)+32)]];
        [descriptionObject setAbout:[allLinedStrings objectAtIndex:((indexForCard*27)+33)]];
        [descriptionObject setMedevac:[allLinedStrings objectAtIndex:((indexForCard*27)+34)]];
        [descriptionObject setHazardous_material_and_pol:[allLinedStrings objectAtIndex:((indexForCard*27)+35)]];
        [descriptionObject setVehicle_movement:[allLinedStrings objectAtIndex:((indexForCard*27)+36)]];
        [descriptionObject setWassrack_procedures:[allLinedStrings objectAtIndex:((indexForCard*27)+37)]];
        [descriptionObject setTraining_area_dos_and_donts:[allLinedStrings objectAtIndex:((indexForCard*27)+38)]];
        [descriptionObject setFire_prevention:[allLinedStrings objectAtIndex:((indexForCard*27)+39)]];
        [descriptionObject setWildlife:[allLinedStrings objectAtIndex:((indexForCard*27)+40)]];
        [descriptionObject setPolicing_training_areas:[allLinedStrings objectAtIndex:((indexForCard*27)+41)]];
        [descriptionObject setIed_uxo_report:[allLinedStrings objectAtIndex:((indexForCard*27)+42)]];
        [descriptionObject setCamouflage:[allLinedStrings objectAtIndex:((indexForCard*27)+43)]];
        [descriptionObject setWeather:[allLinedStrings objectAtIndex:((indexForCard*27)+44)]];
        [descriptionObject setLegal:[allLinedStrings objectAtIndex:((indexForCard*27)+45)]];
        [descriptionObject setMedvac_to_hospital_instruction:[allLinedStrings objectAtIndex:((indexForCard*27)+46)]];
        [descriptionObject setDriving_directions:[allLinedStrings objectAtIndex:((indexForCard*27)+47)]];
        [descriptionObject setEnvironmental_services:[allLinedStrings objectAtIndex:((indexForCard*27)+48)]];
        [descriptionObject setAccidents_damages:[allLinedStrings objectAtIndex:((indexForCard*27)+49)]];
        [descriptionObject setJmrc_hohenhels_sfc:[allLinedStrings objectAtIndex:((indexForCard*27)+50)]];
        [descriptionObject setGeneral_info:[allLinedStrings objectAtIndex:((indexForCard*27)+51)]];
        
        //NSLog(@"product name from core data = %@",[_cardNameFromCoreData objectAtIndex:--indexForCard]);
        Product *productObjectForRelationship = productObject ;
        [descriptionObject setProductDescription:productObjectForRelationship];
       // NSLog(@"data are :%@",productObjectForRelationship.productDetail.sfc_main_title);
       // NSLog(@"hello");
        
    }
    NSError *error;
    if (![_managedObjectContext save:&error]) 
    {
        NSLog(@"couldn't save 1:%@",[error localizedDescription]);
    }

}



- (void) fetchProductNameFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedResults;
    
    if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        NSArray *fetchedName = [[NSArray alloc]init];
        fetchedName = fetchedResults;
        _cardNameFromCoreData = [fetchedName mutableCopy];
        NSMutableArray *productName = [[NSMutableArray alloc]init];

        for(Product *obj in fetchedResults)
         {
            [productName addObject:obj.name];
         }
        NSLog(@"before array are : %@",productName);
        NSMutableArray *cardNoToDelete = [[NSMutableArray alloc]init];
        NSInteger index1,index2;
        for (index1 = 0; index1 < [productName count]; index1++)
        {
            for (index2 = index1+1; index2 < [productName count]; index2++)
            {
                if ([[productName objectAtIndex:index1] isEqual:[productName objectAtIndex:index2]])
                {
                    [_cardNoWithDiffLang addObject:[NSNumber numberWithInteger:index1]];
                    [cardNoToDelete addObject:[NSNumber numberWithInteger:index2]];
                }
            }
        }
        _productNameUnique=[[NSMutableArray alloc]init];
        NSMutableArray *repeatedProductArray=[[NSMutableArray alloc]init];
        for( NSString *name in productName)
        {
            if(![_productNameUnique containsObject:name])
               {
                   [_productNameUnique addObject:name];
                   NSLog(@"new product array : %@",_productNameUnique);
               }
            else 
            {
                [repeatedProductArray addObject:name];
                NSLog(@"repeated product array : %@",repeatedProductArray);
            }
        }
        
        

        for (int count = 0; count < [cardNoToDelete count]; count++)
        {
            NSLog(@"position to delete = %d",[[cardNoToDelete objectAtIndex:count]integerValue]);
        }
   // NSLog(@"name of card are : %@",productName);
    NSLog(@"name of card with diffrent lang are : %@",_cardNoWithDiffLang);
    }
    else
    {
        NSLog(@"error : %@  and %@",[error description],[error userInfo]);  
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath;
{
    NSLog(@"integer value = %d",[[_cardNoWithDiffLang objectAtIndex:1]integerValue] );
    if(tableView == _favoriteTableView)
    {
        return 50;
    }
    
    else /*if (indexPath.row == [[_cardNoWithDiffLang objectAtIndex:0]integerValue] || indexPath.row == [[_cardNoWithDiffLang objectAtIndex:1]integerValue] || indexPath.row == [[_cardNoWithDiffLang objectAtIndex:2]integerValue])*/
    {
        if(indexPath.row==_selectedCellToExpand)
        {
        NSInteger heightForRow = 125;
        if( _checkForTableViewHidden == YES)
        {
            heightForRow = 50;
        }
        return heightForRow;
        }
    }
    return 50;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _favoriteTableView)
    {
        return [_storeFetchedName count];
    }
    else
    {
        NSLog(@"count = %d",[self.listOfCards count]);
        return [_productNameUnique count]; 
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(tableView == _favoriteTableView)
    {
        static NSString *cellId = @"actionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        NSLog(@"data= %@",_storeFetchedName);
        Favorites *favourite = [self.storeFetchedName objectAtIndex:indexPath.row];
        cell.textLabel.text = [favourite name];
        
        _accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)];
        _accessoryButton.tag = indexPath.row;
        UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
        [_accessoryButton setImage:imageView forState:UIControlStateNormal];
        [cell setAccessoryView:_accessoryButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0]; 
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
    else
    {
        static NSString *cellIdCustom = @"customCell";
        static NSString *cellIdNormal = @"normalCell";
        UITableViewCell *cell = nil;
        
        if (indexPath.row == [[_cardNoWithDiffLang objectAtIndex:0]integerValue] || indexPath.row == [[_cardNoWithDiffLang objectAtIndex:1]integerValue]|| indexPath.row == [[_cardNoWithDiffLang objectAtIndex:2]integerValue])
        {
            cell = [self.cardsTableView dequeueReusableCellWithIdentifier:cellIdCustom];
            
            if (cell == nil)
            {
                cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdCustom];
            }
            _tableCell = (TableViewCell *)cell;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            _tableCell.celldelegate = self;
            //Product *fetched = [_cardNameFromCoreData objectAtIndex:indexPath.row];
            _tableCell.cellDataLabel.text = [_productNameUnique objectAtIndex:indexPath.row];
            [_tableCell.insideTableView setTag:indexPath.row];
            _tableCell.index = indexPath.row;
            _tableCell.cardArrayForTableView = _listOfCards;
            if(_checkForTableViewHidden == YES)
            {
                UIImage *imageView = [UIImage imageNamed:@"icon_expand.png"];
                [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];
                [_tableCell.plusButton addTarget:self action:@selector(accessoryButtonExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
                [_tableCell.plusButton setTag:indexPath.row];
                
            }
            else 
            {
                if(indexPath.row==_selectedCellToExpand)
                {
                UIImage *imageView = [UIImage imageNamed:@"icon_collapse.png"];
                [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];
                [_tableCell.plusButton addTarget:self action:@selector(accessoryButtonCollapseTapped:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
            _tableCell.cellDataLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
            
            if(_checkForTableViewHidden == NO &&indexPath.row==_selectedCellToExpand)
            {
                _tableCell.insideTableView.hidden = NO;
            }
            else
            {
                _tableCell.insideTableView.hidden = YES;
            }
            return _tableCell;
        }
        else
        {
            cell = [self.cardsTableView dequeueReusableCellWithIdentifier:cellIdNormal];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdNormal];
            }
        }
        //Product *fetchedProduct = [self.cardNameFromCoreData objectAtIndex:indexPath.row];
        cell.textLabel.text = [_productNameUnique objectAtIndex:indexPath.row];
        _accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)]; 
        _accessoryButton.tag = indexPath.row;
        UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
        [_accessoryButton setImage:imageView forState:UIControlStateNormal];
        [_accessoryButton addTarget:self action:@selector(accessoryButtonDisclosureTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell setAccessoryView:_accessoryButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _favoriteTableView)
    {
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        CardDescription *pushForDescription1 = [storyboard instantiateViewControllerWithIdentifier:@"cardDescriptor"];
        Favorites *favourite = [self.storeFetchedName objectAtIndex:indexPath.row]; 
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",[favourite name]];
        [fetchRequest setPredicate:predicate];
        NSError *error;    
        NSArray *fetchedResults;
        
        if((fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
        {
            NSLog(@"favorite details are :%@",fetchedResults);
            _selectedProduct = [fetchedResults objectAtIndex:0];
            
            [self availableDescription];
            NSLog(@"about = %@",_attributeArray);
        }
        else
        {
            NSLog(@"error : %@  and %@",[error description],[error userInfo]);  
        }

        NSLog(@"sent data are = %@",[favourite name]);
        pushForDescription1.cardName = [favourite name];
        pushForDescription1.cardDetails = _attributeArray;
        [self.navigationController pushViewController:pushForDescription1 animated:YES];
    }
    NSLog(@"index path = %d",indexPath.row);
}

-(void) accessoryButtonDisclosureTapped:(UIButton *)sender
{
    //language remaining
    _selectedProduct = [_cardNameFromCoreData objectAtIndex:sender.tag];
    _selectedCardName = [_selectedProduct name];
    _selectedCardSubtitle = _selectedProduct.productDetail.sfc_subtitle;
    NSLog(@"at disclosure:%@",_selectedProduct.productDetail.about);
    
    NSLog(@"array of detail are before: %@",_attributeArray);

    [self availableDescription];
    [self performSegueWithIdentifier:@"Show Card Description Segue" sender:self];
}

-(void) availableDescription
{
    [_attributeArray removeAllObjects];
    if([_selectedProduct.productDetail.product_title length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.product_title];
        [_attributeArray addObject:@"Product Title"];
    }
    
    
    if([_selectedProduct.productDetail.slogan length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.slogan];
        [_attributeArray addObject:@"Slogan"];
    }
    
    if([_selectedProduct.productDetail.about length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.about];
        [_attributeArray addObject:@"About"];
    }
    
    if([_selectedProduct.productDetail.medevac length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.medevac];
        [_attributeArray addObject:@"Medevac"];
    }
    
    if([_selectedProduct.productDetail.hazardous_material_and_pol length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.hazardous_material_and_pol];
        [_attributeArray addObject:@"Hazardous Materials And POL"];
    }
    
    if([_selectedProduct.productDetail.vehicle_movement length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.vehicle_movement];
        [_attributeArray addObject:@"Vehicle Movement"];
    }
    
    if([_selectedProduct.productDetail.wassrack_procedures length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.wassrack_procedures];
        [_attributeArray addObject:@"Wassrack Procedures"];
    }
    
    if([_selectedProduct.productDetail.training_area_dos_and_donts length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.training_area_dos_and_donts];
        [_attributeArray addObject:@"Training Area DO's And DON'Ts"];
    }
    
    if([_selectedProduct.productDetail.fire_prevention length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.fire_prevention];
        [_attributeArray addObject:@"Fire Prevention"];
    }
    
    if([_selectedProduct.productDetail.wildlife length] > 0)
    {
        [_descriptionArray addObject: _selectedProduct.productDetail.wildlife];
        [_attributeArray addObject:@"Wildlife"];
    }
    
    if([_selectedProduct.productDetail.policing_training_areas length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.policing_training_areas];
        [_attributeArray addObject:@"Policing Training Areas"];
    }
    
    if([_selectedProduct.productDetail.ied_uxo_report length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.ied_uxo_report];
        [_attributeArray addObject:@"IED/UXO Report"];
    }
    
    if([_selectedProduct.productDetail.camouflage length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.camouflage];
        [_attributeArray addObject:@"Camouflage"];
    }
    
    if([_selectedProduct.productDetail.weather length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.weather];
        [_attributeArray addObject:@"Weather"];
    }
    
    if([_selectedProduct.productDetail.legal length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.legal];
        [_attributeArray addObject:@"Legal"];
    }
    
    if([_selectedProduct.productDetail.medvac_to_hospital_instruction length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.medvac_to_hospital_instruction];
        [_attributeArray addObject:@"Medevac To Hospital Instructions"];
    }
    
    if([_selectedProduct.productDetail.driving_directions length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.driving_directions];
        [_attributeArray addObject:@"Driving Directions"];
    }
    if([_selectedProduct.productDetail.environmental_services length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.environmental_services];
        [_attributeArray addObject:@"Environmental Services"];
    }
    
    if([_selectedProduct.productDetail.accidents_damages length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.accidents_damages];
        [_attributeArray addObject:@"Accidents Damages"];
    }
    
    if([_selectedProduct.productDetail.jmrc_hohenhels_sfc length] > 0)
    {
        [_descriptionArray addObject:_selectedProduct.productDetail.jmrc_hohenhels_sfc];
        [_attributeArray addObject:@"JMRC Hohenfels SFC"];
    }
    
    if([_selectedProduct.productDetail.general_info length] > 0)
    {
        [_descriptionArray addObject: _selectedProduct.productDetail.general_info];
        [_attributeArray addObject:@"General Info"];
    }
    
   // _selectedProduct = Nil;

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show Card Description Segue"])
    {
        CardDescription *next = (CardDescription *)[segue destinationViewController];
        next.cardName = _selectedCardName;
        next.cardSubTitle = _selectedCardSubtitle;
        next.cardDetails = _attributeArray;
        next.detailDescription = _descriptionArray;
    }
}

- (void) accessoryButtonCollapseTapped : (UIButton *) sender
{
    NSLog(@"getting");
    _checkForTableViewHidden = YES;
    [_cardsTableView reloadData];
}

- (UINavigationController *) sendNavigationControllerInstance
{
    NSLog(@"reference222 = %@",self.navigationController);
    return self.navigationController;
}

- (void) accessoryButtonExpandTapped:(UIButton *)sender
{
    NSLog(@"hello");
    NSLog(@"array11 = %@",_listOfCards);
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CardDescription *pushForDescription = [storyboard instantiateViewControllerWithIdentifier:@"cardDescriptor"];
    pushForDescription.cardName = [_listOfCards objectAtIndex:sender.tag];
    _checkForTableViewHidden = NO;
    NSLog(@"row selected = %d",sender.tag);
    _selectedCellToExpand = sender.tag;
    [_cardsTableView reloadData];
}

- (void) requestProductButtonTapped:(UIButton *)sender
{
    NSLog(@"requesting product");
}

- (void)viewDidUnload
{
    [self setFavoritesView:nil];
    [self setCardsView:nil];
    [self setMoreView:nil];
    [self setCardsTableView:nil]; 
    [self setMoreTextView:nil];
    [self setMoreScrollView:nil];
    [self setMoreViewButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showFavoriteView:(id)sender
{
    self.navigationItem.title = @"Favorites";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:48.0/255.0 green:49.0/255.0 blue:37.0/255.0 alpha:1.0],UITextAttributeTextColor, nil]];
    self.cardsView.hidden =YES;
    self.moreView.hidden = YES;
    [self fetchFromCoreData];
    [_favoriteTableView reloadData];
    self.favoritesView.hidden = NO;
    
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
        _storeFetchedName = [[NSMutableArray alloc]init];
        _storeFetchedName = [fetchedName mutableCopy];
        
        if([_storeFetchedName count])
        {
            NSLog(@"name of favorites are : %@",_storeFetchedName);
        }
    }
    else
    {
        NSLog(@"error : %@  and %@",[error description],[error userInfo]);  
    }
}


- (IBAction)showMoreOption:(id)sender 
{
    
    self.navigationItem.title = @"About";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:48.0/255.0 green:49.0/255.0 blue:37.0/255.0 alpha:1.0],UITextAttributeTextColor, nil]];

    self.moreView.backgroundColor = [UIColor clearColor];
    self.cardsView.hidden = YES;
    self.favoritesView.hidden = YES;
    self.moreView.hidden = NO;
    self.moreNavigationButton.hidden = NO;
    self.moreNavigationButton.titleLabel.textColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
}

- (IBAction)showAvailableCards:(id)sender 
{
    NSLog(@"hello");
    
    self.navigationItem.title = @"All Field Cards";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:48.0/255.0 green:49.0/255.0 blue:37.0/255.0 alpha:1.0],UITextAttributeTextColor, nil]];

    self.moreNavigationButton.hidden = YES;
    self.favoritesView.hidden = YES;
    self.moreView.hidden = YES;
    self.cardsView.hidden = NO;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
	
    if ([elementName isEqualToString:@"Data"])
    {
        self.test = YES;
        //    user = [[User alloc] init];
        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here: 
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
    
    if(self.test)
    {
        //        NSLog(@"%@",string);
        //        NSLog(@"be here");
    }
    //    if (!currentElementValue) {
    //        // init the ad hoc string with the value     
    //        currentElementValue = [[NSMutableString alloc] initWithString:string];
    //    } else {
    //        // append value to the ad hoc string    
    //        [currentElementValue appendString:string];
    //    }
    //   NSLog(@"Processing value for : %@", string);
}  


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{    
    if ([elementName isEqualToString:@"users"]) 
    {
        // We reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"user"]) 
    {
        // We are done with user entry – add the parsed user 
        // object to our user array
        //    [users addObject:user];
        // release user object
        //  user = nil;
    }
    else
    {
        // The parser hit one of the element values. 
        // This syntax is possible because User object 
        // property names match the XML user element names   
        //    [user setValue:currentElementValue forKey:elementName];
    }
    
    //[currentElementValue release];
    //currentElementValue = nil;
}

@end
