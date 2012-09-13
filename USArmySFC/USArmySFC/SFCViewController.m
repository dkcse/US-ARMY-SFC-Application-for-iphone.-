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
@property (nonatomic) NSInteger indexRow;
@property (nonatomic) NSInteger numberOfRows;
@property (nonatomic) BOOL checkForTableViewHidden;
@property (strong,nonatomic) TableViewCell *tableCell;
@end

@implementation SFCViewController

@synthesize listOfCards = _listOfCards;
@synthesize favoritesView = _favoritesView;
@synthesize cardsView = _cardsView;
@synthesize moreView = _moreView;
@synthesize cardsTableView = _cardsTableView;
@synthesize cardWithLanguage = _cardWithLanguage;
@synthesize indexRow = _indexRow;
@synthesize numberOfRows = _numberOfRows;
@synthesize checkForTableViewHidden = _checkForTableViewHidden;
@synthesize tableCell = _tableCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cardsTableView.delegate = self;
    _cardsTableView.dataSource = self;
    self.cardsTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    //self.cardsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //self.cardsTableView.separatorColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"note_divider.png"]];
    
    _checkForTableViewHidden = YES;
    _listOfCards = [NSMutableArray arrayWithObjects:@"Grafenwoehr Training Area",@"JMRC Hohenfels",@"TSC Ansbach",@"TSC Bamberg",@"TSC Baumholder",@"TSC Heidelberg",@"TSC Kaiserslautern",@"TSC Kosovo",@"TSC Mannheim",@"TSC Romania",@"TSC Schweinfurt",@"TSC Stuttgart",@"TSC Wiesbaden",@"Slunj TA (Croatia)",nil];
    
    _numberOfRows = 14;
    _cardsTableView.backgroundColor = [UIColor blackColor];
    _cardsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.cardsView addSubview:_cardsTableView];
    
    [self.cardsTableView reloadData];
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath;
{
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        NSInteger heightForRow = 120;
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
    return [self.listOfCards count];
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{    
//    return [self.listOfCards count];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIdCustom = @"customCell";
    static NSString *cellIdNormal = @"normalCell";
    UITableViewCell *cell = nil;
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 6)
    {
        cell = [self.cardsTableView dequeueReusableCellWithIdentifier:cellIdCustom];
		if (cell == nil)
		{
			cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdCustom];
		}
        _tableCell = (TableViewCell *)cell;
        NSLog(@"cellval = %@",_tableCell.cellDataLabel.text);
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		_tableCell.cellDataLabel.text = [_listOfCards objectAtIndex:indexPath.row];
        NSLog(@"label = %@",[_listOfCards objectAtIndex:indexPath.row]);
       // tableCell.plusButton.frame = 
        
        if(_checkForTableViewHidden == YES)
        {
        UIImage *imageView = [UIImage imageNamed:@"icon_expand.png"];
        [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];
        [_tableCell.plusButton addTarget:self action:@selector(accessoryButtonPlusTapped:) forControlEvents:UIControlEventTouchUpInside];
        //[cell setAccessoryView:tableCell.plusButton];
        }
        else {
            UIImage *imageView = [UIImage imageNamed:@"icon_collapse.png"];
            [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];

        }
		_tableCell.cellDataLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
        
        
        //tableCell.insideTableView.hidden = YES;
        if(_checkForTableViewHidden == YES)
           {
               _tableCell.insideTableView.hidden = YES;
           }
        else {
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
    
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)]; 
    UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
    [accessoryButton setImage:imageView forState:UIControlStateNormal];
    [accessoryButton addTarget:self action:@selector(accessoryButtonDisclosureTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:accessoryButton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 /*   if(cell.textLabel.text == @"JMRC Hohenfels" || cell.textLabel.text == @"TSC Bamberg" || cell.textLabel.text == @"TSC Kaiserslautern")
    {
        UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 38, 40)];
        UIImage *imageView = [UIImage imageNamed:@"icon_expand.png"];
        [accessoryButton setImage:imageView forState:UIControlStateNormal];
        [accessoryButton addTarget:self action:@selector(accessoryButtonPlusTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell setAccessoryView:accessoryButton];
    }
    
   */ 
    cell.textLabel.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    //cell.detailTextLabel.text = [self.descriptionOfItems objectAtIndex:indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index path = %d",indexPath.row);
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
    
    // create the button object
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor whiteColor];
    headerBtn.opaque = YES;
    headerBtn.frame = CGRectMake(0.0, 0.0, 320.0, 30.0);
    headerBtn.tag = section;
    [headerBtn setTitle:@"hellodk" forState:UIControlStateNormal];
    [headerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [headerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [headerBtn setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bg.png"]]];
    [customView addSubview:headerBtn];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
    button.frame = CGRectMake(180.0, 0.0, 240, 30.0);
    [button setImage:[UIImage imageNamed:@"icon_expand.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(collapse:) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button];
    return customView;
}

*/

-(void) accessoryButtonDisclosureTapped:(UIButton *)sender
{
    NSLog(@"tapped");
}

- (void) accessoryButtonPlusTapped:(UIButton *)sender
{
    NSLog(@"hello");
    NSLog(@"array11 = %@",_listOfCards);
    _checkForTableViewHidden = NO;
    
    [_cardsTableView reloadData];
    
   
    
    
        
//        NSMutableArray *languageArray = [[NSMutableArray alloc]initWithObjects:@"English",@"German",nil];
//        if(_cardWithLanguage == @"JMRC Hohenfels")
//        {
//            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:2];
//            [indexes addIndex:3];
//            [_listOfCards insertObjects:languageArray atIndexes:indexes];
//            NSLog(@"array = %@",_listOfCards);
//
//            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],nil];
//            [_cardsTableView insertRowsAtIndexPaths:(NSMutableArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
//
//        }
//        else if (_cardWithLanguage == @"TSC Bamberg") 
//        {
//             NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:4];
//             [indexes addIndex:3];
//             [_listOfCards insertObjects:languageArray atIndexes:indexes];
//            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForRow:3 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],nil];
//            [_cardsTableView insertRowsAtIndexPaths:(NSMutableArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
//
//        }
//        else 
//        {
//            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:2];
//            [indexes addIndex:3];
//            [_listOfCards insertObjects:languageArray atIndexes:indexes];
//            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:[NSIndexPath indexPathForRow:1 inSection:0],[NSIndexPath indexPathForRow:2 inSection:0],nil];
//            [_cardsTableView insertRowsAtIndexPaths:(NSMutableArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
       // }
           // }
    
   // _listOfCards = [NSArray arrayWithObjects:@"Grafenwoehr Training Area",@"JMRC Hohenfels",@"English",@"TSC Ansbach",@"TSC Bamberg",@"German",@"TSC Baumholder",@"TSC Heidelberg",@"TSC Kaiserslautern",@"English",@"TSC Kosovo",@"TSC Mannheim",@"TSC Romania",@"TSC Schweinfurt",@"TSC Stuttgart",@"TSC Wiesbaden",@"Slunj TA (Croatia)",nil];

        [_cardsTableView reloadData];
     //NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    //[tempArray addObject:@"New Item"];
    //NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[tempArray count] inSection:0];
    // [[self cardsTableView] beginUpdates];
   // [[self cardsTableView] insertRowsAtIndexPaths:(NSArray*) tempArray withRowAnimation:UITableViewRowAnimationNone];
   // [[self cardsTableView] endUpdates];

}



- (void)viewDidUnload
{
    [self setFavoritesView:nil];
    [self setCardsView:nil];
    [self setMoreView:nil];
    [self setCardsTableView:nil];
 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
