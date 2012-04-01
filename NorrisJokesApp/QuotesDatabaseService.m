//
//  QuotesDatabaseService.m
//  NorrisJokes
//
//  Created by Rali on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuotesDatabaseService.h"
#import "Quote.h"
@implementation QuotesDatabaseService
@synthesize _database;
- (id)init {
    NSString *documentsDirectory = [[NSString alloc]init];
    if ((self = [super init])) {
        BOOL success;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
        //NSLog(@"RALICA:%@",writableDBPath);
        [writableDBPath stringByExpandingTildeInPath];
        success = [fileManager fileExistsAtPath:writableDBPath];
        if (!success) {
            // The writable database does not exist, so copy the default to the appropriate location.
            
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
            [bundle stringByExpandingTildeInPath];
             success = [fileManager copyItemAtPath:bundle toPath: writableDBPath error:&error]; 
           
            if (!success) {
                NSAssert1(0, @"Failed to create writable database file with message ‘%@’.", [error localizedDescription]);
            }
        }
        
    }
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        NSLog(@"Database Successfully Opened");
        
    } else {
        NSLog(@"Error in opening database");
    }
    
    return self;
}

//-(void)getMostViewed{
//    //NSArray *arr = [[NSArray alloc]init];
//    sqlite3_stmt *statement = nil;
//    const char *sql= "select * from Quotes";
//    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
//        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
//    } else {
//
//        while (sqlite3_step(statement)==SQLITE_ROW) {
//            int temp = atoi((char*)sqlite3_column_text(statement, 0));
//            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
//            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
//            //[str2 stringByAppendingString:@" +0600"];
//            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
//            [dateFormater setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
//            NSDate *tempdate = [dateFormater dateFromString:str2];
//            NSString *str = [[NSString alloc]initWithString:@"abv"];
//            [str stringByAppendingString:@"%"];
//             NSString *sql =[[NSString alloc]initWithFormat: @"select * from Quotes where message like %%%@",str];
//            [sql stringByAppendingString:@"abv%"];
//            NSLog(@"MESSAGE:%@",sql);
//        }
//    }
//}

-(NSArray*)searchByString:(NSString *)str{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement = nil;
    const char *sql =[[[NSString alloc]initWithFormat:@"select * from list where message like '%%%@%%'",str]UTF8String];
    NSLog(@"%s",sql);
   // const char *sql= "select * from list where message like 'This is the tenth quote'";
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];         
            
            int temp = atoi((char*)sqlite3_column_text(statement, 0));
            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];                
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"yyyy-mm-dd"];
            NSDate *tempdateCr = [dateFormater dateFromString:str2];
            NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
            NSDate *tempdateMo = [dateFormater dateFromString:str3];
            int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
            int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
            Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
            [arr addObject:quote1];
        
        }
    }
    sqlite3_finalize(statement);
    NSArray *temp = [[NSArray alloc]initWithArray:arr];
    return temp;
}

-(NSArray*)getTopQuotes{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //sqlite3 *db = _database;
    sqlite3_stmt *statement;
    const char *sql= "select * from list order by PlusVotes DESC limit 0, 50";

    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)!=SQLITE_OK) {
         printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(_database) );
        
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
       
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
            
                int temp = atoi((char*)sqlite3_column_text(statement, 0));
                NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                
                NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
                [dateFormater setDateFormat:@"yyyy-mm-dd"];
                NSDate *tempdateCr = [dateFormater dateFromString:str2];
                NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                NSDate *tempdateMo = [dateFormater dateFromString:str3];
                int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
                int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
                NSLog(@"PLUSVOTES:%d",tempPV);
                Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
                [arr addObject:quote1];
            
        }
    }
    sqlite3_finalize(statement);
    NSArray *temp = [[NSArray alloc]initWithArray:arr];
    return temp;
}

-(NSArray*)getRecentlyAdded{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement = nil;
    const char *sql= "select * from list order by DateAdded DESC limit 0, 50";
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
            
            int temp = atoi((char*)sqlite3_column_text(statement, 0));
            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"yyyy-mm-dd"];
            NSDate *tempdateCr = [dateFormater dateFromString:str2];
            NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
            NSDate *tempdateMo = [dateFormater dateFromString:str3];
            int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
            int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
            NSLog(@"Date:%@",tempdateCr);
            Quote *quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
            [arr addObject:quote1];
            
        }
    }
    sqlite3_finalize(statement);
    NSArray *temp = [[NSArray alloc]initWithArray:arr];
    return temp;

}

-(Quote*)getRandomQuote{
    Quote *quote1;
    int x= arc4random() % 10;
    sqlite3_stmt *statement = nil;
    const char *sql =[[[NSString alloc]initWithFormat:@"SELECT * from list WHERE key LIKE '%d'",x]UTF8String];
    if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL)) {
        NSAssert1(0, @"Error preparing statement", sqlite3_errmsg(_database));
    } else {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            NSString *str2 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
            //NSLog(@"RAAAAA:%@"[[str2 rangeOfString:str].location ]);
            
            int temp = atoi((char*)sqlite3_column_text(statement, 0));
            NSString *tempstr = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"yyyy-mm-dd"];
            NSDate *tempdateCr = [dateFormater dateFromString:str2];
            NSString *str3 = [[NSString alloc]initWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
            NSDate *tempdateMo = [dateFormater dateFromString:str3];
            int tempPV = atoi((char*)sqlite3_column_text(statement, 4));
            int tempMV = atoi((char*)sqlite3_column_text(statement, 5));
            NSLog(@"Date:%@",tempdateCr);
            quote1 = [[Quote alloc]initWithID:temp Message:tempstr DateAdded:tempdateCr DateModified:tempdateMo PlusVotes:tempPV MinusVotes:tempMV];
                       
        }
    }
    sqlite3_finalize(statement);
    return quote1;
}

@end
