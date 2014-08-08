//
//  PhotoSessionViewController.h
//  photos
//
//  Created by Cevaris on 8/5/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "ViewController.h"
#import "PhotoSession.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoSessionViewController : ViewController
    
@property (nonatomic, strong) PhotoSession *ps;

@property (weak, nonatomic) IBOutlet UIButton *btnUrl;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblIsSuccess;
@property (weak, nonatomic) IBOutlet UIImageView *picutreOne;
@property (weak, nonatomic) IBOutlet UIImageView *picutreTwo;
@property (weak, nonatomic) IBOutlet UIImageView *picutreThree;


- (IBAction)clickUrl:(id)sender;


@end
