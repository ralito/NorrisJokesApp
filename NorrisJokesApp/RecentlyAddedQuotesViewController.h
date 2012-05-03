//
//  RecentlyAddedQuotesViewController.h
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "QuotesDatabaseService.h"

@interface RecentlyAddedQuotesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *tableData;
    QuotesDatabaseService *qdb;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;



@end
