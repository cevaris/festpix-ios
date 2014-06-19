//
//  PhotoSessionViewController.h
//  photos
//
//  Created by Cevaris on 6/18/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"

@interface PhotoSessionViewController : ViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate> {
    @private UIImageView *currentPicture;
    @private BOOL pictureOneSelected;
    @private BOOL pictureTwoSelected;
    @private BOOL pictureThreeSelected;
}


@property (weak, nonatomic) IBOutlet UITextField *phoneOne;
@property (weak, nonatomic) IBOutlet UITextField *phoneTwo;
@property (weak, nonatomic) IBOutlet UITextField *phoneThree;

@property (weak, nonatomic) IBOutlet UIImageView *pictureOne;
@property (weak, nonatomic) IBOutlet UIImageView *pictureTwo;
@property (weak, nonatomic) IBOutlet UIImageView *pictureThree;


@end
