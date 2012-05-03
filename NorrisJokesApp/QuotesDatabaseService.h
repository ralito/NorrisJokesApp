//
//  QuotesDatabaseService.h
//  NorrisJokes
//
//  Created by Rali on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Quote.h"
@interface QuotesDatabaseService : NSObject{
    sqlite3 *_database;
}
@property (atomic, assign)sqlite3 *_database;
-(void)close;
-(NSArray*)getTopQuotes;
-(NSArray*)getRecentlyAdded;
-(NSArray*)searchByString:(NSString*)str;
-(Quote*)getRandomQuote;
-(void)addNewQuoteWithText:(NSString*)str;
-(void)changeQuote:(Quote*)q Votes:(int)str;
-(NSDate*)getDateModified;
-(void)updateQuote:(Quote*)q;

@end
