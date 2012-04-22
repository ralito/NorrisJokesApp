//
//  QuoteDetailsViewController.h
//  NorrisJokesApp
//
//  Created by Rali on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quote.h"
#import "QuotesDatabaseService.h"

@interface QuoteDetailsViewController : UIViewController {
    
    IBOutlet UITextView *QuoteText;
    IBOutlet UITextView *PlusVotes;
    IBOutlet UITextView *MinusVotes;
    IBOutlet UIButton *FavouritesButton;
    
    IBOutlet UIButton *DislikeButton;
    IBOutlet UIButton *LikeButton;
    Quote *q;
    QuotesDatabaseService *qdb;
}


- (IBAction)BackButton;
@property(nonatomic,retain)Quote *q;
- (IBAction)buttonPresed:(id)sender;


@end
