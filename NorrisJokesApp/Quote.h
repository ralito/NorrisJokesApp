//
//  Quote.h
//  NorrisJokes
//
//  Created by Martin Markov on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject {
    
    int key;
    NSString *message;
    NSDate *dateAdded;
    NSDate *dateModified;
    int plusVotes;
    int minusVotes;
    
}

@property int key;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSDate *dateAdded;
@property (nonatomic, retain) NSDate *dateModified;
@property int plusVotes;
@property int minusVotes;

-(id)initWithID:(int)key Message:(NSString*)message DateAdded:(NSDate*)dateAdded DateModified:(NSDate*)dateModified PlusVotes:(int)plusVotes MinusVotes:(int)minusVotes; 
-(id)initWithQuote:(Quote*)q;

@end
