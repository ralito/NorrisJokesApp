//
//  QuoteHTTPService.m
//  NorrisJokesApp
//
//  Created by Martin Markov on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuoteHTTPService.h"


@implementation QuoteHTTPService

-(NSArray*)getRecentlyAddedQuotes:(NSString*)date {
    QuotesDatabaseService *qdb = [[QuotesDatabaseService alloc]init];
    NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:@"http://127.0.0.1:8888/norrisjokesserver/mainServlet?type=GetQuotes&date=%@",date]];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
        if ([data length] > 0 && error == nil) {
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSError *jsonError;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonObject != nil && error == nil){
                NSLog(@"Successfully deserialized..."); 
                if ([jsonObject isKindOfClass:[NSArray class]]){
                    NSArray *deserializedArray = (NSArray *)jsonObject; 
                    for (NSDictionary *quote in deserializedArray) {
                        //Add to database
                        int key= [[quote objectForKey:@"key"] intValue];
                        NSString *message = [[NSString alloc]initWithString:[quote objectForKey:@"message"]];
                        
                        NSDate *dateAdded = [self convertDateFromString:[quote objectForKey:@"dateCreated"]];                        
                        NSDate *dateModified = [self convertDateFromString:[quote objectForKey:@"dateModified"]];
                        int plusVotes = [[quote objectForKey:@" plusVotes"] intValue];
                        int minusVotes = [[quote objectForKey:@" minusVotes"] intValue];
                        Quote *q = [[Quote alloc]initWithID:key Message:message DateAdded:dateAdded DateModified:dateModified PlusVotes:plusVotes MinusVotes:minusVotes];   
                        [qdb updateQuote:q];
                        
                    }
                    
                    NSLog(@"Dersialized JSON Array = %@", deserializedArray);
                }
            }
            
            NSLog(@"%@", json);
        } else if ([data length] ==0 && error == nil) {
            NSLog(@"Nothing");
        } else if (error != nil) {
            NSLog(@"Error");
        }

    }];
    
    return nil;
}

-(BOOL)addQuote:(NSString *)message {
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/norrisjokesserver/mainServlet?type=AddNewQuote"];
//    
//    NSString *json = [NSString stringWithFormat:@"{\"message\":\"%@\" }", message];

    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/norrisjokesserver/mainServlet?type=AddVote"];
    
    NSString *json = [NSString stringWithFormat:@"{\"id\":\"2\",\"vote\":\"1\" }"];

    
    NSString *jsonLength = [NSString stringWithFormat:@"%d", [json length]];
    NSData *postData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setTimeoutInterval:30.0f];
    [request addValue:@"http://127.0.0.1:8888/" forHTTPHeaderField:@"Host"];
    [request addValue:jsonLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ([data length] > 0 && error == nil) {
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", string);
        } else if ([data length] ==0 && error == nil) {
            NSLog(@"Nothing");
        } else if (error != nil) {
            NSLog(@"Error");
        }
        
    }];

    
    

}


-(NSDate*)convertDateFromString:(NSString*)str{
    int flag=0;
    for (int i=0; i<=[str length]; i++) {
        if ([str characterAtIndex:i]==' '){
            flag=i;
            break;
        }
    }
    NSString *str2 = [[NSString alloc]initWithString:[str substringFromIndex:flag++]];
    for (int i=0; i<=[str2 length]; i++) {
        if ([str characterAtIndex:i]=='E'){
            flag=i;
            break;
        }
    }
    NSString *str3 = [[NSString alloc]initWithString:[[str2 substringToIndex:flag-3] stringByAppendingString:[str2 substringFromIndex:flag+2]]];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"MMM dd HH:mm:ss yyyy"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:+2];
    [dateFormater setTimeZone:timeZone];
    NSDate *date=[dateFormater dateFromString:str3];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    str3 = [dateFormater stringFromDate:date];
    return [dateFormater dateFromString:str3]; 
}


@end
