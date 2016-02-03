//
//  Work3Controller.m
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorkXMLParser.h"
#import "Work3SController.h"
#import "MyTableCell.h"
#import "WebServices.h"
#import "FileManager.h"
#import "const.h"
#import "smellycatViewController.h"

static Work3SController *me=nil;
@implementation Work3SController

@synthesize info,tabBar,myWeb,JSONStr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		list2=[[NSMutableArray alloc] init];
		list=[[NSMutableArray alloc] init]; 
		me=self;
	}
	return self;
}

+(id)sharedWork3{
	return me;
}

- (void)viewDidAppear:(BOOL)animated{
	[self initSegment];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.*/
- (void)viewDidLoad {
	self.contentSizeForViewInPopover = CGSizeMake(320, 418);
	myWeb.hidden = YES;
	[self LocationPoint];
}
 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

-(void)getJSON:(NSString *)item{
	self.JSONStr = [NSString stringWithFormat:@"%@", item];
}


-(void)LocationPoint{	
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	NSString *baseURL = [NSString stringWithFormat:@"http://%@/%@/",ServerMain,MainServerURLPath];
	NSURL *countURL=[WebServices getRestUrl:baseURL Function:@"GetProjectCoordinate" Parameter:[NSDictionary dictionaryWithObjectsAndKeys:info.ennmcd,@"ennmcd",nil]];
	WorkJSONXMLParser *paser=[[WorkJSONXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	[pool release];
	
	NSDictionary *myDic = [NSDictionary dictionaryWithJSONString:self.JSONStr];
	
	NSString *standLon = [myDic objectForKey:@"lngO"];
	NSString *standLat = [myDic objectForKey:@"latO"];
	//NSString *sateLon = [myDic objectForKey:@"latO"];
	//NSString *sateLat = [myDic objectForKey:@"lng"];
	NSString *sname = [myDic objectForKey:@"ennm"];
	if ([standLon length]>0&&[standLat length]>0) {
		smellycatViewController *myCon = [smellycatViewController sharedCat];
		objc_msgSend(myCon,@selector(setSLocationLon:LocationLat:PointName:PointData:PointType:),standLon ,standLat,sname ,@"",@"");
	}
}

-(void)initWater{
	type=1;
}
-(void)initSluice{
	type=2;
}
-(void)initRiver{
	type=3;
}
-(void)initDike{
	type=4;
}
-(void)initFormation{
	type=5;
}
-(void)initPowerStation{
	type=6;
}
-(void)initIrrigation{
	type=7;
}
-(void)initReclamation{
	type=8;
}
-(void)initRankIrrigation{
	type=9;
}
-(void)initWeiyuan{
	type=10;
}
-(void)initController{
	type=11;
}
-(void)initFlood{
	type=12;
}

-(void)loadData:(NSString *)tname{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	
	NSString *baseURL = [NSString stringWithFormat:@"http://%@/%@/",ServerMain,MainServerURLPath];
	NSURL *countURL=[WebServices getRestUrl:baseURL Function:@"loadProjectInfo" Parameter:[NSDictionary dictionaryWithObjectsAndKeys:info.ennmcd,@"ennmcd",tname,@"type",info.en_gr,@"en_gr",nil]];
	//parse XML
	WorkSDetailXMLParser *paser=[[WorkSDetailXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	
	[pool release];
}

-(IBAction)chageTable{
	NSArray *li;
	[list removeAllObjects];
	NSInteger selectedSegment = tabBar.selectedSegmentIndex;
//	NSLog(@"selected %d",selectedSegment);
	if(selectedSegment>=0&&[list2 count]>0){
		NSArray *mt=[list2 objectAtIndex:selectedSegment];
		NSString *tname=[mt objectAtIndex:1];
		NSInteger tType=[[mt objectAtIndex:2] intValue];
		
		switch(tType)
		{
			case 1:
				[self loadData:tname];
				[myTable reloadData];
				myTable.hidden = NO;
				myWeb.hidden = YES;
				break;
			case 2:
				[self loadData:tname];
				li=[list objectAtIndex:0];
//				NSLog([li objectAtIndex:1]);
				[myWeb loadHTMLString:[NSString stringWithFormat:@"<div style=\"margin:0;font-size:16px\">%@</div>",[li objectAtIndex:1]] baseURL:nil];
				myTable.hidden = YES;
				myWeb.hidden = NO;
				break;
			case 3:
				
				break;
			default:
				break;
		}
	}
}

-(void)addList:(NSArray *)li{
	NSMutableString *t1=[[NSMutableString alloc] initWithString:[li objectAtIndex:0]];
	NSMutableString *t2=[[NSMutableString alloc] initWithString:[li objectAtIndex:1]];
	
	[t1 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
	[t1 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
	[t2 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
	[t2 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
	
	[list addObject:[NSArray arrayWithObjects:t1,t2,nil]];
	
	[t1 release];
	[t2 release];

	//[myTable reloadData];
}

-(void)initSegment{
	[list2 removeAllObjects];
	[tabBar removeAllSegments];
	
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL = [NSString stringWithFormat:@"http://%@/%@/",ServerMain,MainServerURLPath];
	[config release];
	NSURL *countURL=[WebServices getRestUrl:baseURL Function:@"loadTableName" Parameter:[NSDictionary dictionaryWithObjectsAndKeys:info.ennmcd,@"ennmcd",nil]];
	//parse XML
	WorkSTableNameXMLParser *paser=[[WorkSTableNameXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	
	[pool release];
}

-(void)addSegment:(NSArray *)ti{
	NSMutableString *t1=[NSMutableString stringWithString:[ti objectAtIndex:0]];
	NSMutableString *t2=[NSMutableString stringWithString:[ti objectAtIndex:1]];
	NSMutableString *t3=[NSMutableString stringWithString:[ti objectAtIndex:2]];
	
	[t1 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
	[t1 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
	[t2 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
	[t2 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
	[t3 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t3 length])];
	[t3 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t3 length])];
	
	[list2 addObject:[NSArray arrayWithObjects:t1,t2,t3,nil]];
	
	[tabBar insertSegmentWithTitle:t1 atIndex:[list2 count]-1 animated:NO];
	if(tabBar.numberOfSegments>[list2 count])
		[tabBar removeSegmentAtIndex:tabBar.numberOfSegments-1 animated:NO];
}

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 35.0; //returns floating point which will be used for a cell row height at specified row index  
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//tableView.rowHeight=20;
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];	
	//if (cell == nil) {
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	//}
	
		NSArray *li=[list objectAtIndex:indexPath.row];
		//add Column
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 180.0, 
																	tableView.rowHeight-2)]; 
		[cell addColumn:0];
		label.tag = 1; 
		label.font = [UIFont systemFontOfSize:16.0]; 
		label.text = [NSString stringWithFormat:@"  %@",[li objectAtIndex:0]];
		label.textAlignment = UITextAlignmentLeft; 
		label.textColor = [UIColor blackColor]; 
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label];
		[label release];
		//add column
		label = [[UILabel	alloc] initWithFrame:CGRectMake(185.0, 0, 130.0, 
															tableView.rowHeight-2)]; 
		[cell addColumn:180];
		label.tag = 1; 
		label.font = [UIFont systemFontOfSize:16.0]; 
		label.text = [NSString stringWithFormat:@"%@  ",[li objectAtIndex:1]];
		label.textAlignment = UITextAlignmentRight; 
		label.textColor = [UIColor blueColor]; 
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label];
		[label release];
		
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {

	
	if ([NSThread isMainThread]) {
//		NSLog(@"Now I'm in MainThread!");
		[info release];
		[tabBar release];
		[myWeb release];
		[JSONStr release];
		[super dealloc];
	} else {
//		NSLog(@"Now I'm in secondary thread!");
	}
}

@end
