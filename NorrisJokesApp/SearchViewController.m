//
//  SearchViewController.m
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "sqlite3.h"
#import "QuotesDatabaseService.h"
#import "SearchViewController.h"

@implementation SearchViewController

@synthesize tableView;
@synthesize searchDisplayController;
@synthesize searchBar;

@synthesize allItems;
@synthesize searchResults;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
        
    QuotesDatabaseService *qdb = [[QuotesDatabaseService alloc]init];

    allItems = [[NSMutableArray alloc] initWithArray:[qdb searchByString:searchText]];
    NSLog(@"AllItems:%@",allItems);
    [self.tableView reloadData];

    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];
    if (allItems == nil) {
        allItems= [[NSMutableArray alloc]init];
    }
}


- (void)viewDidUnload
{
    [self setSearchDisplayController:nil];
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITable View
- (NSInteger)tableView:(UITableView *)tableV numberOfRowsInSection:(NSInteger)section
{
    
    return [allItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableV 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableV 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    /* Configure the cell. */
    cell.textLabel.text = [[self.allItems objectAtIndex:indexPath.row] message];
    
    return cell;
} 

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

@end
