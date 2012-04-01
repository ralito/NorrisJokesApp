//
//  SearchViewController.h
//  NorrisJokesApp
//
//  Created by Rali on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UISearchDisplayController *searchDisplayController;
    UISearchDisplayController *searchBar;
    NSArray *allItems;
    NSArray *searchResults;
    UITableView *tableView;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBar;

@property (nonatomic, copy) NSArray *allItems;
@property (nonatomic, copy) NSArray *searchResults;

@end
