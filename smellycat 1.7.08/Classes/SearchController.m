//
//  SearchController.m
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"
#import "MyTableCell.h"
#import "FileManager.h"
#import "WebServices.h"
#import "Const.h"
#import "SearchXMLParser.h"
#import "typhoonXMLParser.h"
#import "TyphoonSListPopovers.h"
#import "RainSDInfoController.h"
#import "WaterSInfoController.h"
#import "WaterXMLParser.h"
#import "smellycatViewController.h"
#import "Work3SController.h"

static SearchController *me=nil;
@implementation SearchController

@synthesize myTable,hisc,mySearchBar,wattingView,hiscPath;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
		self.navigationItem.backBarButtonItem = left;
		[left release];
		
		self.hisc = [[NSMutableArray alloc] init];
		self.hiscPath = [[NSMutableArray alloc] init];
		me=self;
		
		//add close button
		UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[myButton setBackgroundImage:[UIImage imageNamed:@"close_normal.png"] forState:UIControlStateNormal];
		[myButton setBackgroundImage:nil forState:UIControlStateSelected];
		[myButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:myButton];
		self.navigationItem.rightBarButtonItem = right;
		[right release];
		[myButton release];
	}
	return self;
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.*/
- (void)viewDidLoad {
	[mySearchBar becomeFirstResponder];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStyleBordered target:self action:@selector(clearSearch:)];
	self.navigationItem.title = @"搜索";
	[self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
	[cancelButton release];
}

-(void)dismissPopover{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissSearch];
}

-(void)clearSearch:(id)sender{
//	if (self.hisc!=nil) {
//		[self.hisc release];
//		self.hisc = nil;
//		self.hisc = [[NSMutableArray alloc] init];
//	}
	[self.hisc removeAllObjects];
	[myTable reloadData];
	mySearchBar.text = [NSString stringWithFormat:@""];
}

-(void)addWaitting{
	if (self.wattingView.superview ==nil) {
		[self.view addSubview:self.wattingView];
	}
	[self.view bringSubviewToFront:self.wattingView];
}

-(void)removeWaitting{
	if (self.wattingView.superview !=nil) {
		[self.wattingView removeFromSuperview];
	}
}

-(void)viewWillAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(320, 368);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

+(id)sharedWork{
	return me;
}

-(void)addData:(SearchReaultInfo *)info{
//	[info retain];
	[hisc addObject:info];
	//[myTable reloadData];
}

#pragma mark SearchBar Delegate;
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];  
}  

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder]; 
	[self addWaitting];
	NSString *searchKey = searchBar.text;
	[self performSelector:@selector(dealWithData:) withObject:searchKey afterDelay:0.00001];
} 

-(void)dealWithData:(NSString*)txt{
	[hisc removeAllObjects];
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString *searchKey = [NSString stringWithFormat:@"%@",txt];
	
    FileManager *config=[[FileManager alloc] init];
    NSString *baseURLW=[NSString stringWithFormat:@"%@/", [config getValue:@"mWater"]];
    NSString *baseURLR=[NSString stringWithFormat:@"%@/", [config getValue:@"mRain"]];
    NSString *baseURLT=[NSString stringWithFormat:@"%@/", [config getValue:@"mTyphoon"]];
    NSString *baseURLP=[NSString stringWithFormat:@"%@/", [config getValue:@"mWork"]];
	[config release];
	
	NSURL *urlWater=[WebServices getNRestUrl:baseURLW Function:@"WaterSearch" Parameter:searchKey];
	SearchXMLParser *paser1=[[SearchXMLParser alloc] init];
	[paser1 parseXMLFileAtURL:urlWater parseError:nil];
	[paser1 release];	
	
	NSURL *urlRain=[WebServices getNRestUrl:baseURLR Function:@"RainSearch" Parameter:searchKey];
	SearchXMLParser *paser2=[[SearchXMLParser alloc] init];
	[paser2 parseXMLFileAtURL:urlRain parseError:nil];
	[paser2 release];
	
	NSURL *urlTyphoon=[WebServices getNRestUrl:baseURLT Function:@"TyphoonSearch" Parameter:searchKey];
	SearchXMLParser *paser3=[[SearchXMLParser alloc] init];
	[paser3 parseXMLFileAtURL:urlTyphoon parseError:nil];
	[paser3 release];
	
	NSURL *urlWork=[WebServices getNRestUrl:baseURLP Function:@"ProjectSearchFilter" Parameter:searchKey];
	SearchXMLParser *paser4=[[SearchXMLParser alloc] init];
	[paser4 parseXMLFileAtURL:urlWork parseError:nil];
	[paser4 release];
	
	[pool release];	
	[myTable reloadData];
	[self removeWaitting];
}

