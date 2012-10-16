//
//  SFCCustomCellForFavoritesTable.m
//  USArmySFC
//
//  Created by Deepak Kumar on 16/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFCCustomCellForFavoritesTable.h"

#import "SFCAppDelegate.h"

@implementation SFCCustomCellForFavoritesTable

@synthesize insideTableView = _insideTableView;
@synthesize cellDataLabel = _cellDataLabel;
@synthesize plusButton = _plusButton;
@synthesize languageArray = _languageArray;
@synthesize divider = _divider;
@synthesize celldelegate = _celldelegate;
@synthesize index = _index;
@synthesize cardArrayForTableView = _cardArrayForTableView;
@synthesize productNameFromMainView = _productNameFromMainView;
@synthesize languageArrayFromMainView = _languageArrayFromMainView;
@synthesize attributeArray = _attributeArray;
@synthesize descriptionArray = _descriptionArray;
@synthesize selectedRow = _selectedRow;
@synthesize description = _description;
@synthesize selectedProduct = _selectedProduct;
@synthesize managedObjectContext = _managedObjectContext;

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews
{ 
    id appDelegate = (id)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    _cellDataLabel.backgroundColor = [UIColor clearColor];
    _insideTableView.delegate = self;
    _insideTableView.dataSource =self;
    _insideTableView.backgroundColor = [UIColor clearColor];
    if([_languageArrayFromMainView count] > 0)
    {
        _languageArray  = _languageArrayFromMainView;
    }
    else 
    {
        _languageArray = [[NSMutableArray alloc] initWithObjects:@"English",@"German",nil];
    }    
    [_insideTableView reloadData];
    _insideTableView.separatorColor = [UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section;
{
    return[self.languageArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath;
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellId = @"actionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    self.divider.backgroundColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];  
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    cell.textLabel.numberOfLines = 1;
    [cell.textLabel sizeToFit];
    
    cell.textLabel.text = [self.languageArray objectAtIndex:indexPath.row]; 
    cell.textLabel.textColor = [UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)]; 
    UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
    [accessoryButton setImage:imageView forState:UIControlStateNormal];
    [accessoryButton addTarget:self action:@selector(accessoryButtonDisclosureTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:accessoryButton];
    accessoryButton.tag = indexPath.row;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void) accessoryButtonDisclosureTapped:(UIButton *)sender
{
    DLog(@"accessory button pressed");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",[[_productNameFromMainView objectAtIndex:_selectedRow]valueForKey:@"name"]];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *fetchedResults = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(([fetchedResults count] > 0))
    {
        NSArray *fetchedName = [[NSArray alloc]init];
        fetchedName = fetchedResults;
        // NSMutableArray *productName = [[NSMutableArray alloc]init];
        
        for(Product *obj in fetchedResults)
        {
            NSString *language = [_languageArray objectAtIndex:indexPath.row];
            if([[obj.productDetail.language stringByRemoveLeadingAndTrailingQuotes] isEqualToString:language])
            {
                _selectedProduct = obj;
            }
        }
    }
    else
    {
        DLog(@"error : %@  and %@",[error description],[error userInfo]);  
    }
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    CardDescription *pushForDescriptionCustom = [story instantiateViewControllerWithIdentifier:@"cardDescriptor"];
    UINavigationController *referenceToNavController = [[UINavigationController alloc]init];
    pushForDescriptionCustom.productNameFromSFCView = _productNameFromMainView;
    pushForDescriptionCustom.selectedProductRowNo = _selectedRow;
    _description = [_celldelegate sendAttributeAndDescription:_selectedProduct];
    
    pushForDescriptionCustom.cardDetails = [[_description allKeys].mutableCopy objectAtIndex:0];
    pushForDescriptionCustom.detailDescription = [[_description allValues].mutableCopy objectAtIndex:0];
    referenceToNavController = [_celldelegate sendNavigationControllerInstance];
    [referenceToNavController pushViewController:pushForDescriptionCustom animated:YES];
}
@end