//
//  WIPViewController.h
//  Hello
//
//  Created by Daniel Goebel on 24.09.12.
//  Copyright (c) 2012 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h> 

@interface WIPViewController : UIViewController <CLLocationManagerDelegate> {
    UIImageView     *table;
    UIImageView     *bottle;
}


@property (nonatomic, retain) IBOutlet UIImageView *table;
@property (nonatomic, retain) IBOutlet UIImageView *bottle;
@property (strong, nonatomic) IBOutlet UIView *needle;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIImageView *compass;

- (IBAction)rotateCompass:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)spinbottle:(id)sender;
- (IBAction)singleTap:(id)sender;

- (IBAction)klickAufFlasche:(id)sender;


@end
