//
//  FavouritesViewController.m
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavouritesViewController.h"
#import "Quote.h"
#import "QuoteDetailsViewController.h"

@implementation FavouritesViewController

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
    NSError *error;
    NSString *plistName = [[NSString alloc]initWithString:@"Favourites"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistName]]; 
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) 
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; 
    }
    if (arr == nil) {
        arr = [[NSMutableArray alloc]init];
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:path];
    for (int i = 0; i<[tempArray count]; i++) {
        NSData* objData = [tempArray objectAtIndex:i];
        Quote  *q = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
        [arr addObject:q];
    }
    
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
    
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Quote *q = [[Quote alloc]initWithQuote:[arr objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@",indexPath.row +1,[q message]];
    
    
    
    return cell;    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuoteDetailsViewController *quoteDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"QuoteDetailsIdentifier"];
    Quote *q1 = [[Quote alloc]initWithQuote:[arr objectAtIndex:indexPath.row]];
    quoteDetails.q = [[Quote alloc]initWithQuote:q1];
   [self.navigationController pushViewController:quoteDetails animated:YES];
}


@end
