//
//  WIPBottle.m
//  Hello
//
//  Created by Daniel Goebel on 24.09.12.
//  Copyright (c) 2012 Daniel. All rights reserved.
//

#import "WIPBottle.h"
#import <QuartzCore/QuartzCore.h>

@interface WIPBottle()
- (void)drawWheel;
@end

static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation WIPBottle

@synthesize delegate, container, numberOfSections, startTransform;



- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        [self drawWheel];
        // 4 - Timer for rotating wheel
        // [NSTimer scheduledTimerWithTimeInterval:2.0
        //                                  target:self
        //                                selector:@selector(rotate)
        //                                userInfo:nil
        //                                 repeats:YES];
  
	}
    return self;
}

- (void) drawWheel {
    // 1
    container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 358, 948)];
    // 2
    CGFloat angleSize = 2*M_PI/numberOfSections;
   
    // 3 - Create the sectors
	for (int i = 0; i < numberOfSections; i++) {
        // 4 - Create image view
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Xante%20Bottle.png"]];
        im.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        im.tag = i;
        if (i == 0) {
            im.alpha = maxAlphavalue;
        }
		// 5 - Set sector image
       // UIImageView *sectorImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
        //sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
       // sectorImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Xante%20Bottle.png", i]];

        
        
       // [im addSubview:sectorImage];
        
        
        
        // 6 - Add image view to container
        [container addSubview:im];
	}
    
    
    
    
    
    // 7
    container.userInteractionEnabled = NO;
    [self addSubview:container];
  }



- (void) rotate {
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -0.78);
    container.transform = t;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
      NSLog(@"tap (%f,%f)", touchPoint.x, touchPoint.y);
    // 1.1 - Get the distance from the center
    float dist = [self calculateDistanceFromCenter:touchPoint];
    // 1.2 - Filter out touches too close to the center
    if (dist < 40 || dist > 19900)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    // 2 - Calculate distance from center
    float dx = touchPoint.x - container.center.x;
    float dy = touchPoint.y - container.center.y;
    // 3 - Calculate arctangent value
    deltaAngle = atan2(dy,dx);
    // 4 - Save current transform
    startTransform = container.transform;
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    CGPoint pt = [touch locationInView:self];
    float dx = pt.x  - container.center.x;
    float dy = pt.y  - container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    
    
    return YES;
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float dx = point.x - center.x;
    float dy = point.y - center.y;
    return sqrt(dx*dx + dy*dy);
}

- (UIImageView *) getSectorByValue:(int)value {
    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}

@end