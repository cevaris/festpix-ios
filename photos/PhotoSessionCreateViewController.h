//
//  PhotoSessionViewController.h
//  photos
//
//  Created by Cevaris on 6/18/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"
#import "ELCImagePickerController.h"
#import "AFNetworking.h"
#import "PhotoSession.h"
#import "PhotoSessionPersistence.h"
#import "PhotoSessionTableViewController.h"
#import "SettingsViewController.h"
#import "GlobalState.h"

@interface PhotoSessionCreateViewController : ViewController <UINavigationControllerDelegate, ELCImagePickerControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    @private UIImage      *defaultImg;
    @private PhotoSession *ps;
}

@property (weak, nonatomic) IBOutlet UIPickerView *eventPicker;

@property (weak, nonatomic) IBOutlet UITextField *txtPhoneOne;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneTwo;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneThree;

@property (weak, nonatomic) IBOutlet UIImageView *pictureOne;
@property (weak, nonatomic) IBOutlet UIImageView *pictureTwo;
@property (weak, nonatomic) IBOutlet UIImageView *pictureThree;

@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnAddPhotos;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


- (IBAction)touchedSubmit:(id)sender;
- (IBAction)touchedAddPhotos:(id)sender;
- (IBAction)touchedReset:(id)sender;

@property (strong, nonatomic) NSMutableArray *eventNames;

@end
