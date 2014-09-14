//
//  PhotoSessionViewController.m
//  photos
//
//  Created by Cevaris on 6/18/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "PhotoSessionCreateViewController.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"

@interface PhotoSessionCreateViewController ()


@end



@implementation PhotoSessionCreateViewController

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
    
   
    
    defaultImg = [UIImage imageNamed:@"camera.png"];
    
    [self resetUI];
    
    self.txtPhoneOne.delegate = self;
    self.txtPhoneTwo.delegate = self;
    self.txtPhoneThree.delegate = self;
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    GlobalState *state = [GlobalState sharedState];
    Event* event = [[state events] objectForKey:[state currentEvent]];
    self.lblEventName.text = [event name];

}


-(void) resetUI {
    self.txtPhoneOne.text = @"5594516126";
//    self.txtPhoneOne.text = @"";
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
    
    // Saving data to CoreData
    // http://www.techotopia.com/index.php/An_iOS_7_Core_Data_Tutorial#Saving_Data_to_the_Persistent_Store_using_Core_Data
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    ps = [[PhotoSession alloc] init];
    [ps setPhoneList:[self getPhoneList]];
    
    for (int i=0; i < info.count; i++) {
        UIImage *image = [info[i] objectForKey:UIImagePickerControllerOriginalImage];
        
//        NSString *mediaType = [info[i] objectForKey:UIImagePickerControllerMediaType];
//        NSURL *assetURL = [info[i] objectForKey:UIImagePickerControllerReferenceURL];
//        NSLog(@"Media Type: %@", mediaType);
//        NSLog(@"AssetURL: %@", assetURL);
        
        // How to save Image for later use
        // http://stackoverflow.com/questions/15564705/how-to-use-assetlibrary-url-to-image

        // Selecting Images via Reference URL
        // http://stackoverflow.com/questions/13512260/name-of-the-picked-image-xcode/13512415#13512415

        
        switch (i) {
            case 0:
                self.pictureOne.image = image;
                self.pictureOne.contentMode = UIViewContentModeScaleAspectFit;
                [ps setPhotoOne: [[info[i] objectForKey:UIImagePickerControllerReferenceURL] absoluteString ]];
                break;
            case 1:
                self.pictureTwo.image = image;
                self.pictureTwo.contentMode = UIViewContentModeScaleAspectFit;
                [ps setPhotoTwo: [[info[i] objectForKey:UIImagePickerControllerReferenceURL] absoluteString ]];
                break;
            case 2:
                self.pictureThree.image = image;
                self.pictureThree.contentMode = UIViewContentModeScaleAspectFit;
                [ps setPhotoThree: [[info[i] objectForKey:UIImagePickerControllerReferenceURL] absoluteString ]];
                break;
            default:
                break;
        }
    }
    
    NSLog(@"Collected Photos: %@", ps);
    
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
-(BOOL) validateBeforeSubmit {
    
    if([[self getPhoneList] length] < 10){
        
        [[[UIAlertView alloc] initWithTitle:@"Form Error"
                                    message:@"Missing Phone Number."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Ok", nil] show];

        return NO;
    }
    if([[self getPictureList] count] == 0){
        [[[UIAlertView alloc] initWithTitle:@"Form Error"
                                    message:@"Missing Pictures, please select one."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Ok", nil] show];
        return NO;
    }
    
    return YES;
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
-(NSArray*) getPictureList {
    NSMutableArray *images = [[NSMutableArray alloc]init];
   
    if(self.pictureOne.image != defaultImg){
        [images addObject:self.pictureOne.image];
    }
    if(self.pictureTwo.image != defaultImg){
        [images addObject:self.pictureTwo.image];
    }
    if(self.pictureThree.image != defaultImg){
        [images addObject:self.pictureThree.image];
    }
    return [[NSArray alloc] initWithArray:images];
}
-(void)postData {
    
    GlobalState *state = [GlobalState sharedState];
   
    if([self validateBeforeSubmit] == NO)
        return;
    
    NSArray *images = [self getPictureList];
    NSLog(@"Phones: %@", [self getPhoneList]);
    
    
    NSArray* photosessions = [PhotoSessionPersistence loadAll];
    NSLog(@"Saved Logs %@", photosessions);
    
    Event* event = [[state events] objectForKey:[state currentEvent]];
    int eventId = [[ event objectId] intValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
        @"photo_session[phone_list]": [self getPhoneList],
        @"photo_session[event_id]": [NSNumber numberWithInt:eventId]
    };
    //http://localhost:3000/photo_sessions.json
//    NSString *root_url = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RootURL"];
    
//    UINavigationController *navController = [self.tabBarController.childViewControllers objectAtIndex:2];
//    SettingsViewController *settingsViewController = [navController.viewControllers objectAtIndex:0];
    
    
    NSString *root_url = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RootURL"];
    NSString *url = [NSString stringWithFormat:@"%@/photo_sessions.json", root_url];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for(int i=0;i<[images count];i++) {
            UIImage *eachImage  = [images objectAtIndex:i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(eachImage,1.0)
                                        name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", i]
                                    fileName:[NSString stringWithFormat:@"%d.jpg", i]
                                    mimeType:@"image/jpeg"];
        }
        [self resetUI];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success Path: %@", [responseObject valueForKey:@"path"]);

        [ps setIsSuccess:YES];
        [ps setUrl:[responseObject valueForKey:@"path"]];
        [PhotoSessionPersistence save:ps];
        NSLog(@"Saved Logs %@", [PhotoSessionPersistence loadAll]);
        
        UINavigationController *navController = [self.tabBarController.childViewControllers objectAtIndex:1];
        PhotoSessionTableViewController *tableController = [navController.viewControllers objectAtIndex:0];
        [tableController fetchDisplayData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        NSLog(@"Error: %@", error);
        [ps setIsSuccess:NO];
        [PhotoSessionPersistence save:ps];
    }];
    
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
