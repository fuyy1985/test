//
//  SearchController.m
//  navag
//
//  Created by Heiby He on 09-3-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchDogController.h"
#import "MyTableCell.h"
#import "WebServices.h"
#import "Const.h"
#import "SearchXMLParser.h"
#import "typhoonXMLParser.h"
#import "TyphoonSListPopovers.h"
#import "smellydogViewController.h"
#import "FileManager.h"

static SearchDogController *me=nil;
@implementation SearchDogController

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
	smellydogViewController *myCon = [smellydogViewController sharedDog];
	[myCon dismissSearch];
}

-(void)clearSearch:(id)sender{
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
	NSString *typhoonURL=[NSString stringWithFormat:@"%@/", [config getValue:@"mTyphoon"]];
	[config release];
    
	NSURL *baseURL=[WebServices getNRestUrl:typhoonURL Function:@"TyphoonSearch" Parameter:searchKey];
	SearchDogXMLParser *paser4=[[SearchDogXMLParser alloc] init];
	[paser4 parseXMLFileAtURL:baseURL parseError:nil];
	[paser4 release];
	
	[pool release];	
	[myTable reloadData];
	[self removeWaitting];
}

-(void)dealWithTyPh:(NSString *)dTfid{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    FileManager *config=[[FileManager alloc] init];
    NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getValue:@"mTyphoon"]];
	[config release];
    
    NSString *searchKey = [NSString stringWithFormat:@"%@",dTfid];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"TyphoonHistoryTracks" Parameter:searchKey];
	
	//parse XML
	sHistoryTyphoonDogXMLParser *paser=[[sHistoryTyphoonDogXMLParser alloc] init];
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
	if([info.srSort compare:@"台风"] == NSOrderedSame)
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
		if([info.srSort compare:@"台风"] == NSOrderedSame){
			[self addWaitting];
			ISTYPHOON = YES;
			[self performSelector:@selector(forWatting:) withObject:info afterDelay:0.00001];
		}
		
	}
}

-(void)forWatting:(SearchReaultInfo *)myInfo{
	[self.hiscPath removeAllObjects];
	[self dealWithTyPh:myInfo.srEnnmcd];
	smellydogViewController *myCon = [smellydogViewController sharedDog];
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
