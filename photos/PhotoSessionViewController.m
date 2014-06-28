//
//  PhotoSessionViewController.m
//  photos
//
//  Created by Cevaris on 6/18/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSessionViewController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"

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
    
    self.phoneOne.delegate = self;
    self.phoneTwo.delegate = self;
    self.phoneThree.delegate = self;

    
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
    
    // Create the image picker
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc]
                                                initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    elcPicker.maximumImagesCount = 3;
    elcPicker.imagePickerDelegate = self;
    
    albumController.parent = elcPicker;

    [self presentViewController:elcPicker animated:YES completion:nil];


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


/*
 #pragma mark - ELCImagePickerController

*/
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    
    // How to retrieve images after picker
    // https://github.com/felina/ios/blob/0e80ceb743447752487cb4f6e109b86f403e2c58/Felina/FECustomImagePickerViewController.m
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (int i=0; i < info.count; i++) {
        UIImage *image = [info[i] objectForKey:UIImagePickerControllerOriginalImage];
        switch (i) {
            case 0:
                self.pictureOne.image = image;
                pictureOneSelected = YES;
                break;
            case 1:
                self.pictureTwo.image = image;
                pictureTwoSelected = YES;
                break;
            case 2:
                self.pictureThree.image = image;
                pictureThreeSelected = YES;
                break;
            default:
                break;
        }
    }
}
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}




//#########
-(BOOL) validatePhone:(NSString *) phoneText {

    NSString *expression = @"^[0-9]{0,10}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    return [test evaluateWithObject:phoneText];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validatePhone:[textField.text stringByReplacingCharactersInRange:range withString:string]];
}

@end
