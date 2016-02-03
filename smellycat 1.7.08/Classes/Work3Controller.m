//
//  Work3Controller.m
//  navag
//
//  Created by DY LOU on 10-3-25.
//  Copyright 2010 Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
//

#import "WorkXMLParser.h"
#import "Work3Controller.h"
#import "MyTableCell.h"
#import "WebServices.h"
#import "FileManager.h"
#import "WorkDetailCell.h"

static Work3Controller *me=nil;
@implementation Work3Controller

@synthesize myEnnm;
@synthesize myEnnmcd;
@synthesize myEngr;
@synthesize type;
@synthesize info;
@synthesize list;
@synthesize list2;
@synthesize heightArray;
@synthesize gclx;
@synthesize nowKey;
@synthesize backShow;
@synthesize nowLevel;
@synthesize warningLevel;
@synthesize beyondLeve;
@synthesize titleName;

@synthesize myTable;
@synthesize tabBar;
@synthesize myWeb;
@synthesize titleLabel;
@synthesize nowWaterLabel;
@synthesize nowWaterDateLabel;
@synthesize beyondTitleLabel;
@synthesize beyondLabel;
@synthesize beyondIcon;
@synthesize backBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		list2=[[NSMutableArray alloc] init];
		list=[[NSMutableArray alloc] init];
        heightArray = [[NSMutableArray alloc] init];
		info = [[WorkInfo workinfo] retain];
		me=self;
	}
	return self;
}

+(id)sharedWork3{
    return me;
}

