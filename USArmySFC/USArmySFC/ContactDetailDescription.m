//
//  ContactDetailDescription.m
//  USArmySFC
//
//  Created by Deepak Kumar on 26/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactDetailDescription.h"


@implementation ContactDetailDescription

@synthesize contactTypeName = _contactTypeName;
@synthesize contactOfProductName = _contactOfProductName;
@synthesize backgroundImage = _backgroundImage;
@synthesize contactDetailView = _contactDetailView;
@synthesize contactDetailLabelForProduct = _contactDetailLabelForProduct;
@synthesize contactDetailLabelForContactType = _contactDetailLabelForContactType;
@synthesize contactDetailTableView = _contactDetailTableView;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize contactDetailDSN = _contactDetailDSN;
@synthesize contactDetailCivilion = _contactDetailCivilion;
@synthesize contactDetailFrequency = _contactDetailFrequency;
@synthesize contactDetailContactName = _contactDetailContactName;
@synthesize contactDetailsName = _contactDetailsName;
@synthesize productNameFromContactDetail = _productNameFromContactDetail;
@synthesize productIndex = _productIndex;
@synthesize cellTextLabelArray = _cellTextLabelArray;
@synthesize  cellTextDetailArray = _cellTextDetailArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    _contactDetailsName = [[NSMutableArray alloc]init];
    _contactDetailContactName = [[NSMutableArray alloc]init];
    _contactDetailFrequency = [[NSMutableArray alloc]init];
    _contactDetailCivilion = [[NSMutableArray alloc]init];
    _contactDetailDSN = [[NSMutableArray alloc]init];
    _cellTextDetailArray = [[NSMutableArray alloc]init];
    _cellTextLabelArray = [[NSMutableArray alloc]init];
    

    _contactDetailView.backgroundColor = [UIColor colorWithRed:16.0/255.0 green:23.0/255.0 blue:21.0/255.0 alpha:1.0];
    _contactDetailView.layer.cornerRadius = 10;
    _contactDetailView.layer.masksToBounds = YES;
    
    _contactDetailLabelForProduct.text = _contactOfProductName;
    _contactDetailLabelForContactType.text = _contactTypeName;
    _contactDetailLabelForProduct.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    _contactDetailLabelForContactType.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    //contact tableview setting
    _contactDetailTableView.delegate = self;
    _contactDetailTableView.dataSource = self;
    _contactDetailTableView.backgroundColor = [UIColor clearColor];
    _contactDetailTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    [self fetchContactDetailsFromCoreData];
    [self checkForIndexAndContactType];
}

-(void) checkForIndexAndContactType
{
    _productIndex = 0;
    NSLog(@"array to check are: %@",_productNameFromContactDetail);
    for (int i = 0; i<[_productNameFromContactDetail count]; i++)
    {
    
    if([_contactOfProductName isEqualToString:[_productNameFromContactDetail objectAtIndex:i]])
           {
               _productIndex = i;
           }
    }
    if([[_contactDetailDSN objectAtIndex:_productIndex] length] > 0)
    {
        [_cellTextLabelArray addObject:@"DSN"];
        [_cellTextDetailArray addObject:[_contactDetailDSN objectAtIndex:_productIndex]];
    }
    
    if([[_contactDetailCivilion objectAtIndex:_productIndex] length] > 0)
    {
        [_cellTextLabelArray addObject:@"CIVILION"];
        [_cellTextDetailArray addObject:[_contactDetailCivilion objectAtIndex:_productIndex]];
    }
    if([[_contactDetailFrequency objectAtIndex:_productIndex] length] > 0)
    {
        [_cellTextLabelArray addObject:@"FREQUENCY"];
        [_cellTextDetailArray addObject:[_contactDetailFrequency objectAtIndex:_productIndex]];
    }

    NSLog(@"conty are : %d",[_cellTextLabelArray count]);
        
}

-(void) fetchContactDetailsFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ContactType" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"contactName = %@",_contactTypeName];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchResults = [[NSArray alloc]init];
    NSError *error;
    if((fetchResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error]))
    {
        NSLog(@"===description are:%@",fetchResults);
        NSLog(@"cont are = %d",[fetchResults count]);
        NSLog(@"name==== %@",[fetchResults objectAtIndex:0]);
        for (ContactType *type in fetchResults)
        {
            [_contactDetailContactName addObject:type.contactDetail.contact];
            [_contactDetailDSN addObject:type.contactDetail.dsn];
            [_contactDetailFrequency addObject:type.contactDetail.frequency];
            [_contactDetailCivilion addObject:type.contactDetail.civilion];
        }
        NSLog(@"frequency no== %@",_contactDetailFrequency);
        NSLog(@"civilion no== %@",_contactDetailCivilion);
        NSLog(@"contact name== %@",_contactDetailContactName);
        NSLog(@"contact no== %@",_contactDetailDSN);

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cellTextLabelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellData = @"actionData";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellData];
    }
    cell.textLabel.text = [_cellTextLabelArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_cellTextDetailArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    return cell;
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

@end