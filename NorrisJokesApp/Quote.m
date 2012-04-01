//
//  Quote.m
//  NorrisJokes
//
//  Created by Martin Markov on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quote.h"


@implementation Quote

@synthesize key;
@synthesize message;
@synthesize dateAdded;
@synthesize dateModified;
@synthesize plusVotes;
@synthesize minusVotes;

-(id)initWithID:(int)k Message:(NSString *)msg DateAdded:(NSDate *)dateA DateModified:(NSDate *)dateM PlusVotes:(int)pVotes MinusVotes:(int)mVotes{
    self = [super init];
    if(self) {
        self.key = k;
        self.message = msg;
        self.dateAdded = dateA;
        self.dateModified = dateM;
        self.plusVotes = pVotes;
        self.minusVotes = mVotes;
        
    }
    return self;
}

-(id)initWithQuote:(Quote *)q{
 
    self = [super init];
    if(self) {
        self.key = q.key;
        self.message = q.message;
        self.dateAdded = q.dateAdded;
        self.dateModified = q.dateModified;
        self.plusVotes = q.plusVotes;
        self.minusVotes = q.minusVotes;        
    }
    return self;
}

@end
