//
//  SettingsViewController.m
//  photos
//
//  Created by Cevaris on 8/4/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

- (IBAction)clickedDeleteAll:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle: @"Delete PhotoSessions"
                                message: @"Wish to delete all Photo Session data?"
                               delegate: self
                      cancelButtonTitle: @"Cancel"
                      otherButtonTitles: @"Yes",nil] show];

    NSLog(@"Clicked Delete All");
    

}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex: (NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
            NSLog(@"Clicked Yes");
            NSLog(@"%@", [CPhotoSession loadAll]);
            [CPhotoSession deleteAll];
            NSLog(@"%@", [CPhotoSession loadAll]);
            
            break;
            
        default:
            NSLog(@"Clicked No");
            break;
    }
}
@end
