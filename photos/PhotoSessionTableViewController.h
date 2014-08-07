//
//  PhotoSessionListViewController.h
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSessionTableViewCell.h"
#import "PhotoSessionPersistence.h"
#import "PhotoSession.h"
#import "PhotoSessionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoSessionTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *photoSessions;
    UIRefreshControl* refreshControl;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UIRefreshControl* refreshControl;
//@property (weak, nonatomic) UIRefreshControl* refreshControl;
@end
