//
//  QuoteDetailsViewController.m
//  NorrisJokesApp
//
//  Created by Rali on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuoteDetailsViewController.h"

@implementation QuoteDetailsViewController
@synthesize q;

-(IBAction)BackButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)buttonPresed:(id)sender{
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
                Quote  *q1 = [NSKeyedUnarchiver unarchiveObjectWithData:objData];
                if (q1.key == q.key) {
                    flag=1;               
                }
            }
            if (flag!=1) {
                int lastItemIndex = [quotes count];            
                NSData* objData = [NSKeyedArchiver archivedDataWithRootObject:q];
                [quotes insertObject:objData atIndex:lastItemIndex];
                [quotes writeToFile: path atomically:YES]; 
                FavouritesButton.titleLabel.text = @"Remove from favourites";
            }
        } else {             
            quotes = [[NSMutableArray alloc]init];
            NSData* objData = [NSKeyedArchiver archivedDataWithRootObject:q];
            [quotes insertObject:objData atIndex:0];
            [quotes writeToFile: path atomically:YES];
            FavouritesButton.titleLabel.text = @"Remove from favourites";
        }
        
    } else if(currentButton.tag == 2){
        q.plusVotes++;
        [qdb changeQuote:q Votes:1];
        PlusVotes.text = [NSString stringWithFormat:@"%d",q.plusVotes];
    } else {
                q.minusVotes++;
                [qdb changeQuote:q Votes:2];
                MinusVotes.text = [NSString stringWithFormat:@"%d",q.minusVotes]; 

//        NSString *str = [[NSString alloc]initWithString:@"Thu Jan 12 19:32:30 EET 2012"];
//        NSString *str2 = [[NSString alloc]initWithString:[str substringFromIndex:4]];
//        str2 = [str2 substringToIndex:16];
//        NSString *str3 = [[NSString alloc]initWithString:[str2 stringByAppendingString:[str substringFromIndex:24]]];
//        NSLog(@"STR:%@",str3);
//          NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
//        [dateFormater setDateFormat:@"MMM dd HH:mm:ss yyyy"];
//        NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:+2];
//        [dateFormater setTimeZone:timeZone];
//        NSDate *dateadded = [dateFormater dateFromString:str3];
//        NSLog(@"STR:%@",str2);
//        NSLog(@"%@",dateadded );
        
        //NSDateFormatter *secontdateFormater = [[NSDateFormatter alloc]init];
//        [dateFormater setDateFormat:@"yyyy/MM/dd"];
//        [dateFormater setFormatterBehavior:NSDateFormatterBehaviorDefault];
//        NSString *stringFromDate = [[NSString alloc]initWithString:[dateFormater stringFromDate:[qdb getDateModified]]];
//    
       // NSLog(@"LAST STR:%@",[qdb getDateModified]);
        
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)viewDidAppear:(BOOL)animated {
    qdb = [[QuotesDatabaseService alloc]init];    
}
-(void)viewDidDisappear:(BOOL)animated {
    [qdb close];
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //qdb = [[QuotesDatabaseService alloc]init];
    QuoteText.text = q.message;
    PlusVotes.text = [NSString stringWithFormat:@"%d",q.plusVotes];
    MinusVotes.text = [NSString stringWithFormat:@"%d",q.minusVotes];
    
    
}


- (void)viewDidUnload
{
    QuoteText = nil;
    PlusVotes = nil;
    MinusVotes = nil;
    FavouritesButton = nil;
    LikeButton = nil;
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
