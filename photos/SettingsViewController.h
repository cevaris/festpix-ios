//
//  SettingsViewController.h
//  photos
//
//  Created by Cevaris on 8/4/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"
#import "PhotoSessionPersistence.h"

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIPickerView *pickerServer;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteAll;

- (IBAction)clickedDeleteAll:(id)sender;

@property (strong, nonatomic) NSString *server;
@property (strong, nonatomic) NSArray *servers;

@end
