//
//  WorkTableController.m
//  navag
//
//  Created by Heiby He on 09-5-4.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "WorkTableController.h"
#import "Const.h"
#import "WebServices.h"
#import "WorkXMLParser.h"
#import "FileManager.h"
#import "MyTableCell.h"
#import "Work3Controller.h"
#import "const.h"
#import "smellycatViewController.h"
#import "WorkListCell.h"
@implementation WorkTableController

@synthesize myTable,navagController,hisc,gclx,gcgm;
- (id)initWithPageNumber:(int)page wlx:(NSString *)lx wgm:(NSString *)gm;{
	if (self = [super init]) {
		// Initialization code
		pageIndex=page;
		self.gclx=lx;
		self.gcgm=gm;
		
		myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 350)];
		myTable.dataSource=self;
		myTable.delegate=self;
		[self.view addSubview:myTable];
		isLoaded=NO;
	}
	return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */

//- (void)initWithType:(NSString *) 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

-(void)loadData{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    FileManager *config=[[FileManager alloc] init];
	NSArray *locationArray=[config getLocation];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
    //NSString *baseURL = @"http://42.120.40.150/gq/DataService.asmx/";
	[config release];
	
	/*
	 pageIndex：当前页码； 
	 pageSize：每页条数；  
	 dscd:地区编码,如‘台州市 331000；
	 projectTypeName:工程类型名称,如：水库、水电站、河流、水闸、控制站等；  
	 scale：工程规模 传上一个方法里返回的en_gr的值，即1，2，3，4，5此类数据	 
	 */
	NSString *convertV = [NSString stringWithFormat:@"%d|%d|%@|%@|%@",pageIndex+1,WORK_NUMPAGE,[locationArray objectAtIndex:0],gclx,gcgm];
	NSURL *url=[WebServices getNRestUrl:baseURL Function:@"ProjectListWithWaterLevel" Parameter:convertV];
	WorkXMLParser *paser=[[WorkXMLParser alloc] init];
	paser.target=self;
	[paser parseXMLFileAtURL:url parseError:nil];
	[paser release];
	
	[pool release];		
}

-(void)addData:(WorkInfo *)info{
	if(hisc==nil)hisc=[[NSMutableArray alloc] init];
	[hisc addObject:info];
	[myTable reloadData];
}

- (void)getDataOnNewThread{
	if(!isLoaded){
		[NSThread detachNewThreadSelector:@selector(loadData) toTarget:self withObject:nil];
		//[self loadData];
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

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 50.0; //returns floating point which will be used for a cell row height at specified row index
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [hisc count];
}

- (NSString *)GetSampleName:(NSString *)ProjectName
{
	if([ProjectName compare:@"堤防（段）"] == NSOrderedSame)
	{
		return @"堤防";
	}
	else if([ProjectName compare:@"海堤（塘）"] == NSOrderedSame)
	{
		return @"海堤";
	}
	else if([ProjectName compare:@"机电排灌站"] == NSOrderedSame)
	{
		return @"排灌站";
	}
	else if([ProjectName compare:@"蓄滞（行）洪区"] == NSOrderedSame)
	{
		return @"蓄滞洪区";
	}
	else
	{
		return ProjectName;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkInfo *info=[hisc objectAtIndex:indexPath.row];

	static NSString *MyIdentifier = @"MyIdentifier";
    static NSString *MyOverIdentifier = @"MyOverIdentifier";
	WorkListCell *cell;
    BOOL isOver = [info.isOver isEqualToString:@"1"] ? YES:NO;
    if (isOver) {
        cell = (WorkListCell *)[tableView dequeueReusableCellWithIdentifier:MyOverIdentifier];
    } else {
        cell = (WorkListCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    }
	if (cell == nil) {
        CGRect cellRect = CGRectMake(0, 0, 320, 20);
        cell = [[[WorkListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        cell.frame = cellRect;
	}
    cell.object = info;
    [cell setValue];
	
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSUInteger row = indexPath.row;
    if (row != NSNotFound) {
		WorkInfo *info=[hisc objectAtIndex:row];
		if (info.standLat!=nil&info.standLon!=nil&info.satelliteLon!=nil&info.satelliteLat!=nil) {
			NSString *temStr = [NSString stringWithFormat:@"工情"];
			NSArray *temArr = [NSArray arrayWithObjects:info.standLon,info.standLat,info.satelliteLon,info.satelliteLat,info.ennm,info.ennmcd,info.en_gr,nil];
			smellycatViewController *myCon = [smellycatViewController sharedCat];
			objc_msgSend(myCon,@selector(setLocationLon:withType:),temArr,temStr);
		}  else {
			[self showAlertView];
		}
	}
}

- (void)dealloc {
	[myTable release];
	[navagController release];
	[hisc release];
	[gclx release];
	[gcgm release];
	[super dealloc];
}


@end
