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
    photoSessions = [PhotoSessionPersistence loadAll];
//    for (NSManagedObject *ps in photoSessions) {
//        NSLog(@"PhotoSession: %@", ps);
//    }
    
//    photoSessions = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", nil];
    [NSTimer scheduledTimerWithTimeInterval: 20.0
                                     target: self
                                   selector: @selector(fetchDisplayData:) userInfo: nil repeats: YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [self fetchDisplayData:nil];
//    photoSessions = [PhotoSessionPersistence loadAll];
//    [self.tableView reloadData];
}

-(void) fetchDisplayData:(NSTimer*) t {
    NSLog(@"Reloading Data");
    photoSessions = [PhotoSessionPersistence loadAll];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [photoSessions count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepareForSegue: %@", segue.identifier  );
    if ([[segue identifier] isEqualToString:@"PhotoSessionCellSegue"]){
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        PhotoSessionViewController *detailViewController = [segue destinationViewController];
        detailViewController.ps = [photoSessions objectAtIndex:selectedRowIndex.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PhotoSessionCellSegue" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"PhotoSessionTableViewCell";
    
    PhotoSessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    PhotoSession *ps = [photoSessions objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[PhotoSessionTableViewCell alloc] init];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E MMM, dd"];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:ss a"];
    
    NSString *theDate = [dateFormat stringFromDate:[ps createdAt]];
    NSString *theTime = [timeFormat stringFromDate:[ps createdAt]];

    cell.lblCreatedAt.text = [NSString stringWithFormat:@"%@ - %@", theTime, theDate];
    cell.lblIsSuccess.text = [ps isSuccess] ? @"Yes" : @"No";
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library assetForURL:[NSURL URLWithString:[[ps photoOne] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
        cell.imageSample.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
        cell.imageSample.contentMode = UIViewContentModeScaleAspectFit;
    } failureBlock:^(NSError *error) {
        NSLog(@"error : %@", error);
    }];
    
    return cell;
}

@end
