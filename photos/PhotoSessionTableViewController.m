//
//  PhotoSessionListViewController.m
//  photos
//
//  Created by Cevaris on 7/31/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSessionTableViewController.h"

@implementation PhotoSessionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize table data
//    photoSessions = [CPhotoSession loadAll];
    photoSessions = [CPhotoSession loadAll];
    for (NSManagedObject *ps in photoSessions) {
        NSLog(@"PhotoSession: %@", ps);
    }
    photoSessions = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [photoSessions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [photoSessions objectAtIndex:indexPath.row];
    return cell;
}

@end