- (void)viewDidAppear:(BOOL)animated{
	[NSThread detachNewThreadSelector:@selector(initSegment) toTarget:self withObject:nil];
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView {
}
 */

/*
 If you need to do additional setup after loading the view, override viewDidLoad.*/
- (void)viewDidLoad {
	myWeb.hidden = YES;
    if (backShow == YES) {
        backBtn.hidden = NO;
    } else {
        backBtn.hidden = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320-44, 347);
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //如果来自水情，那就还是隐藏
    self.navigationController.navigationBarHidden = YES;
}

-(IBAction)backToLastViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
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

-(void)setSegIndexEqualZeroAndFetch;
{
    self.tabBar.selectedSegmentIndex = 0;
    [self chageTable];
}

-(void)disableTabBar
{
    self.tabBar.enabled=NO;
}

-(void)loadData:(NSString *)tname{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getValue:@"mWork"]];
	[config release];
	/*
	 ennmcd:工程编码；
	 type:工程类别及规模组合；
	 sqlKey:sql关键字，对应ProjectTableName中的value	 
	*/
	
	NSString *convertV = [NSString stringWithFormat:@"%@|%@",myEnnmcd,tname];
	//NSLog(@"工程表格:%@",convertV);
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"ProjectInfo" Parameter:convertV];
    //NSURL *countURL = [NSURL URLWithString:@"http://pda.zjwater.gov.cn/DataCenterService/DataService.asmx/ProjectInfo?key=UuL7%252FQQ8uhYMGGkHld4DKyKO5HQZpuVVFM6yV57FYnQP3jlgAqL2aQa1BAJM9njDwuFG73OIwrU1U6hZbgs3KQ%253D%253D"];
	//parse XML
	WorkDetailXMLParser *paser=[[WorkDetailXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	[pool release];
    [self performSelectorOnMainThread:@selector(showTitle) withObject:nil waitUntilDone:NO];
}

-(IBAction)chageTable{
	//in the new evironment which is built by YJM on June 8th,2011
	NSArray *li;
	[list removeAllObjects];
    [heightArray removeAllObjects];
	NSInteger selectedSegment = tabBar.selectedSegmentIndex;
	//NSLog(@"selected %d",selectedSegment);
	if(selectedSegment>=0&&[list2 count]>0){
		NSArray *mt=[list2 objectAtIndex:selectedSegment];
		//all str
		NSString *tTypeSeg = [mt objectAtIndex:3];
		//type-1 tableview,type-2 webview
		NSInteger tType = [[mt objectAtIndex:2] intValue];
		switch(tType)
		{
			case 1:
				[self loadData:tTypeSeg];
				[myTable reloadData];
				myTable.hidden = NO;
				myWeb.hidden = YES;
				break;
			case 2:
				[self loadData:tTypeSeg];
				li=[list objectAtIndex:0];
				//NSLog([li objectAtIndex:1]);
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
    
    if ([t1 length] > 5) {
        NSString *subKey = [t1 substringToIndex:4];
        if ([subKey isEqualToString:@"最新水位"]) {
            NSString *nowTimeA = [t1 stringByReplacingOccurrencesOfString:@"最新水位(m)" withString:@""];
            NSString *nowTimeB = [nowTimeA stringByReplacingOccurrencesOfString:@"(" withString:@""];
            self.nowKey = [nowTimeB stringByReplacingOccurrencesOfString:@")" withString:@""];
            self.nowLevel = t2;
        } else if ([subKey isEqualToString:@"汛限水位"]) {
            self.warningLevel = t2;
        } else if ([subKey isEqualToString:@"超汛限水"]) {
            self.beyondLeve = t2;
        } else {
            [list addObject:[NSArray arrayWithObjects:t1,t2,nil]];
        }
    } else {
        [list addObject:[NSArray arrayWithObjects:t1,t2,nil]];
    }
    
    //NSLog(t1);
	
	[t1 release];
	[t2 release];
}

-(void)showTitle{
    //当没有汛限水位时
    BOOL isXX = NO;
    //当没有当前水位时
    BOOL isNow = NO;
    //超
    beyondIcon.hidden = YES;
    //富春江水库--初始值
    self.titleLabel.text = myEnnm;
    self.titleLabel.minimumFontSize = 17;
    self.titleLabel.frame = CGRectMake(34, 11, 102, 21);
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    if (nowKey !=nil && [nowKey isEqualToString:@"--"]==NO && nowLevel!=nil && [nowLevel isEqualToString:@"0.00"]==NO && [nowLevel isEqualToString:@"--"]==NO) {
        //只要这个存在的话，那当前水位就有了
        isNow = YES;
        //29日14时:
        self.nowWaterDateLabel.text = [NSString stringWithFormat:@"%@:",nowKey];
        //33.94
        self.nowWaterLabel.text = [NSString stringWithFormat:@"%@米",nowLevel];
    }
    if (beyondLeve !=nil && [beyondLeve isEqualToString:@"0.00"]==NO && [beyondLeve isEqualToString:@"--"]==NO) {
        //只要这个存在的话，那汛限水位也有了
        isXX = YES;
        self.beyondTitleLabel.text = @"超汛限:";
        //-0.11
        self.beyondLabel.text = [NSString stringWithFormat:@"%@米",beyondLeve];
        if ([beyondLeve floatValue] > 0) {
            //超的话就不要加号了
            self.beyondLabel.text = [NSString stringWithFormat:@"%@米",beyondLeve];
            beyondIcon.hidden = NO;
        } else {
            //在这里如果不超的话就是不显示
            isXX = NO;
        }
    }
    //当汛限水位和当前水位都有的时候不需要处理，仅处理异常情况
    if(isNow == YES && isXX == NO) {
        //需要向下移动
        self.nowWaterDateLabel.frame = CGRectMake(174-36, 11, 86, 21);
        self.nowWaterLabel.frame = CGRectMake(260-37, 11, 53, 21);
        //隐藏
        self.beyondTitleLabel.hidden = YES;
        self.beyondLabel.hidden = YES;
    }
    if (isNow == NO && isXX == NO){
        //居中显示
        self.titleLabel.frame = CGRectMake(19, 11, 252, 21);
        self.titleLabel.textAlignment = UITextAlignmentCenter;
    }
}

-(void)initSegment{	
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    [list2 removeAllObjects];
	[tabBar removeAllSegments];
    
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
	[config release];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"ProjectTableName" Parameter:myEnnmcd];
	//parse XML
	WorkTableNameXMLParser *paser=[[WorkTableNameXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
	[pool release];
}

-(void)addSegment:(NSArray *)ti{
    if ([ti count] == 4) {
        NSMutableString *t1=[NSMutableString stringWithString:[ti objectAtIndex:0]];
        NSMutableString *t2=[NSMutableString stringWithString:[ti objectAtIndex:1]];
        NSMutableString *t3=[NSMutableString stringWithString:[ti objectAtIndex:2]];
        NSMutableString *t4=[NSMutableString stringWithString:[ti objectAtIndex:3]];
        
        [t1 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
        [t1 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t1 length])];
        [t2 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
        [t2 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t2 length])];
        [t3 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t3 length])];
        [t3 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t3 length])];
        [t4 replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [t4 length])];
        [t4 replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [t4 length])];
        
        [list2 addObject:[NSArray arrayWithObjects:t1,t2,t3,t4,nil]];
        
        [tabBar insertSegmentWithTitle:t1 atIndex:[list2 count]-1 animated:NO];
        
        if(tabBar.numberOfSegments>[list2 count])
            [tabBar removeSegmentAtIndex:tabBar.numberOfSegments-1 animated:NO];
         
    }
}

