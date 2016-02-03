//
//  RainSDInfoController.m
//  smellycat
//
//  Created by apple on 10-12-2.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "RainSDInfoController.h"
#import "MyChart.h"
#import "RainXmlParser.h"
#import "FileManager.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"

static RainSDInfoController *me=nil;
@implementation RainSDInfoController
@synthesize wsys,rainDays,info;
@synthesize lat,lon;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withRainID:(NSString *)rainID withRainName:(NSString *)rainNM withRainAdd:(NSString *)rainAdd{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		me = self;
		
		NSString *temRainID;
		if (temRainID!=rainID) {
			[rainID retain];
			temRainID = rainID;
		}
		NSString *temRainNM;
		if (temRainNM!=rainNM) {
			[rainNM retain];
			temRainNM = rainNM;
		}
		NSString *temRainAdd;
		if (temRainAdd!=rainAdd) {
			[rainAdd retain];
			temRainAdd =rainAdd;
		}
		
		RainInfo *temInfo = [RainInfo rainInfo];
		temInfo.stcdt = rainID;
		temInfo.subnm = rainNM;
		temInfo.dsc = rainAdd;
		
		self.info = temInfo;
		
		[temInfo release];
    }
    return self;
}

+(id)shareSRain2{
	return me;
}

- (void)addSRainItem:(NSMutableArray *)Items{
	if (Items!=rainDays) {
		[Items retain];
		rainDays=Items;
	}
}

- (void)viewWillAppear:(BOOL)animated {
    CGSize size = {320, 410}; // size of view in popover
    self.contentSizeForViewInPopover = size;
    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mRain"]];
	[config release];
	
    NSString *convertV = [NSString stringWithFormat:@"%@",info.stcdt];
    NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"RainStationDetails" Parameter:convertV];
    
	//parse XML
	RainSDetailXMLParser *paser=[[RainSDetailXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	[pool release];
	
	NSMutableArray *temArray = [[NSMutableArray alloc] init];	
	if (([self.rainDays count]-2)>0) {
		for (int i=0; i<[self.rainDays count]; i++) {
//			printf("\naaa\n");
			NSMutableString *myStr;
			myStr = [self.rainDays objectAtIndex:i];
			if (i>1) {
				[temArray addObject:myStr];
			} else if (i==0) {
				self.lat = [NSString stringWithFormat:@"%@",myStr];
			} else if (i==1) {
				self.lon = [NSString stringWithFormat:@"%@",myStr];
			} 
		}	
	}
	
	//add chart
	CGRect f=CGRectMake(2, 36, 316, 272);
	MyChart *chartView=[[MyChart alloc] initWithFrame:f with:temArray];
	[temArray release];
	chartView.frame = f;
	[self.view addSubview:chartView];
	[chartView release];
	
	[self locationToPoint];
}

- (void)viewDidAppear:(BOOL)animated{
	wsys.text=[info.dsc stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)locationToPoint{
	NSString *sname ;
	if ([self.lon length]>0&&[self.lat length]>0) {
		sname = info.subnm;
	} else {
		lon = [[NSString stringWithFormat:@"120.903"] retain];
		lat = [[NSString stringWithFormat:@"29.5085"] retain];
		sname = [[NSString stringWithFormat:@"获取站点定位信息失败"] retain];
	}
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	objc_msgSend(myCon,@selector(setSLocationLon:LocationLat:PointName:PointData:PointType:),self.lon ,self.lat,sname ,@"",@"");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	if ([NSThread isMainThread]) {
//		NSLog(@"Now I'm in MainThread!");
		[lat release];
		[lon release];
		[info release];
//		printf("mes%d\n",[rainDays retainCount]);
		[rainDays release];
		[wsys release];
		[super dealloc];
	} else {
//		NSLog(@"Now I'm in secondary thread!");
	}
}


@end
