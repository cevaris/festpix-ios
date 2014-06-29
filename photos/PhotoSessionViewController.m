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
    
    defaultImg = [UIImage imageNamed:@"camera.png"];
    
    [self resetUI];
    
    self.txtPhoneOne.delegate = self;
    self.txtPhoneTwo.delegate = self;
    self.txtPhoneThree.delegate = self;

}

-(void) resetUI {
    self.txtPhoneOne.text = @"5594516126";
    self.txtPhoneTwo.text = @"";
    self.txtPhoneThree.text = @"";
    
    self.pictureOne.image   = defaultImg;
    self.pictureTwo.image   = defaultImg;
    self.pictureThree.image = defaultImg;
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
    
//    [self resetUI];
    
    for (int i=0; i < info.count; i++) {
        UIImage *image = [info[i] objectForKey:UIImagePickerControllerOriginalImage];
        switch (i) {
            case 0:
                self.pictureOne.image = image;
                break;
            case 1:
                self.pictureTwo.image = image;
                break;
            case 2:
                self.pictureThree.image = image;
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
-(NSString*) getPhoneList {
    NSMutableArray *phones = [[NSMutableArray alloc]init];

    if([self.txtPhoneOne.text length] != 0){
        [phones addObject:self.txtPhoneOne.text];
    }
    if([self.txtPhoneTwo.text length] != 0){
        [phones addObject:self.txtPhoneTwo.text];
    }
    if([self.txtPhoneThree.text length] != 0){
        [phones addObject:self.txtPhoneThree.text];
    }
    
    return [phones componentsJoinedByString:@","];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validatePhone:[textField.text stringByReplacingCharactersInRange:range withString:string]];
}
-(void)postData {
    
    NSMutableArray *images = [[NSMutableArray alloc]init];
    
    if(self.pictureOne.image != defaultImg){
        NSLog(@"Pic One set");
        [images addObject:self.pictureOne.image];
    }
    if(self.pictureTwo.image != defaultImg){
        NSLog(@"Pic Two set");
        [images addObject:self.pictureTwo.image];
    }
    if(self.pictureThree.image != defaultImg){
        NSLog(@"Pic Three set");
        [images addObject:self.pictureThree.image];
    }
    
    NSLog(@"Phones: %@", [self getPhoneList]);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"photo_session[phone_list]": [self getPhoneList]};
    [manager POST:@"http://localhost:3000/photo_sessions.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for(int i=0;i<[images count];i++) {
            UIImage *eachImage  = [images objectAtIndex:i];
            NSData *imageData = UIImageJPEGRepresentation(eachImage,1.0);
            [formData appendPartWithFileData:imageData
                                        name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", i]
                                    fileName:[NSString stringWithFormat:@"%d.jpg", i]
                                    mimeType:@"image/jpeg"];
//            [formData appendPartWithFormData:imageData name:[NSString stringWithFormat:@"%d", i]];
//            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i ] fileName:[NSString stringWithFormat:@"abc%d.jpg",i ];
        }
        
//        [formData appendPartWithFileData:imageData name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        NSLog(@"Path: %@", [responseObject valueForKey:@"path"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
//
//    
////    NSMutableURLRequest *request = [[AFNetWorkSingleton shareInstance] multipartFormRequestWithMethod:@"POST"
////                                                                                                 path:@"photo_session"
////                                                                                           parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
////        
////        for(int i=0;i<[array count];i++) {
////            UIImage *eachImage  = [array objectAtIndex:i];
////            NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
////            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i ] fileName:[NSString stringWithFormat:@"abc%d.jpg",i ] mimeType:@"image/jpeg"];
////        }
////    }];
////    
//////    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//////    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
//////         NSLog(@"2");
//////    }];
}

/*
 #pragma mark - TouchedButtons
 
 */
- (IBAction)touchedSubmit:(id)sender {
    NSLog(@"Submitting Upload of Photos");
    [self postData];
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
