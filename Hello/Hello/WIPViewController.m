//
//  WIPViewController.m
//  Hello
//
//  Created by Daniel Goebel on 24.09.12.
//  Copyright (c) 2012 Daniel. All rights reserved.
//

#import "WIPViewController.h"
#import "WIPBottle.h"
#import "WIPCompass.h"

@interface WIPViewController ()

@end

@implementation WIPViewController

@synthesize table, bottle;
@synthesize locationManager = _locationManager;





- (IBAction)rotateCompass:(id)sender {
    
    UISlider *slider = sender;
    
    self.compass.transform = CGAffineTransformMakeRotation(M_PI / 180 * slider.value);
}

- (IBAction)rotateBoth:(id)sender {
    
    
    
    UISlider *slider = sender;
    
    self.compass.transform = CGAffineTransformMakeRotation(M_PI / 180 * slider.value);



}


- (IBAction)sliderValueChanged:(id)sender {
    
    
    UISlider *slider = sender;

    
    NSLog(@"Slider Wert = %f",slider.value);
    self.needle.transform = CGAffineTransformMakeRotation(M_PI / 180 * slider.value);
    
    
}




-(IBAction) spinbottle:(id)sender {
    
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationRepeatCount:1];
    bottle.transform = CGAffineTransformRotate(bottle.transform,M_PI/4);
    [UIView commitAnimations];
    
     NSLog(@"spinbottle");
}




-(void)gestureTapEvent:(UITapGestureRecognizer *)gesture {

    CGPoint tapPoint = [gesture locationInView:table];
    int tapX = (int) tapPoint.x;
    int tapY = (int) tapPoint.y;
    NSLog(@"TAPPED X:%d Y:%d", tapX, tapY);
    
    float tap = atan2(tapX,tapY);
    // 4 - Save current transform
    
    
    NSLog(@"tapSSS:%f",  tap);

    
    
    
    // 2 - Calculate distance from center
    float dx = tapPoint.x - 420;
    float dy = tapPoint.y - 460;
    // 3 - Calculate arctangent value
    tap = atan2(dy,dx);
    // 4 - Save current transform
    
    
    NSLog(@"tap:%f",  tap);
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
   // WIPBottle *bottle = [[WIPBottle alloc] initWithFrame:CGRectMake(300, 300, self.view.bounds.size.width-400,self.view.bounds.size.height-400)
                                                  //  andDelegate:self
                                                  // withSections:1];
    // 3 - Add wheel to view
    //[self.view addSubview:bottle];
    
    
    UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapEvent:)];
    table.userInteractionEnabled = YES;
    [table addGestureRecognizer:myTapGesture];
    
    
    if ([CLLocationManager headingAvailable]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.headingFilter = 2;
        [self.locationManager startUpdatingHeading];
    } else {
        NSLog(@"Leider unterstützt dieses Gerät keinen Kompass");
    }

    
    
    
    }

- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Kompass = %f",newHeading.magneticHeading);
    
    self.needle.transform = CGAffineTransformMakeRotation(M_PI / 180 * -newHeading.magneticHeading);

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
