//
//  PhotoSessionViewController.m
//  photos
//
//  Created by Cevaris on 8/5/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSessionViewController.h"

@interface PhotoSessionViewController ()

@end

@implementation PhotoSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.ps) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"E MMM, dd"];
        
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"hh:mm:ss a"];
        
        NSString *theDate = [dateFormat stringFromDate:[self.ps createdAt]];
        NSString *theTime = [timeFormat stringFromDate:[self.ps createdAt]];
        
        self.lblCreatedAt.text = [NSString stringWithFormat:@"%@ - %@", theTime, theDate];
        self.lblIsSuccess.text = [self.ps isSuccess] ? @"Yes" : @"No";
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([self.ps photoOne]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoOne] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreOne.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreOne.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
        
        if ([self.ps photoTwo]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoTwo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreTwo.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreTwo.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
        
        if ([self.ps photoThree]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoThree] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreThree.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreThree.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
