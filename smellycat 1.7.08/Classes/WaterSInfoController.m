//
//  WaterInfoController.m
//  navag
//
//  Created by Heiby He on 09-9-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WaterSInfoController.h"
#import "MyTableCell.h"
#import "WaterXMLParser.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"

static WaterSInfoController *me;
@implementation WaterSInfoController
@synthesize myTable, hisc, waterEnnmcd,waterName;

+(id)sharedWater{
	return me;
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil withID:(NSString *)waterID withNM:(NSString *)waterNM bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.hisc = [[NSMutableArray alloc] init];
		
		if (waterEnnmcd != waterID) {
			[waterID retain];
			waterEnnmcd = waterID;
		}
		if (waterName != waterNM) {
			[waterNM retain];
			waterName = waterNM;
		}

		me = self;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(320, 360);
}
- (void)getWaterInfo:(NSMutableArray *)item{
	[self.hisc addObject:item];
}

-(void)locationToPoint{
	NSString *lon;
	NSString *lat;
	NSString *sname;
	
	if ([self.hisc count] >2) {
		NSMutableArray *temArray1 = [self.hisc objectAtIndex:[self.hisc count]-2];
		NSMutableArray *temArray2 = [self.hisc objectAtIndex:[self.hisc count]-1];
		lon = [temArray1 objectAtIndex:1];
		lat = [temArray2 objectAtIndex:1];
	} else {
		lon = [NSString stringWithFormat:@"120.903"];
		lat = [NSString stringWithFormat:@"29.5085"];
		sname = [NSString stringWithFormat:@"暂无信息"];
	}
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	objc_msgSend(myCon,@selector(setSLocationLon:LocationLat:PointName:PointData:PointType:),lon ,lat,self.waterName ,@"",@"米");
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSString *baseURL = [NSString stringWithFormat:@"http://%@/%@/",ServerMain,MainServerURLPath];
	
	NSURL *ylfbURL=[WebServices getRestUrl:baseURL Function:@"LoadSqBySearchWithXY" Parameter:[NSDictionary dictionaryWithObjectsAndKeys:waterEnnmcd, @"stcdt",nil]];
	//parse XML
	WaterSInfoXmlParser *paser=[[WaterSInfoXmlParser alloc] init];
	[paser parseXMLFileAtURL:ylfbURL parseError:nil]; 
	[paser release];
	
	[pool release];
	
	[self locationToPoint];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.myTable = nil;
}


- (void)dealloc {
	if ([NSThread isMainThread]) {
//		NSLog(@"Now I'm in MainThread!");
		//printf("Leaks:－－－－－－－－－－－－－－－%d",[waterEnnmcd retainCount]);
		[myTable release];
		[hisc release]; hisc = nil;
		[waterEnnmcd release];
		[waterName release];
		[super dealloc];
	} else {
//		NSLog(@"Now I'm in secondary thread!");
		[hisc release]; hisc = nil;
		[waterEnnmcd release];
		[waterName release];
	}
}

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 46.0; //returns floating point which will be used for a cell row height at specified row index  
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return ([self.hisc count]-2);
	//return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		
		NSMutableArray *item = [hisc objectAtIndex:indexPath.row];
		
		//add Column
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 168.0, 
																	tableView.rowHeight)]; 
		[cell addColumn:170];
		label.tag = 1; 
		label.font = [UIFont systemFontOfSize:16.0]; 
		label.text = [NSString stringWithFormat:@"   %@", [item objectAtIndex:0]];
		label.textAlignment = UITextAlignmentLeft; 
		label.textColor = [UIColor blackColor]; 
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label];
		[label release];
		//add column
		label = [[UILabel	alloc] initWithFrame:CGRectMake(170.0, 0, 148.0, 
															tableView.rowHeight)]; 
		[cell addColumn:320];
		label.tag = 2; 
		label.font = [UIFont systemFontOfSize:16.0]; 
		NSMutableString *strText=[NSMutableString stringWithString:[item objectAtIndex:1]];
		[strText replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [strText length])];
		if(indexPath.row!=1)
			[strText replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [strText length])];
		label.text = [NSString stringWithFormat:@"   %@", strText];
		label.textAlignment = UITextAlignmentLeft; 
		label.textColor = [UIColor blueColor]; 
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label];
		[label release];
	}
	
	return cell;	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