-(void)dealWithTyPh:(NSString *)dTfid{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mTyphoon"]];
	[config release];
	NSString *convertV3 = [NSString stringWithFormat:@"%@",dTfid];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:convertV3];
	
	//parse XML
	sHistoryTyphoonXMLParser *paser=[[sHistoryTyphoonXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	[pool release];
}

-(void)getHistoryTyphoonPath:(TFPathInfo *)item{
	[self.hiscPath addObject:item];
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
	return [hisc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	SearchReaultInfo *info=[hisc objectAtIndex:indexPath.row];
	
	NSString *strType = [NSString stringWithFormat:@" ■ %@", info.srType];
	if([info.srSort compare:@"雨情"] == NSOrderedSame || [info.srSort compare:@"水情"] == NSOrderedSame || [info.srSort compare:@"台风"] || [info.srSort compare:@"工情"] == NSOrderedSame)
		strType = @"";
	
	if (cell == nil) {
		cell = [[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier];
		cell.hideLine=YES;

		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 310,
																	tableView.rowHeight)];
		[cell addColumn:320];
		label.tag = 1;
		label.font = [UIFont systemFontOfSize:16.0];
		label.text = [NSString stringWithFormat:@"  %@%@ ■ %@", info.srSort,strType,info.srName];
		label.textAlignment = UITextAlignmentLeft;
		label.textColor = [UIColor blackColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		label.numberOfLines=0;
		[cell.contentView addSubview:label]; 
		[label release];
	}else{
		[cell.contentView removeFromSuperview];
		
		cell = [[MyTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier];
		cell.hideLine=YES;
		
		UILabel *label = [[UILabel	alloc] initWithFrame:CGRectMake(0.0, 0, 310,
																	tableView.rowHeight)];
		[cell addColumn:320];
		label.tag = 1;
		label.font = [UIFont systemFontOfSize:16.0];
		label.text = [NSString stringWithFormat:@"  %@%@ ■ %@", info.srSort,strType,info.srName];
		label.textAlignment = UITextAlignmentLeft;
		label.textColor = [UIColor blackColor];
		label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		label.numberOfLines=0;
		[cell.contentView addSubview:label]; 
		[label release];
	}
	
	return cell;	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[mySearchBar resignFirstResponder]; 
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	// Create a view controller with the title as its navigation title and push it.
    NSUInteger row = indexPath.row;
	BOOL ISTYPHOON = NO;
    if (row != NSNotFound) {
		SearchReaultInfo *info=[hisc objectAtIndex:row];
		if([info.srSort compare:@"雨情"] == NSOrderedSame){
			if (info.srStandLng!=nil&info.srStandLat!=nil&info.srSateLng!=nil&info.srSateLat!=nil) {
				NSString *temStr = [NSString stringWithFormat:@"搜雨情"];
				NSArray *temArr = [NSArray arrayWithObjects:info.srStandLng,info.srStandLat,info.srSateLng,info.srSateLat,info.srDescription,info.srEnnmcd,nil];
			//	NSArray *temArr = [NSArray arrayWithObjects:standlng,standlat,satelng,satelat,info.srDescription,info.srEnnmcd,info.srEngr,nil];
				smellycatViewController *myCon = [smellycatViewController sharedCat];
				objc_msgSend(myCon,@selector(setLocationLon:withType:),temArr,temStr);
			} else {
				[self showAlertView];
			}

		}else if([info.srSort compare:@"水情"] == NSOrderedSame){
			if (info.srStandLng!=nil&info.srStandLat!=nil&info.srSateLng!=nil&info.srSateLat!=nil) {
				NSString *temStr = [NSString stringWithFormat:@"搜水情"];
				NSArray *temArr = [NSArray arrayWithObjects:info.srStandLng,info.srStandLat,info.srSateLng,info.srSateLat,info.srDescription,info.srEnnmcd,nil];
				smellycatViewController *myCon = [smellycatViewController sharedCat];
				objc_msgSend(myCon,@selector(setLocationLon:withType:),temArr,temStr);
			} else {
				[self showAlertView];
			}
		}else if([info.srSort compare:@"工情"] == NSOrderedSame){
			if (info.srStandLng!=nil&info.srStandLat!=nil&info.srSateLng!=nil&info.srSateLat!=nil) {
				NSString *temStr = [NSString stringWithFormat:@"搜工情"];
				NSArray *temArr = [NSArray arrayWithObjects:info.srStandLng,info.srStandLat,info.srSateLng,info.srSateLat,info.srDescription,info.srEnnmcd,info.srEngr,nil];
				smellycatViewController *myCon = [smellycatViewController sharedCat];
				objc_msgSend(myCon,@selector(setLocationLon:withType:),temArr,temStr);
			} else {
				[self showAlertView];
			}
		}else if([info.srSort compare:@"台风"] == NSOrderedSame){
			[self addWaitting];
			ISTYPHOON = YES;
			[self performSelector:@selector(forWatting:) withObject:info afterDelay:0.00001];
		}
		
	}
}

-(void)forWatting:(SearchReaultInfo *)myInfo{
//	if (hiscPath!=nil) {
//		[hiscPath release];
//		hiscPath = nil;
//		hiscPath = [[NSMutableArray alloc] init];
//	}
	[self.hiscPath removeAllObjects];
	[self dealWithTyPh:myInfo.srEnnmcd];
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	NSString *myTfNm;
	if ([myInfo.srName length]>0) {
		NSArray *temArr = [myInfo.srName componentsSeparatedByString:@"·"];
		if ([temArr count]==2) {
			myTfNm = [temArr objectAtIndex:0];
		}else {
			return;
		}
	}
	if ([myTfNm length]<2) {
		myTfNm = [NSString stringWithString:@"未命名"];
	}
//	NSLog(myTfNm);
	objc_msgSend(myCon,@selector(receviceSearchTyphoonArrayAndDrawIt:WithName:WithID:),self.hiscPath,myTfNm,myInfo.srEnnmcd);
	[self removeWaitting];
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

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)dealloc {
	[hiscPath release];
	[wattingView release];
	[myTable release];
	[hisc release];
	[super dealloc];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   // [self filterContentForSearchText:searchString scope:
	 //[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    //[self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	// [self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
