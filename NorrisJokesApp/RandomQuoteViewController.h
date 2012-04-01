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

@interface RandomQuoteViewController : UIViewController{
    UITextView *random;
}

@property (nonatomic, retain) IBOutlet UITextView *random;

@end
