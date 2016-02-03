//
//  WaterTableController.m
//  navag
//
//  Created by Heiby He on 09-4-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WaterTableController.h"
#import "WaterXMLParser.h"
#import "Const.h"
#import "MyTableCell.h"
#import "WebServices.h"
#import "Water1Controller.h"
#import "WaterInfoController.h"
#import "smellycatViewController.h"

@implementation WaterTableController

@synthesize myTable,hisc,pageIndex,navagController,totalNum;
- (id)initWithPageNumber:(int)page withTotalArray:(NSMutableArray *)tArray{
	if (self = [super init]) {
		if (self.hisc !=tArray) {
			[tArray retain];
			self.hisc = tArray;
		}
		pageIndex = page;
		totalNum = self.hisc.count;
		
		myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 306)];
		myTable.dataSource=self;
		myTable.delegate=self;
		[self.view addSubview:myTable];
		isLoaded=NO;
    }
    return self;
}
-(void)loadData{
	[myTable reloadData];
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */
- (void)getDataOnNewThread{
	if(!isLoaded){
		[myTable reloadData];
		isLoaded=YES;
	}
}

-(void)showAlertView{
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:@"数据库暂无此站点定位信息！" 
						  message:nil 
						  delegate:self 
						  cancelButtonTitle:@"确定" 
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 34.0; //returns floating point which will be used for a cell row height at specified row index  
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger temInt = (totalNum-(pageIndex-0)*9);
	return temInt/9>0?9:temInt%9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];

	if (cell == nil) {
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		NSArray *info=[hisc objectAtIndex:pageIndex*9+indexPath.row];
		
		NSString *jjzw=[NSString stringWithFormat:@"%@", [info objectAtIndex:7]];
		BOOL isChao=YES;
		if([jjzw isEqualToString:@"1"])
			isChao=YES;
		else {
			isChao = NO;
		}

		
		if(isChao)
			cell.contentView.backgroundColor=[UIColor yellowColor];
		
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 60.0,
																	tableView.rowHeight)];
		[cell addColumn:0];
		label.tag = 1;
		label.font = [UIFont systemFontOfSize:13.0];
		NSString *temN = [[info objectAtIndex:1] length]>0?[info objectAtIndex:1]:@"---";
		label.text = [NSString stringWithFormat:@" %@", temN];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor blackColor];
		if(isChao)
			label.backgroundColor=[UIColor yellowColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		label.numberOfLines=0;
		[cell.contentView addSubview:label]; 
		[label release];
		
		label =  [[UILabel	alloc] initWithFrame:CGRectMake(65.0, 0, 60.0,
															tableView.rowHeight)];
		[cell addColumn:63];
		label.tag = 2;
		label.font = [UIFont systemFontOfSize:13.0];
		// add some silly value
		NSString *temL = [[info objectAtIndex:3] length]>0?[info objectAtIndex:3]:@"---";
		label.text = [NSString stringWithFormat:@"%@", temL];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor blackColor];
		if(isChao)
			label.backgroundColor=[UIColor yellowColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleHeight;
		[cell.contentView addSubview:label];
		[label release];
		
		label =  [[UILabel	alloc] initWithFrame:CGRectMake(130.0, 0, 80.0,
															tableView.rowHeight)];
		[cell addColumn:127];
		label.tag = 4;
		label.font = [UIFont systemFontOfSize:13.0];
		// add some silly value
		NSString *temT = [[info objectAtIndex:4] length]>0?[[info objectAtIndex:4] substringFromIndex:3]:@"---";
		label.text = [NSString stringWithFormat:@"%@",temT];
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor blackColor];
		if(isChao)
			label.backgroundColor=[UIColor yellowColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		label.numberOfLines=0;
		[cell.contentView addSubview:label];
		[label release];
		
		label =  [[UILabel	alloc] initWithFrame:CGRectMake(213.0, 0, 48.0,
															tableView.rowHeight)];
		[cell addColumn:211];
		label.tag = 3;
		label.font = [UIFont systemFontOfSize:13.0];
		// add some silly value
		NSString *temV = [info objectAtIndex:5];
		if([temV floatValue] == 0)
			label.text = @"--    ";
		else
			label.text = [NSString stringWithFormat:@"%.2f", [temV floatValue]];
		label.textAlignment = UITextAlignmentRight;
		label.textColor = [UIColor blackColor];
		if(isChao)
			label.backgroundColor=[UIColor yellowColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleHeight;
        label.numberOfLines=0;
		[cell.contentView addSubview:label];
		[label release];
		
		
		label =  [[UILabel	alloc] initWithFrame:CGRectMake(274.0, 0, 42.0,
															tableView.rowHeight)];
		[cell addColumn:271];
		label.tag = 6;
		label.font = [UIFont systemFontOfSize:13.0];
		// add some silly value
		NSString *temC =[info objectAtIndex:6];
		if([temC floatValue] == 0)
			label.text = @"--    ";
		else
			label.text = temC;
		label.textAlignment = UITextAlignmentRight;
		label.textColor = [UIColor blackColor];
		if(isChao)
			label.backgroundColor=[UIColor yellowColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleHeight;
        label.numberOfLines=0;
		[cell.contentView addSubview:label];
		[label release];
	}
	
	return cell;	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = indexPath.row;
	if (row != NSNotFound) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		NSArray *lInfo = [self.hisc objectAtIndex:pageIndex*9+indexPath.row];
		NSString *temStr = [NSString stringWithFormat:@"水情"];
		NSString *lng = [lInfo objectAtIndex:10];
		NSString *lat = [lInfo objectAtIndex:11];
		if (lng!=nil&&lat!=nil) {
			smellycatViewController *myCon = [smellycatViewController sharedCat];
			objc_msgSend(myCon,@selector(setLocationLon:withType:),lInfo,temStr);
		}else {
			[self showAlertView];
		}

	}
}

- (void)dealloc {
	[myTable release];
	[navagController release];
	[hisc release];
	[super dealloc];
}


@end
