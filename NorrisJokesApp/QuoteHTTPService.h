//
//  QuoteHTTPService.h
//  NorrisJokesApp
//
//  Created by Martin Markov on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"
#import "QuotesDatabaseService.h"

@interface QuoteHTTPService : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

-(NSArray*)getRecentlyAddedQuotes:(NSString*) date;
-(BOOL)addQuote: (NSString*) message;
-(BOOL)addVote:(int) vote toQuote:(Quote*)quote;
-(NSDate*)convertDateFromString:(NSString*)str;

@end
