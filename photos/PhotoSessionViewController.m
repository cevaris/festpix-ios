//
//  PhotoSessionViewController.m
//  photos
//
//  Created by Cevaris on 8/5/14.
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
    
    if (self.ps) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"E MMM, dd"];
        
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"hh:mm:ss a"];
        
        NSString *theDate = [dateFormat stringFromDate:[self.ps createdAt]];
        NSString *theTime = [timeFormat stringFromDate:[self.ps createdAt]];
        
        self.lblCreatedAt.text = [NSString stringWithFormat:@"%@ - %@", theTime, theDate];
        self.lblIsSuccess.text = [self.ps isSuccess] ? @"Yes" : @"No";
        self.lblAttemptNum.text = [NSString stringWithFormat:@"%d",[self.ps attemptNum]];
        
        if ([self.ps url]){
            [self.btnUrl setHidden:NO];
            [self.btnUrl setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [self.btnUrl setTitle:[NSString stringWithFormat:@"http://%@", [self.ps url]] forState:UIControlStateNormal];
            [self.btnRetry setEnabled:NO];
        } else {
            [self.btnUrl setHidden:YES];
        }
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([self.ps photoOne]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoOne] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreOne.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreOne.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
        
        if ([self.ps photoTwo]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoTwo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreTwo.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreTwo.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
        
        if ([self.ps photoThree]) {
            [library assetForURL:[NSURL URLWithString:[[self.ps photoThree] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] resultBlock:^(ALAsset *asset) {
                self.picutreThree.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                self.picutreThree.contentMode = UIViewContentModeScaleAspectFit;
            } failureBlock:^(NSError *error) {
                NSLog(@"error : %@", error);
            }];
        }
    }
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

- (IBAction)clickUrl:(id)sender {
    NSLog(@"Opening URL: %@", [self.ps url]);
    if (self.ps  && [self.ps url]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", [self.ps url]]]];
    }
    
}

- (IBAction)clickRetry:(id)sender {
}

- (void)retry {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"photo_session[phone_list]": [self.ps phoneList]};
    //http://localhost:3000/photo_sessions.json
    
    [[self.ps db] setValue:[NSNumber numberWithInt:([self.ps attemptNum]+1)] forKeyPath:@"attemptNum"];
    
    NSString *root_url = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RootURL"];
    NSString *url = [NSString stringWithFormat:@"%@/photo_sessions.json", root_url];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.picutreOne.image,1.0)
                                    name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", 0]
                                fileName:[NSString stringWithFormat:@"%d.jpg", 0]
                                mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.picutreTwo.image,1.0)
                                    name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", 1]
                                fileName:[NSString stringWithFormat:@"%d.jpg", 1]
                                mimeType:@"image/jpeg"];

        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.picutreThree.image,1.0)
                                    name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", 2]
                                fileName:[NSString stringWithFormat:@"%d.jpg", 2]
                                mimeType:@"image/jpeg"];
//
//        
//        for(int i=0;i<[images count];i++) {
//            UIImage *eachImage  = [images objectAtIndex:i];
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(eachImage,1.0)
//                                        name:[NSString stringWithFormat:@"photo_session[photos_attributes][%d][image]", i]
//                                    fileName:[NSString stringWithFormat:@"%d.jpg", i]
//                                    mimeType:@"image/jpeg"];
//        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success Path: %@", [responseObject valueForKey:@"path"]);
        [self.ps setUrl:[responseObject valueForKeyPath:@"path"]];
        [self.ps setIsSuccess:YES];
        [PhotoSessionPersistence save:self.ps];
        NSLog(@"Saved Logs %@", [PhotoSessionPersistence loadAll]);
        
        UINavigationController *navController = [self.tabBarController.childViewControllers objectAtIndex:1];
        PhotoSessionTableViewController *tableController = [navController.viewControllers objectAtIndex:0];
        [tableController fetchDisplayData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [PhotoSessionPersistence save:self.ps];
    }];
    
}

@end
