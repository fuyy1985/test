//
//  OneTyphoonView.m
//  smellycat
//
//  Created by apple on 10-10-31.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "OneTyphoonView.h"
#import "typhoonXMLParser.h"

@implementation OneTyphoonView
@synthesize isActive,bottomSignal,delegate,bottomImageView,tfName;
-(id)initWithFrame:(CGRect)frame typhoonInfo:(TFList *)tf nowTyphoonInfo:(NSMutableArray *)infoArray{
	if ((self = [super initWithFrame:frame])) {
		// Initialization code
		self.tag = [tf.tfID intValue];
		isActive = NO;
		bottomSignal = YES;
		
		for (int i= 0; i<[infoArray count]; i++) {
			TFList *tempTFList = [infoArray objectAtIndex:i];
			if ([tf.tfID isEqualToString:tempTFList.tfID]) {
				isActive = YES;
				break;
			}
		}
		
		bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,4,46,46)];
		bottomImageView.image = [UIImage imageNamed:@"tfbg.png"];
		[self addSubview:bottomImageView];
		[bottomImageView release];
		
		tfImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 6, 22, 22)];
		if (isActive) {
			tfImage.animationImages =  [NSArray arrayWithObjects:    
												  [UIImage imageNamed:@"tf1.png"],
												  [UIImage imageNamed:@"tf2.png"],
												  [UIImage imageNamed:@"tf3.png"], nil];
			tfImage.animationDuration = 0.8f;
			tfImage.animationRepeatCount = 0;
			[tfImage startAnimating];
			
			[self up:@"5"];
		} else {
			tfImage.image = [UIImage imageNamed:@"tf1.png"];
		}

		[self addSubview:tfImage];

		tfName = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, 46, 15)];
		tfName.text = [tf.cNAME length]>1?tf.cNAME:tf.tfID;
		tfName.font = [UIFont boldSystemFontOfSize:12];
		tfName.textAlignment = UITextAlignmentCenter;
		tfName.backgroundColor = [UIColor clearColor];
		[self addSubview:tfName];

		tfID = [[UILabel alloc] initWithFrame:CGRectMake(32, 6, 13, 12)];
		tfID.text = [tf.tfID substringFromIndex:4];
		tfID.font = [UIFont boldSystemFontOfSize:11];
		tfID.textAlignment = UITextAlignmentCenter;
		tfID.backgroundColor = [UIColor clearColor];		
		[self addSubview:tfID];
		
		myButton = [UIButton buttonWithType:UIButtonTypeCustom];
		myButton.frame = CGRectMake(0, 4, 46, 46);
		[myButton addTarget:self action:@selector(jumpButtom:) forControlEvents:UIControlEventTouchUpInside];
		[myButton setImage:[UIImage imageNamed:@"show_touch.png"]  forState:UIControlStateHighlighted];
		[self addSubview:myButton];
	}
	return self;
}

-(IBAction)jumpButtom:(id)sender{
	NSString *myInt;

	if (bottomSignal && isActive==NO) {
		[delegate dealWithNonActiveTyphoon:self];

		self.bottomSignal = NO;
		myInt = @"5";
		[self down:myInt];
		myInt = @"11";
		[self performSelector:@selector(up:) withObject:myInt afterDelay:0.04f];
	} else if (bottomSignal==NO && isActive==NO) {
		self.bottomSignal = YES;
		myInt = @"6";
		[self performSelector:@selector(down:) withObject:myInt afterDelay:0.02f];
	}
	
	NSString *convertStr;
	if (isActive) {
		convertStr = [NSString stringWithString:@"YES"];
	} else {
		convertStr = [NSString stringWithString:@"NO"];
	}

	[self performSelector:@selector(active:) withObject:convertStr afterDelay:0.001];
}

-(IBAction)realJumpButtom:(id)sender{
	NSString *myInt;
	
	if (bottomSignal && isActive==NO) {		
		self.bottomSignal = NO;
		myInt = @"5";
		[self down:myInt];
		myInt = @"11";
		[self performSelector:@selector(up:) withObject:myInt afterDelay:0.04f];
	} else if (bottomSignal==NO && isActive==NO) {
		self.bottomSignal = YES;
		myInt = @"6";
		[self performSelector:@selector(down:) withObject:myInt afterDelay:0.02f];
	}
}

-(void)active:(NSString *)key{
	if ([key isEqualToString:@"YES"]) {
//		[delegate dealWithActiveTyphoon:self convertTfID:self.tag andWithTYName:self.tfName.text];
		
	} else {
		[delegate dealWithNonActiveTyphoon:self convertTfID:self.tag  andWithTYName:self.tfName.text];
	}
}

-(void)up:(NSString *)minus{
	CGRect oldFrame = self.frame;
	int myinta = [minus intValue];
	[self setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y-myinta, oldFrame.size.width, oldFrame.size.height)];
}

-(void)down:(NSString *)add{
	CGRect oldFrame = self.frame;
	int myinta = [add intValue];
	[self setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y+myinta, oldFrame.size.width, oldFrame.size.height)];
}

- (void)dealloc {
	[tfName release]; tfName = nil;
	[bottomImageView release];bottomImageView = nil;
	[tfID release]; tfID = nil;
	[tfName release]; tfName = nil;
    [super dealloc];
}

@end
