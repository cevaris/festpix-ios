//
//  PhotoSessionListViewController.h
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPhotoSession.h"

@interface PhotoSessionTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *photoSessions;
}

@end
