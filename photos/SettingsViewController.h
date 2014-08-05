//
//  SettingsViewController.h
//  photos
//
//  Created by Cevaris on 8/4/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"
#import "CPhotoSession.h"

@interface SettingsViewController : ViewController


@property (weak, nonatomic) IBOutlet UIButton *btnDeleteAll;

- (IBAction)clickedDeleteAll:(id)sender;


@end
