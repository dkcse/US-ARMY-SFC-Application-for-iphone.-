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
@synthesize test = _test;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cardsTableView.delegate = self;
    _cardsTableView.dataSource = self;
    _favoriteTableView.delegate = self;
    _favoriteTableView.dataSource = self;
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];

   // NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:];
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
    self.moreScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];
    self.moreTextView.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    //[UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    self.moreTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];
   // self.moreViewButton.backgroundColor = [UIColor blackColor];
    //self.moreViewButton.titleLabel.textColor = [UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    //self.moreViewButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];

    UIImage *imageView = [UIImage imageNamed:@"btn_request_normal.png"];
    [self.moreViewButton setImage:imageView forState:UIControlStateNormal];
    [_tableCell.plusButton addTarget:self action:@selector(requestProductButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
   // _moreView.hidden = YES;
    
# pragma mark
#pragma CardsView setting
    
    [self.cardsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Bg.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];

    self.navigationItem.titleView = label;
    label.text = @"All Field Cards";
    [label sizeToFit];
    _checkForTableViewHidden = YES;
    
    self.moreNavigationButton.hidden = YES;
    _listOfCards = [NSMutableArray arrayWithObjects:@"Grafenwoehr Training Area",@"JMRC Hohenfels",@"TSC Ansbach",@"TSC Bamberg",@"TSC Baumholder",@"TSC Heidelberg",@"TSC Kaiserslautern",@"TSC Kosovo",@"TSC Mannheim",@"TSC Romania",@"TSC Schweinfurt",@"TSC Stuttgart",@"TSC Wiesbaden",@"Slunj TA (Croatia)",nil];
    
    _numberOfRows = 14;
    _cardsTableView.backgroundColor = [UIColor blackColor];
   
   _cardsTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];   // self.cardsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg.png"]];
    //self.cardsView.hidden = YES;
    self.moreView.hidden = YES;
    self.favoritesView.hidden = YES;
    self.cardsTableView.backgroundColor = [UIColor clearColor];
    [self.cardsTableView reloadData];
    
    
# pragma favoriteView setting
    
    _favoritesView.backgroundColor = [UIColor clearColor];
   // _favoriteTableView.backgroundColor = [UIColor clearColor];
    _favoriteTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];
    _favoriteTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    
    
# pragma csv parsing
    
    //NSString *dataStr = [NSString stringWithContentsOfFile:@"Contacts-Table.csv" encoding:NSUTF8StringEncoding error:nil];
    //NSArray *array = [dataStr componentsSeparatedByString: @","];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err = nil;
    NSArray *fileList = [manager contentsOfDirectoryAtPath:documentsDirectory error:&err];
    NSString *fileName = [fileList objectAtIndex:1];
    NSURL *inputFileURL = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingPathComponent:fileName]];
    
    
    NSStringEncoding encoding = 0;
    CHCSVParser *pa = [[CHCSVParser alloc]initWithContentsOfCSVFile:@"Contacts-Table.csv" encoding:NSUTF8StringEncoding error:nil];

    //CHCSVParser *p = [[CHCSVParser alloc] initWithContentsOfCSVFile:[inputFileURL path] usedEncoding:&encoding error:nil];

    [pa setParserDelegate:(id)self];
    [pa parse];

	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath;
{
    if(tableView == _favoriteTableView)
    {
        return 50;
    }
    else if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        NSInteger heightForRow = 125;
        
        if( _checkForTableViewHidden == YES)
        {
            heightForRow = 50;
        }
        return heightForRow;
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
       return [self.listOfCards count]; 
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
    
    if(indexPath.row == 0)
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_top.png"]];
    }
    else if (indexPath.row == [_listOfCards count]) 
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bottom.png"]];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_middle.png"]];
    }
    
    
    
    
    
    
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        cell = [self.cardsTableView dequeueReusableCellWithIdentifier:cellIdCustom];
        
		if (cell == nil)
		{
			cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdCustom];
		}
        
        _tableCell = (TableViewCell *)cell;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        _tableCell.celldelegate = self;
		_tableCell.cellDataLabel.text = [_listOfCards objectAtIndex:indexPath.row];
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
            UIImage *imageView = [UIImage imageNamed:@"icon_collapse.png"];
            [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];
            [_tableCell.plusButton addTarget:self action:@selector(accessoryButtonCollapseTapped:) forControlEvents:UIControlEventTouchUpInside];


        }
		_tableCell.cellDataLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
        
        
        if(_checkForTableViewHidden == YES)

           {
               _tableCell.insideTableView.hidden = YES;
           }
        else
           {
            _tableCell.insideTableView.hidden = NO;
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
    
    cell.textLabel.text = [_listOfCards objectAtIndex:indexPath.row];
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
        
        NSLog(@"sent data are = %@",[favourite name]);
        pushForDescription1.cardName = [favourite name];
        [self.navigationController pushViewController:pushForDescription1 animated:YES];
    }
    NSLog(@"index path = %d",indexPath.row);
}

-(void) accessoryButtonDisclosureTapped:(UIButton *)sender
{
    NSLog(@"tapped");
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    
    CardDescription *pushForDescription = [storyboard instantiateViewControllerWithIdentifier:@"cardDescriptor"];
    NSLog(@"row selected = %d",sender.tag);
    NSLog(@"at index selected = %@",[_listOfCards objectAtIndex:sender.tag]);
    pushForDescription.cardName = [_listOfCards objectAtIndex:sender.tag];

    [self.navigationController pushViewController:pushForDescription animated:YES];
    
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
    [_cardsTableView reloadData];
    
//   // TableViewCell *dataToTableCell = [[TableViewCell alloc]init];
//    dataToTableCell.index = sender.tag;
//    dataToTableCell.cardArrayForTableView = _listOfCards;
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
    self.cardsView.hidden =YES;
    self.moreView.hidden = YES;
    [self fetchFromCoreData];
    [_favoriteTableView reloadData];
    self.favoritesView.hidden = NO;

}

- (void) fetchFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
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
    self.moreView.backgroundColor = [UIColor clearColor];
    self.cardsView.hidden = YES;
    self.favoritesView.hidden = YES;
    self.moreView.hidden = NO;
    self.moreNavigationButton.hidden = NO;
    //self.moreNavigationButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_btn_feedback_normal.png"]];
    
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
        NSLog(@"%@",string);
        NSLog(@"be here");
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





#pragma mark -
#pragma mark CHCSVParserDelegate methods

- (void) parser:(CHCSVParser *)parser didStartDocument:(NSString *)csvFile {
    NSLog(@"Parser started!");
}

- (void) parser:(CHCSVParser *)parser didStartLine:(NSUInteger)lineNumber {
    //NSLog(@"Parser started line: %i", lineNumber);
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber {
    NSLog(@"Parser ended line: %i", lineNumber);
}

- (void) parser:(CHCSVParser *)parser didReadField:(NSString *)field {
    //NSLog(@"Parser didReadField: %@", field);
}

- (void) parser:(CHCSVParser *)parser didEndDocument:(NSString *)csvFile {
    NSLog(@"Parser ended document: %@", csvFile);
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Parser failed with error: %@ %@", [error localizedDescription], [error userInfo]);
}

@end
