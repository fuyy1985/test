//
//  OneAroundView.m
//  smellycat
//
//  Created by GPL on 13-1-30.
//
//

#import "OneAroundView.h"
@interface TDABadgeView ()

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) NSUInteger width;

@end

@implementation TDABadgeView
@synthesize width, badgeNumber,badgeColor;
// from private
@synthesize font;

- (id) initWithFrame:(CGRect)frame myBadgeNumber:(NSString *)mybadNum
{
	if (self = [super initWithFrame:frame])
	{
		self.badgeNumber = mybadNum;
		font = [[UIFont boldSystemFontOfSize: 12] retain];
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (void) drawRect:(CGRect)rect
{
	NSString *countString = self.badgeNumber;
	CGSize numberSize = [countString sizeWithFont: font];
	self.width = numberSize.width + 16;
	CGRect bounds = CGRectMake(0 , 0, numberSize.width + 16 , 16);
	CGContextRef context = UIGraphicsGetCurrentContext();
	float radius = bounds.size.height / 2.0;
	
	CGContextSaveGState(context);
	UIColor *col =[UIColor blackColor];
	//col = [UIColor colorWithRed:0.530 green:0.600 blue:0.738 alpha:1.000];
	
	CGContextSetFillColorWithColor(context, [col CGColor]);
	
	CGContextBeginPath(context);
	CGContextAddArc(context, radius, radius, radius, M_PI / 2 , 3 * M_PI / 2, NO);
	CGContextAddArc(context, bounds.size.width - radius, radius, radius, 3 * M_PI / 2, M_PI / 2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
	bounds.origin.x = (bounds.size.width - numberSize.width) / 2 +0.5;
	//CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextSetBlendMode(context, kCGBlendModeClear);
	[countString drawInRect:bounds withFont:self.font];
}

- (void) dealloc
{
	[font release];
	[badgeColor release];
	[super dealloc];
}

@end


@implementation OneAroundView
@synthesize delegate,badgeNumber;
-(id)initWithFrame:(CGRect)frame WithImage:(UIImage *)imageType convertWData:(NSString *)info{
	if (self = [super initWithFrame:frame])
	{
		CGSize imgSize = imageType.size;
		UIImageView *myImageView = [[UIImageView alloc] initWithImage:imageType];
		[self addSubview:myImageView];
		[myImageView release];
		
		myButton = [UIButton buttonWithType:UIButtonTypeCustom];
		myButton.frame = CGRectMake(0,0,imgSize.width,imgSize.height);
		if (info!=nil&&[info intValue]>0){
			[myButton addTarget:self action:@selector(drawWaterPointAndSPopver:) forControlEvents:UIControlEventTouchUpInside];
			[myButton setImage:[UIImage imageNamed:@"show_touch.png"]  forState:UIControlStateHighlighted];
		} else {
			[myButton setEnabled:NO];
		}
		
		[self addSubview:myButton];
		
		if (info!=nil&&[info intValue]>0) {
			self.badgeNumber = info;
			TDABadgeView *myBadge = [[TDABadgeView alloc] initWithFrame:CGRectZero myBadgeNumber:info];
			CGSize badgeSize = [info sizeWithFont:[UIFont boldSystemFontOfSize: 14]];
			badgeSize.width = badgeSize.width + 16;
			CGRect badgeframe;
			badgeframe = CGRectMake(imgSize.width-badgeSize.width/2, -badgeSize.height/2,badgeSize.width, badgeSize.height);
			[myBadge setFrame:badgeframe];
			[myBadge setBadgeNumber:info];
			myBadge.badgeColor = [UIColor colorWithRed:0.530 green:0.600 blue:0.738 alpha:1.000];
			[self addSubview:myBadge];
		}
	}
	return self;
}

-(IBAction)drawWaterPointAndSPopver:(id)sender{
	[delegate dealWithAroundPacType:self convertProjectType:self.tag];
}

- (void)dealloc {
	[badgeNumber release];
    [super dealloc];
}


@end

