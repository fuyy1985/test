//
//  RainTableController.m
//  GovOfQGJ
//
//  Created by DY-XL on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RainTableController.h"
#import "MyTableCell.h"
#import "Rain2Controller.h"
#import "WebServices.h"
#import "Const.h"
#import "Rain1Controller.h"
#import "smellycatViewController.h"
#include <objc/message.h>


@implementation RainTableController

@synthesize myTable,navagController,pageIndex,hisc,totalNum;
- (id)initWithPageNumber:(int)page withTotalArray:(NSMutableArray *)tArray {
    if (self = [super init]) {
		if (self.hisc!=tArray) {
			[tArray retain];
			self.hisc = tArray;
		}
        pageIndex = page;
		totalNum = self.hisc.count;
		isLoaded=NO;
		myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 285, 306)];
		myTable.dataSource=self;
		myTable.delegate=self;
		self.view=myTable;
    }
    return self;
}

-(void)loadData{
	[myTable reloadData];
}

- (void)getDataOnNewThread{
	if(!isLoaded){
		[myTable reloadData];
		isLoaded=YES;
//		NSLog(@"GetDateOnNewThread");
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
	[super didReceiveMemoryWarning]; 
	// Releases the view if it doesn't have a superview
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
		NSArray *info=[hisc objectAtIndex:(pageIndex-0)*9+indexPath.row];
		cell = [[[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
		
		UILabel *label1 = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 80,
																	tableView.rowHeight)];
		[cell addColumn:3];
		label1.tag = 1;
		label1.font = [UIFont systemFontOfSize:14.0];
		NSString *temN = [[info objectAtIndex:1] length]>0?[info objectAtIndex:1]:@"---";
		label1.text = temN;
		label1.textAlignment = UITextAlignmentCenter;
		label1.textColor = [UIColor blackColor];
		label1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		[cell.contentView addSubview:label1]; 
		[label1 release];
		
		UILabel *label2 =  [[UILabel	alloc] initWithFrame:CGRectMake(85, 0, 55,tableView.rowHeight)];
		[cell addColumn:85];
		label2.tag = 2;
		label2.font = [UIFont systemFontOfSize:14.0];
		NSString *temL = [[info objectAtIndex:3] length]>0?[info objectAtIndex:3]:@"---";
		label2.text = temL;
		label2.textAlignment = UITextAlignmentRight;
		label2.textColor = [UIColor blackColor];
		label2.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleHeight;
		[cell.contentView addSubview:label2];
		[label2 release];
		
		UILabel *label3 =  [[UILabel alloc] initWithFrame:CGRectMake(155, 0, 125.0,
															tableView.rowHeight)];
		[cell addColumn:145];
		label3.tag = 3;
		label3.font = [UIFont systemFontOfSize:14.0];
		NSString *temV = [[info objectAtIndex:2] length]>0?[info objectAtIndex:2]:@"---";
		label3.text = temV;
		label3.textAlignment = UITextAlignmentCenter;
		label3.textColor = [UIColor blackColor];
		label3.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleHeight;
		[cell.contentView addSubview:label3];
		[label3 release];
	}
//	NSLog(@"Draw Row %d", indexPath.row);
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSArray *lInfo = [self.hisc objectAtIndex:pageIndex*9+indexPath.row];
	NSString *temStr = @"雨情";
	NSString *lng = [lInfo objectAtIndex:7];
	NSString *lat = [lInfo objectAtIndex:8];
	if (lng!=nil&&lat!=nil) {
		smellycatViewController *myCon = [smellycatViewController sharedCat];
		objc_msgSend(myCon,@selector(setLocationLon:withType:),lInfo,temStr);
	} else {
		[self showAlertView];
	}
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)dealloc {
	[myTable release];
	[navagController release];
	[hisc release];
	[super dealloc];
}

@end
