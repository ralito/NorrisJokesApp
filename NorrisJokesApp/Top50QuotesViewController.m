//
//  Top50QuotesViewController.m
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Top50QuotesViewController.h"
#import "Quote.h"
#import "QuoteDetailsViewController.h"
@implementation Top50QuotesViewController

-(void)initializeTableData{
    QuotesDatabaseService *qdb = [[QuotesDatabaseService alloc]init];
    tableData = [[NSMutableArray alloc] initWithArray:[qdb getTopQuotes]];
    //NSLog(@"Array:%@",tableData);
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

-(void)viewDidAppear:(BOOL)animated {
    [self initializeTableData];
    
}

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
    [self initializeTableData];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Quote *q = [[Quote alloc]initWithQuote:[tableData objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@",indexPath.row +1,[q message]];
    
    
    
    return cell;    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"bbb");
    QuoteDetailsViewController *quoteDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"QuoteDetailsIdentifier"];
    Quote *q1 = [[Quote alloc]initWithQuote:[tableData objectAtIndex:indexPath.row]];
    quoteDetails.q = [[Quote alloc]initWithQuote:q1];
    
    NSLog(@"bbb1");
    
   
    [self.navigationController pushViewController:quoteDetails animated:YES];
    NSLog(@"bbb2");
}

@end
