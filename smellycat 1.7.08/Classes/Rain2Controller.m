//
//  Rain2Controller.m
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Rain2Controller.h"
#import "MyChart.h"
#import "RainXmlParser.h"
#import "FileManager.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"
static Rain2Controller *me=nil;
@implementation Rain2Controller

@synthesize zcode,wsys,type,rainDays,title;
@synthesize  ntitle,emmcd,dist;
@synthesize myActivity;
- (void)addRainItem:(NSMutableArray *)Items{
	if (Items!=rainDays) {
		[Items retain];
		rainDays=Items;
	}
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)tit withEmmcd:(NSString *)emmcdt withDist:(NSString *)disti {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		if (self.ntitle != tit) {
			[tit retain];
			self.ntitle = tit;
		}
		if (self.emmcd != emmcdt) {
			[emmcdt retain];
			self.emmcd = emmcdt;
		}
		if (self.dist != disti) {
			[disti retain];
			self.dist = disti;
		}
		me=self;
	}
	return self;
}

+(id)shareRain2{
	return me;
}

- (void)viewWillAppear:(BOOL)animated {
	
    CGSize size = {320, 322}; // size of view in popover
    self.contentSizeForViewInPopover = size;
    [super viewWillAppear:animated];
	
}

// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
	[self.myActivity startAnimating];
	[NSThread detachNewThreadSelector:@selector(backgroundFetchData) toTarget:self withObject:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//background
-(void)backgroundFetchData{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mRain"]];
	[config release];
	
    NSString *convertV = [NSString stringWithFormat:@"%@",self.emmcd];
    NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"RainStationDetails" Parameter:convertV];
    
	//parse XML
	RainDetailXMLParser *paser=[[RainDetailXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	
	[self performSelectorOnMainThread:@selector(showRectMap) withObject:nil waitUntilDone:YES];
	[pool release];
}

-(void)showRectMap{
	zcode.text=self.emmcd;
	wsys.text=[NSString stringWithFormat:@"%@●最近7日降雨过程线",[self.ntitle stringByReplacingOccurrencesOfString:@" " withString:@""]];
	type.text=[NSString stringWithFormat:@"%@", self.dist];
	
	//add chart
	CGRect f=CGRectMake(2, 36, 316, 272);
	MyChart *chartView=[[MyChart alloc] initWithFrame:f with:rainDays];
	chartView.frame = f;
	[self.view addSubview:chartView];
	[chartView release];
	
	[self.myActivity stopAnimating];
	[self.myActivity removeFromSuperview];
}

-(IBAction)removePin:(id)sender{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon performSelector:@selector(removeRWPin)];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

- (void)dealloc {
	if ([NSThread isMainThread]) {
//		NSLog(@"Now I'm in MainThread!");
		[rainDays release];
		[wsys release];
		[zcode release];
		[type release];
		[ntitle release];
		[myActivity release];
		[super dealloc];
	} else {
//		NSLog(@"Now I'm in secondary thread!");
		[rainDays release];
		[wsys release];wsys=nil;
		[zcode release];zcode=nil;
		[type release];type=nil;
		[ntitle release];
		[myActivity release];myActivity=nil;
	}
}


@end