-(NSString *)isNeedYellowWarning:(NSArray *)array withIndex:(NSInteger)row;
{
    BOOL isNeedWarn = NO;
    if ([array count] <=0) {
        //当是0的时候直接返回
        return @"0";
    }
    NSString *name = [array objectAtIndex:0];
    //如果是水库而且超警，才需要进入
    if ([gclx isEqualToString:@"水库"]==YES && [info.isOver isEqualToString:@"1"]) {
        if (row == 0) {
            //最新水位
            NSString *nameSub = [name substringToIndex:4];
            if ([nameSub isEqualToString:@"最新水位"] == YES) {
                isNeedWarn = YES;
            }
        } else if (row == 1) {
            //汛限水位
            NSString *nameSub = [name substringToIndex:4];
            if ([nameSub isEqualToString:@"汛限水位"] == YES) {
                isNeedWarn = YES;
            }
        } else if (row == 2) {
            //超汛限水位
            NSString *nameSub = [name substringToIndex:5];
            if ([nameSub isEqualToString:@"超汛限水位"] == YES) {
                isNeedWarn = YES;
            }
        }
    }
    
    if (isNeedWarn) {
        return @"1";
    } else {
        return @"0";
    }
}

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{
    NSArray *li=[list objectAtIndex:indexPath.row];
    NSString *_key = [li objectAtIndex:0];
    NSString *_value = [li objectAtIndex:1];
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    //计算时间frame大小，并将label的frame变成实际大小
    CGSize size = CGSizeMake(151+23, 480);
    CGSize sizeRight = CGSizeMake(151-23-44, 480);
    CGSize labelSize = [_key sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    CGSize owerLabelSize = [_value sizeWithFont:font constrainedToSize:sizeRight lineBreakMode:UILineBreakModeWordWrap];
    int finalHeight = 35;
    if (owerLabelSize.height < labelSize.height) {
        finalHeight = labelSize.height;
    } else {
        finalHeight = owerLabelSize.height;
    }
    
    //添加高度数组
    NSString *finalStr = [NSString stringWithFormat:@"%d",finalHeight + 16];
    [heightArray addObject:finalStr];
    return finalHeight + 16;
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//tableView.rowHeight=20;
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	WorkDetailCell *cell = (WorkDetailCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
        NSString *height = [heightArray objectAtIndex:indexPath.row];
		cell = [[[WorkDetailCell alloc] initWithHeight:height] autorelease];
	}
    
    NSArray *li=[list objectAtIndex:indexPath.row];
    cell.key = [li objectAtIndex:0];
    cell.value = [li objectAtIndex:1];
    [cell setValue];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
	if ([NSThread isMainThread]) {
        NSLog(@"Now I'm in MainThread!");
        [myEnnm release];
        [myEnnmcd release];
        [myEngr release];
        [info release];
        [list release];
        [list2 release];
        [heightArray release];
        [gclx release];
        [nowKey release];
        [nowLevel release];
        [warningLevel release];
        [beyondLeve release];
        [titleName release];
        
        [myTable release];
        myTable = nil;
        [tabBar release];
        tabBar = nil;
        [myWeb release];
        myWeb = nil;
        [titleLabel release];
        titleLabel = nil;
        [nowWaterLabel release];
        nowWaterDateLabel = nil;
        [nowWaterDateLabel release];
        nowWaterDateLabel = nil;
        [beyondTitleLabel release];
        beyondTitleLabel = nil;
        [beyondLabel release];
        beyondLabel = nil;
        [beyondIcon release];
        beyondIcon = nil;
        [backBtn release];
        backBtn = nil;
        [super dealloc];
	} else {
        NSLog(@"Now I'm in secondary thread!");
	}
}

@end
