//
//  SettingsViewController.m
//  photos
//
//  Created by Cevaris on 8/4/14.
//  Copyright (c) 2014 cevaris. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize eventNames;

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

    GlobalState * state = [GlobalState sharedState];
    eventNames = [[state events] allKeys];
    [self.pickerEvent reloadInputViews];
}

- (void) viewWillAppear:(BOOL)animated {
    
    GlobalState * state = [GlobalState sharedState];
    NSString *selected = [state currentEvent];
    NSUInteger elIndex = [eventNames indexOfObject:selected];
    if(elIndex != NSNotFound){
        [self.pickerEvent selectRow:elIndex inComponent:0 animated:true];
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

- (IBAction)clickedDeleteAll:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle: @"Delete PhotoSessions"
                                message: @"Wish to delete all Photo Session data?"
                               delegate: self
                      cancelButtonTitle: @"Cancel"
                      otherButtonTitles: @"Yes",nil] show];

    NSLog(@"Clicked Delete All");
    

}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex: (NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
            NSLog(@"Clicked Yes");
            NSLog(@"%@", [PhotoSessionPersistence loadAll]);
            [PhotoSessionPersistence deleteAll];
            NSLog(@"%@", [PhotoSessionPersistence loadAll]);
            
            [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
            [[GlobalState sharedState] deleteAll];
            
            break;
            
        default:
            NSLog(@"Clicked No");
            break;
    }
}

/*
 #pragma mark - PickerView
 */

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return eventNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return eventNames[row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *eventName = eventNames[row];
    NSLog(@"Selected Server: %@", eventName);
    
    GlobalState * state = [GlobalState sharedState];
    [state setCurrentEvent:eventName];
    [state commit];
    
    //    state = [GlobalState sharedState];
    //    [state load];
    //    NSLog(@"Saved current event; %@", [state currentEvent]);
}

@end
