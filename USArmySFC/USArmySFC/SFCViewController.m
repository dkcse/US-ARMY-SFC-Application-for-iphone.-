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
@property (strong,nonatomic) UIButton *accessoryButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cardsTableView.delegate = self;
    _cardsTableView.dataSource = self;

# pragma mark
#pragma more view setting 
    
    _moreTextView.text = @"\nContact the USAREUR SRP ITAM office for product support.\n\ne-mail:\nusareur.srp.contact@us.army.mil\nDSN : 314 475 8675\nCiv : +89 8876 88 5544\nFor additional products and services visit our websites:\nhttps://srp.usareur.army.mil\n\nMailing Address:\nHQ, 7th US Army JMTC\nAttn: AETT-TS(Bldg 3007)\nUnit 28130, Camp Normandy\nAPO AE 09554-8790\n   ";
    
    [self.moreScrollView setContentSize:CGSizeMake(_moreScrollView.frame.size.width, _moreScrollView.frame.size.height + 40)];
    self.moreScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];
    self.moreTextView.textColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
    //[UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    self.moreTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Bg2.png"]];
    self.moreViewButton.backgroundColor = [UIColor clearColor];
    self.moreViewButton.titleLabel.textColor = [UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];

   // _moreView.hidden = YES;
    
# pragma mark
#pragma CardsView setting
    
    
    self.cardsTableView.separatorColor = [UIColor colorWithRed:0.7/255.0 green:219.0/255.0 blue:137.0/255.0 alpha:1.0];
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
    
    //self.cardsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //self.cardsTableView.separatorColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"note_divider.png"]];
    //self.title = @"All Field Cards";
    //label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"Bg.png"]];
    // [self.navigationController setTitle: @"All Field Cards"];
    
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        _tableCell.celldelegate = self;
		_tableCell.cellDataLabel.text = [_listOfCards objectAtIndex:indexPath.row];
        [_tableCell.insideTableView setTag:indexPath.row];
        if(_checkForTableViewHidden == YES)
        {
        UIImage *imageView = [UIImage imageNamed:@"icon_expand.png"];
        [_tableCell.plusButton setImage:imageView forState:UIControlStateNormal];
        [_tableCell.plusButton addTarget:self action:@selector(accessoryButtonExpandTapped:) forControlEvents:UIControlEventTouchUpInside];
            [_tableCell.plusButton setTag:indexPath.row];
        //[cell setAccessoryView:tableCell.plusButton];
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
    _checkForTableViewHidden = NO;
    NSLog(@"row selected = %d",sender.tag);
    [_cardsTableView reloadData];
    
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
}

- (IBAction)showMoreOption:(id)sender 
{
    self.cardsView.hidden = YES;
    self.favoritesView.hidden = YES;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (IBAction)showAvailableCards:(id)sender 
{
    self.favoritesView.hidden = YES;
    self.moreView.hidden = YES;
}
@end
