//
//  CustomHornButton.m
//		
//
//  Created by apple on 11-6-2.
//  Copyright 2011 zjdayu. All rights reserved.
//

#import "CustomHornButton.h"


@implementation CustomHornButton
@synthesize needAnimated;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code.
	self.backgroundColor = [UIColor clearColor];
	UIImageView *myIMV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 31)];
	myIMV.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"当前点1.png"],
						 [UIImage imageNamed:@"当前点2.png"],[UIImage imageNamed:@"当前点3.png"],nil];
	myIMV.animationDuration = 1.2f;
	myIMV.animationRepeatCount = 0;
	[myIMV startAnimating];
	[self addSubview:myIMV];
}


- (void)dealloc {
    [super dealloc];
}


@end
