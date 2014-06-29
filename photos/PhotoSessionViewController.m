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
    
    self.txtPhoneOne.delegate = self;
    self.txtPhoneTwo.delegate = self;
    self.txtPhoneThree.delegate = self;

}

-(void) resetUI {
    self.txtPhoneOne.text = @"";
    self.txtPhoneTwo.text = @"";
    self.txtPhoneThree.text = @"";
    
    self.pictureOne.image = [UIImage imageNamed: @"camera.png"];
    self.pictureTwo.image = [UIImage imageNamed: @"camera.png"];
    self.pictureThree.image = [UIImage imageNamed: @"camera.png"];
}
-(void)selectImages{
    
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtPhoneOne   resignFirstResponder];
    [self.txtPhoneTwo   resignFirstResponder];
    [self.txtPhoneThree resignFirstResponder];
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
    
    [self resetUI];
    
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
-(void)postData {
//    NSURLRequest* request = [[ sharedHTTPClient] multipartFormRequestWithMethod:@"POST"
//                                                                                         path:path
//                                                                                   parameters:dict
//                                                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                                                                        [formData appendPartWithFileData:data1
//                                                                                                    name:@"image1"
//                                                                                                fileName:@"image1.jpg"
//                                                                                                mimeType:@"image/jpeg"];
//                                                                        [formData appendPartWithFileData:data2
//                                                                                                    name:@"image2"
//                                                                                                fileName:@"image2.jpg"
//                                                                                                mimeType:@"image/jpeg"];
//                                                                    }
//                             }];
}

/*
 #pragma mark - TouchedButtons
 
 */
- (IBAction)touchedSubmit:(id)sender {
    NSLog(@"Submitting Upload of Photos");

}

- (IBAction)touchedAddPhotos:(id)sender {
    NSLog(@"Adding New Photos");
    [self selectImages];
}

- (IBAction)touchedReset:(id)sender {
    NSLog(@"Restarting UI");
    [self resetUI];
}
@end
