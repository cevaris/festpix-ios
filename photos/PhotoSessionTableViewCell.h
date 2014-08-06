//
//  PhotoSessionTableViewCell.h
//  photos
//
//  Created by Cevaris on 8/5/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSessionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageSample;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblIsSuccess;

@end
