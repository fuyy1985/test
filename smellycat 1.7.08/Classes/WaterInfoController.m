//
//  WaterInfoController.m
//  navag
//
//  Created by Heiby He on 09-9-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WaterInfoController.h"
#import "MyTableCell.h"
#import "FileManager.h"
#import "WaterXMLParser.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"

static WaterInfoController *me;
@implementation WaterInfoController
@synthesize myTable, hisc, waterEnnmcd,titleLabel,waterName,myActivity;

+(id)sharedWater{
	return me;
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)tit withEmmcd:(NSString *)emmcdt withDist:(NSString *)disti{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.hisc = [[NSMutableArray alloc] init];
		if (waterEnnmcd != emmcdt) {
			[emmcdt retain];
			waterEnnmcd = emmcdt;
		}
		
		if (waterName != tit) {
			[tit retain];
			waterName = tit;
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	[self.myActivity startAnimating];
	[NSThread detachNewThreadSelector:@selector(backgroundFetchData) toTarget:self withObject:nil];
}

-(void)backgroundFetchData{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mRain"]];
	[config release];
    
    NSString *convetV  = waterEnnmcd;
	NSURL *ylfbURL=[WebServices getNRestUrl:baseURL Function:@"WaterStationDetails_Search" Parameter:convetV];
	//parse XML
	WaterInfoXmlParser *paser=[[WaterInfoXmlParser alloc] init];
	[paser parseXMLFileAtURL:ylfbURL parseError:nil]; 
	[paser release];
	[pool release];
	
	[self performSelectorOnMainThread:@selector(showList) withObject:nil waitUntilDone:YES];
}

-(void)showList{
	self.titleLabel.text = [self.waterName stringByReplacingOccurrencesOfString:@" " withString:@""];
	[self.myTable reloadData];
	[self.myActivity stopAnimating];
	[self.myActivity removeFromSuperview];
}

-(IBAction)removePin:(id)sender{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon performSelector:@selector(removeRWPin)];
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
	self.titleLabel = nil;
	self.myTable = nil;
	self.myActivity= nil;
}


- (void)dealloc {

	
	if ([NSThread isMainThread]) {
//		NSLog(@"Now I'm in MainThread!");
//		printf("Leaks:－－－－－－－－－－－－－－－%d",[waterName retainCount]);
//		printf("Leaks:－－－－－－－－－－－－－－－%d",[waterEnnmcd retainCount]);
		
		[waterName release];
		//[waterName release];
		[titleLabel release];
		[myTable release];
		[hisc release]; hisc = nil;
		[waterEnnmcd release];
		//[waterEnnmcd release];
		[myActivity release];
		[super dealloc];
	} else {
//		NSLog(@"Now I'm in secondary thread!");
		[waterName release];
		[hisc release]; hisc = nil;
		[waterEnnmcd release];
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
	if ([self.hisc count] >2) {
		return ([self.hisc count]-2);
	} else {
		return [self.hisc count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		
		NSMutableArray *item = [hisc objectAtIndex:indexPath.row];
		
		//add Column
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 168.0-30, 
																	tableView.rowHeight)]; 
		[cell addColumn:170-30];
		label.tag = 1; 
		label.font = [UIFont systemFontOfSize:14.0]; 
		label.text = [NSString stringWithFormat:@"   %@", [item objectAtIndex:0]];
		label.textAlignment = UITextAlignmentLeft; 
		label.textColor = [UIColor blackColor]; 
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:label];
		[label release];
		//add column
		label = [[UILabel	alloc] initWithFrame:CGRectMake(172.0-30, 0, 148.0-10, 
															tableView.rowHeight)]; 
		[cell addColumn:320-40];
		label.tag = 2; 
		label.font = [UIFont systemFontOfSize:14.0]; 
		NSMutableString *strText=[NSMutableString stringWithString:[item objectAtIndex:1]];
		[strText replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [strText length])];
		if(indexPath.row!=1)
		{
			[strText replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [strText length])];
		}
		label.text = [NSString stringWithFormat:@"  %@", strText];
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
