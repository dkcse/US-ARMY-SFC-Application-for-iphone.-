//
//  TableViewCell.m
//  USArmySFC
//
//  Created by Deepak Kumar on 13/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize insideTableView = _insideTableView;
@synthesize cellDataLabel = _cellDataLabel;
@synthesize plusButton = _plusButton;
@synthesize languageArray = _languageArray;
@synthesize divider = _divider;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        // Initialization code
       //_insideTableView.delegate = self;
       //_insideTableView.dataSource =self;
       // _insideTableView.hidden = YES;
       // _languageArray = [[NSArray alloc] initWithObjects:@"English",@"German",nil];
        //[_insideTableView reloadData];
        
//        UITableView *tbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 100) style:UITableViewStyleGrouped];
//        tbl.delegate = self;
//        tbl.dataSource = self;
//        [self addSubview:tbl];
                         
            }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{   _insideTableView.delegate = self;
    _insideTableView.dataSource =self;
    _insideTableView.backgroundColor = [UIColor clearColor];

    // _insideTableView.hidden = YES;
    _languageArray = [[NSArray alloc] initWithObjects:@"English",@"German",nil];
    [_insideTableView reloadData];
    
    
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
    self.divider.image = [UIImage imageNamed:@"note_divider.png"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [self.languageArray objectAtIndex:indexPath.row]; 
    cell.textLabel.textColor = [UIColor colorWithRed:141.0/255.0 green:255.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 100, 28, 40)]; 
    UIImage *imageView = [UIImage imageNamed:@"arrow.png"];
    [accessoryButton setImage:imageView forState:UIControlStateNormal];
    [accessoryButton addTarget:self action:@selector(accessoryButtonDisclosureTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:accessoryButton];

    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}


-(void) accessoryButtonDisclosureTapped:(UIButton *)sender
{
    NSLog(@"tapped");
}





#pragma mark -
#pragma mark Dealloc


@end