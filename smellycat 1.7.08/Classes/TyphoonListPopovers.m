//
//  TyphoonListPopovers.m
//  smellycat
//
//  Created by apple on 10-9-25.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "TyphoonListPopovers.h"
#import "MyTableCell.h"
#import "typhoonXMLParser.h"
#import "WebServices.h"
#import "smellycatViewController.h"

@implementation TyphoonListPopovers
@synthesize hiscPath;
@synthesize myTitle;
@synthesize myTitleLab;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withList:(NSMutableArray *)tfList withTYphoonInfo:(TFList *)typhoonInfo withInfo:(NSString *)cInfo{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		[tfList retain];
		[self.hiscPath release];
		self.hiscPath = tfList;
		[tfList release];
		
		[cInfo retain];
		[self.myTitle release];
		self.myTitle = cInfo;
		[cInfo release];
		/*
		//use for navigation_titlt_text
		CGRect frame = CGRectMake(0, 0, 320, 44);
        UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        //label.text = NSLocalizedString(@"PageThreeTitle", @"");
		label.text= [NSString stringWithFormat:@"路径信息●%@",typhoonInfo.cNAME];
		//self.navigationItem.titleView=label;
		[self.view addSubview:label];
		 */
	}
	return self;
}

-(void)viewDidAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(266, 332);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.myTitleLab.text = [NSString stringWithFormat:@"历史台风●%@",self.myTitle];
}

-(IBAction)dismissPopover:(id)sender{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissRealTyphoon];
}



#pragma mark  tableView delegate && datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 34.0; //returns floating point which will be used for a cell row height at specified row index  
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [hiscPath count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil){
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		
		TFPathInfo * tfinfo=[hiscPath objectAtIndex:([hiscPath count] - indexPath.row - 1)];
		
		//add Column
		UILabel *labSJ = [[UILabel	alloc] initWithFrame:CGRectMake(10.0, 6, 100.0, 30)]; 
		labSJ.tag = 1; 
		labSJ.font = [UIFont systemFontOfSize:14.0]; 
		labSJ.text = tfinfo.RQSJ2;
		labSJ.textAlignment = UITextAlignmentLeft; 
		labSJ.textColor = [UIColor blueColor]; 
		labSJ.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:labSJ];
		[labSJ release];
		
		//add Column
		UILabel *labFL = [[UILabel	alloc] initWithFrame:CGRectMake(121.0, 6, 40.0, 30)]; 
		labFL.tag = 2; 
		labFL.font = [UIFont systemFontOfSize:14.0]; 
		labFL.text = [NSString stringWithFormat:@"%@", tfinfo.QY];
		labFL.textAlignment = UITextAlignmentLeft; 
		labFL.textColor = [UIColor blackColor]; 
		labFL.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:labFL];
		[labFL release];
		
		//add Column
		UILabel *labFS = [[UILabel	alloc] initWithFrame:CGRectMake(176.0, 6, 40.0, 30)]; 
		labFS.tag = 3; 
		labFS.font = [UIFont systemFontOfSize:14.0]; 
		labFS.text = [NSString stringWithFormat:@"%@", tfinfo.FL];
		labFS.textAlignment = UITextAlignmentLeft; 
		labFS.textColor = [UIColor blackColor]; 
		labFS.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:labFS];
		[labFS release];
		
		//add Column
		UILabel *labQY = [[UILabel	alloc] initWithFrame:CGRectMake(221.0, 6, 40.0, 30)]; 
		labQY.tag = 6; 
		labQY.font = [UIFont systemFontOfSize:14.0]; 
		labQY.text = [NSString stringWithFormat:@"%@", tfinfo.movesd];
		labQY.textAlignment = UITextAlignmentLeft; 
		labQY.textColor = [UIColor blackColor]; 
		labQY.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight; 
		[cell.contentView addSubview:labQY];
		[labQY release];
	}
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	return;
}


- (void)dealloc {
	[myTitle release];
	[myTitleLab release];
	[hiscPath release];
	[super dealloc];
}


@end
