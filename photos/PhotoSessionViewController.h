//
//  PhotoSessionViewController.h
//  photos
//
//  Created by Cevaris on 8/5/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "AFNetworking.h"

#import "PhotoSession.h"
#import "PhotoSessionPersistence.h"
#import "PhotoSessionTableViewController.h"
#import "GlobalState.h"
#import "Event.h"

@interface PhotoSessionViewController : ViewController

@property (nonatomic, strong) UIImage      *defaultImg;
@property (nonatomic, strong) PhotoSession *ps;

@property (weak, nonatomic) IBOutlet UIButton *btnUrl;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblIsSuccess;
@property (weak, nonatomic) IBOutlet UIImageView *picutreOne;
@property (weak, nonatomic) IBOutlet UIImageView *picutreTwo;
@property (weak, nonatomic) IBOutlet UIImageView *picutreThree;
@property (weak, nonatomic) IBOutlet UIButton *btnRetry;
@property (weak, nonatomic) IBOutlet UILabel *lblAttemptNum;
@property (weak, nonatomic) IBOutlet UILabel *lblEventName;

- (IBAction)clickUrl:(id)sender;
- (IBAction)clickRetry:(id)sender;


@end
