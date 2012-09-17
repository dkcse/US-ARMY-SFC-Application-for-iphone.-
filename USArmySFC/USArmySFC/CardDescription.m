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
@property (nonatomic) NSInteger pressCount;
@property (nonatomic) BOOL favoriteImageStatus;

@end

@implementation CardDescription

@synthesize pressCount = _pressCount;
@synthesize cardLogoImage = _cardLogoImage;
@synthesize cardNameLabel = _cardNameLabel;
@synthesize favoriteSelectionImage = _favoriteSelectionImage;
@synthesize cardDescriptionTableView = _cardDescriptionTableView;
@synthesize description = _description;
@synthesize descriptionArray1 = _descriptionArray1;
@synthesize descriptionArray2 = _descriptionArray2;
@synthesize cardName = _cardName;
@synthesize tapToAddIntoFavorites = _tapToAddIntoFavorites;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize favoriteImageStatus = _favoriteImageStatus;

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

-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"hello");
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
    _cardNameLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];

    
    _descriptionArray1 = [[NSArray alloc]initWithObjects:@"About",@"Enter Services",@"Fire Prevention",@"Hazardous Materials and POL",@"Training Areas DOs And DON'Ts",@"Vehicle Movement",@"Washrack Procedure", nil];
    _descriptionArray2 = [[NSArray alloc] initWithObjects:@"Risk Assessment Model", nil];
    
    _description = [[NSArray alloc]initWithObjects:_descriptionArray1,_descriptionArray2,nil];
     _cardDescriptionTableView.backgroundColor = [UIColor clearColor];
    [self.cardDescriptionTableView reloadData];
    
}

                                         
                                         
                                         
- (BOOL) searchForNameInCoreData:(NSString *)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
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
    else {
        return NO;
    }
}
                                         
                                         
                                         
                                         
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"hello");
    
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];

    
    
    _pressCount = 0;
    self.cardDescriptionTableView.delegate = self;
    self.cardDescriptionTableView.dataSource = self;
   
    _favoriteSelectionImage.userInteractionEnabled = YES;
    _tapToAddIntoFavorites.delegate = self;
    _tapToAddIntoFavorites = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapToAddIntoFavorites:)];
    [self.favoriteSelectionImage addGestureRecognizer:_tapToAddIntoFavorites];
    

    _descriptionArray1 = [[NSArray alloc]initWithObjects:@"About",@"Enter Services",@"Fire Prevention",@"Hazardous Materials and POL",@"Training Areas DOs And DON'Ts",@"Vehicle Movement",@"Washrack Procedure", nil];
    _descriptionArray2 = [[NSArray alloc] initWithObjects:@"Risk Assessment Model", nil];
    
    _description = [[NSArray alloc]initWithObjects:_descriptionArray1,_descriptionArray2,nil];
    [self.cardDescriptionTableView reloadData];
    
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
    
    else {
        _pressCount++;
        _favoriteSelectionImage.image = [UIImage imageNamed:@"star_normal.png"];
        [self deleteFromCoreData];
    }
    
}


- (void) deleteFromCoreData
{
    NSLog(@"delete called");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Favorite" inManagedObjectContext:_managedObjectContext];
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




- (BOOL) fetchFromCoreData
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
    
    cell.textLabel.text = [menu objectAtIndex:indexPath.row];
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


- (void) accessoryButtonDisclosureTapped : (UIButton *)sender
{
    NSLog(@"hello disclosure pressed");
    
    
}


@end