//
//  RandomQuoteViewController.h
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "QuotesDatabaseService.h"
#import "Quote.h"

@interface RandomQuoteViewController : UIViewController{
    QuotesDatabaseService *qdb;
    UITextView *random;
    IBOutlet UITextView *plusVotes;
    IBOutlet UITextView *minusVotes;
    IBOutlet UIButton *AddToFavouritesButton;
    Quote *quote;
    IBOutlet UIButton *likeButton;
    
    IBOutlet UIButton *DislikeButton;
}

@property (nonatomic, retain) IBOutlet UITextView *random;

- (IBAction)ButtonPresed:(id)sender;

@end
