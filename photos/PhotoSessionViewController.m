//
//  PhotoSessionViewController.m
//  photos
//
//  Created by Cevaris on 6/18/14.
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
    
    currentPicture = 0;
    pictureOneSelected   = NO;
    pictureTwoSelected   = NO;
    pictureThreeSelected = NO;
    
    UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPictureOne)];
    [self.pictureOne addGestureRecognizer:singleTapOne];
    UITapGestureRecognizer *singleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPictureTwo)];
    [self.pictureTwo addGestureRecognizer:singleTapTwo];
    UITapGestureRecognizer *singleTapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPictureThree)];
    [self.pictureThree addGestureRecognizer:singleTapThree];
}

-(void)selectImage{
    
    // Multiple Photo Lookup
    // https://github.com/B-Sides/ELCImagePickerController
    
    UIImagePickerController *picker;
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:Nil];


}
-(void)tappedPictureOne{
    NSLog(@"single Tap on imageview One");
    
    if(pictureOneSelected){

        self.pictureOne.image = [UIImage imageNamed: @"camera.png"];
        pictureOneSelected = NO;
        
    } else {
        
        pictureOneSelected = YES;
        currentPicture = self.pictureOne;
        [self selectImage];
        
    }
    
}
-(void)tappedPictureTwo{
    NSLog(@"single Tap on imageview Two");
    
    
    if(pictureTwoSelected){
        
        self.pictureTwo.image = [UIImage imageNamed: @"camera.png"];
        pictureTwoSelected = NO;
        
    } else {
        
        pictureTwoSelected = YES;
        currentPicture = self.pictureTwo;
        [self selectImage];
    }


    
}
-(void)tappedPictureThree{
    NSLog(@"single Tap on imageview Three");
    
    if(pictureThreeSelected){
        
        self.pictureThree.image = [UIImage imageNamed: @"camera.png"];
        pictureThreeSelected = NO;
        
    } else {
        
        pictureThreeSelected = YES;
        currentPicture = self.pictureThree;
        [self selectImage];
    }

    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneOne   resignFirstResponder];
    [self.phoneTwo   resignFirstResponder];
    [self.phoneThree resignFirstResponder];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Dismiss Gallery
    [self dismissViewControllerAnimated:NO completion:nil];
    // Get selected image
    UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // If we have current picture state
    if (currentPicture) {
        // Set selected picture
        [currentPicture setImage:selectedImage];
        currentPicture = nil;
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Cancelled selecting image");

}

@end
