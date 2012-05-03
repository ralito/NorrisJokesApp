//
//  RandomQuoteViewController.m
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RandomQuoteViewController.h"

@implementation RandomQuoteViewController
@synthesize random;

- (IBAction)ButtonPresed:(id)sender{
    UIButton *currentButton = (UIButton*) sender;
    currentButton.enabled = false;
    if (currentButton.tag == 1) {
        
        int flag=0;
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
        
        NSMutableArray *quotes = [NSMutableArray arrayWithContentsOfFile:path];
        
        if(quotes != nil){
          
            for (int i = 0; i<[quotes count]; i++) {
                NSData* objData = [quotes objectAtIndex:i];
                Quote  *q = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
                if (q.key == quote.key) {
                    flag=1;               
                }
            }
            if (flag!=1) {
                int lastItemIndex = [quotes count];            
                NSData* objData = [NSKeyedArchiver archivedDataWithRootObject:quote];
                [quotes insertObject:objData atIndex:lastItemIndex];
                [quotes writeToFile: path atomically:YES]; 
                AddToFavouritesButton.titleLabel.text = @"Remove from favourites";
            }
        } else {             
            quotes = [[NSMutableArray alloc]init];
            NSData* objData = [NSKeyedArchiver archivedDataWithRootObject:quote];
            [quotes insertObject:objData atIndex:0];
            [quotes writeToFile: path atomically:YES];
            AddToFavouritesButton.titleLabel.text = @"Remove from favourites";
        }
        
    } else if(currentButton.tag == 2){
        quote.plusVotes++;
        [qdb changeQuote:quote Votes:1];
        plusVotes.text = [NSString stringWithFormat:@"%d",quote.plusVotes];
    } else {
//        quote.minusVotes++;
//        [qdb changeQuote:quote Votes:2];
//        minusVotes.text = [NSString stringWithFormat:@"%d",quote.minusVotes]; 
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
        NSString *str = [[NSString alloc]initWithString:@"Thu Jan 12 19:32:30 EET 2012"];
        NSDate *formatterDate = [inputFormatter dateFromString:str];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
        NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
        
        
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateadded = [dateFormater dateFromString:newDateString]; 
        NSLog(@"%@",formatterDate);
    }
    
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
    qdb = [[QuotesDatabaseService alloc]init];
    quote = [[Quote alloc]initWithQuote:[qdb getRandomQuote]];
    random.text =quote.message;
    plusVotes.text = [NSString stringWithFormat:@"%d",quote.plusVotes];
    minusVotes.text = [NSString stringWithFormat:@"%d",quote.minusVotes];
    likeButton.enabled= true;
    DislikeButton.enabled=true;
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [qdb close];
    
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
    
}


- (void)viewDidUnload
{
    plusVotes = nil;
    minusVotes = nil;
    AddToFavouritesButton = nil;
    likeButton = nil;
    DislikeButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
