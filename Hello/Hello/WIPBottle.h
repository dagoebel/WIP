//
//  WIPBottle.h
//  Hello
//
//  Created by Daniel Goebel on 24.09.12.
//  Copyright (c) 2012 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIPBottleProtocol.h"

@interface WIPBottle : UIControl

@property (weak) id <WIPBottleProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;
@property CGAffineTransform startTransform;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;

-(void)rotate;

@end
