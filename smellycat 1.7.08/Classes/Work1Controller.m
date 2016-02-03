//
//  Work1Controller.m
//  navag
//
//  Created by Heiby He on 09-3-24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Work1Controller.h"
#import "Work2Controller.h"
#import "SearchController.h"
#import "MyTableCell.h"
#import "FileManager.h"
#import "WorkXMLParser.h"
#import "WebServices.h"
#import "SearchController.h"
#import "LocationController.h"
#import "const.h"
#import "smellycatViewController.h"
#import "WorkStaticCell.h"

static Work1Controller *me=nil;
@implementation Work1Controller

@synthesize hisc,Count,selRowIndex,gcgm,gclx,sgclx,myActivity;
@synthesize newCountArray = _newCountArray;
@synthesize totalLabel = _totalLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		UIBarButtonItem *left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
		self.navigationItem.backBarButtonItem = left;
		[left release];
		
		UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
		[myButton setBackgroundImage:[UIImage imageNamed:@"close_normal.png"] forState:UIControlStateNormal];
		[myButton setBackgroundImage:nil forState:UIControlStateSelected];
		[myButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
		UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:myButton];
		self.navigationItem.rightBarButtonItem = right;
		[right release];
		[myButton release];
		
		self.hisc =[NSMutableArray array];
		self.Count=[NSMutableArray array];
		self.gcgm=[NSMutableArray array];
        
        _newCountArray = [[NSMutableArray alloc] init];
		
		self.navigationItem.title = @"正在获取数据...请稍候";
		
		me=self;
	}
	return self;
}
+(id)sharedWork1{
	return me;
}

-(void)dismissPopover{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissProject];
}

- (void)viewWillAppear:(BOOL)animated{	
	self.contentSizeForViewInPopover = CGSizeMake(320-35, 294-44);
    if (_totalLabel!=nil&&_totalLabel.superview == nil) {
        [self.navigationController.view addSubview:_totalLabel];
    }
}

-(void)viewDidLoad{
	[self.myActivity startAnimating];
	[NSThread detachNewThreadSelector:@selector(getCount) toTarget:self withObject:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (_totalLabel!=nil&&_totalLabel.superview != nil) {
        [_totalLabel removeFromSuperview];
    }
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
	self.gclx=[NSString stringWithString:@"水库"];
	self.sgclx=[NSString stringWithString:@"水库"];
	type=1;
}
- (void)initSluice{
	self.gclx=[NSString stringWithString:@"水闸"];
	self.sgclx=[NSString stringWithString:@"水闸"];
	type=2;
}
- (void)initRiver{
	self.gclx=[NSString stringWithString:@"河流"];
	self.sgclx=[NSString stringWithString:@"河流"];
	type=3;
}
- (void)initDike{
	self.gclx=[NSString stringWithString:@"堤防（段）"];
	self.sgclx=[NSString stringWithString:@"堤防"];
	type=4;
}
-(void)initFormation{
	self.gclx=[NSString stringWithString:@"海堤（塘）"];
	self.sgclx=[NSString stringWithString:@"海堤"];
	type=5;	
}
-(void)initPowerStation{
	self.gclx=[NSString stringWithString:@"水电站"];
	self.sgclx=[NSString stringWithString:@"水电站"];
	type=6;
}
-(void)initIrrigation{
	self.gclx=[NSString stringWithString:@"灌区"];
	self.sgclx=[NSString stringWithString:@"灌区"];
	type=7;	
}
-(void)initReclamation{
	self.gclx=[NSString stringWithString:@"围垦"];
	self.sgclx=[NSString stringWithString:@"围垦"];
	type=8;	
}
-(void)initRankIrrigation{
	self.gclx=[NSString stringWithString:@"泵站"];
	self.sgclx=[NSString stringWithString:@"泵站"];
	type=9;	
}
-(void)initWeiyuan{
	self.gclx=[NSString stringWithString:@"圩垸"];
	self.sgclx=[NSString stringWithString:@"圩垸"];
	type=10;	
}
-(void)initController{
	self.gclx=[NSString stringWithString:@"控制站"];
	self.sgclx=[NSString stringWithString:@"控制站"];
	type=11;	
}
-(void)initFlood{
	self.gclx=[NSString stringWithString:@"蓄滞（行）洪区"];
	self.sgclx=[NSString stringWithString:@"蓄滞洪区"];
	type=12;	
}

-(void)addCount:(NSArray *)c{
	if([c count]<3)return;
	NSString *grnm1=[c objectAtIndex:0];
	NSString *en_gr1=[c objectAtIndex:1];
	NSString *count1=[c objectAtIndex:2];
	NSMutableString *grnm=[NSMutableString stringWithString:grnm1];
	NSMutableString *en_gr=[NSMutableString stringWithString:en_gr1];
	NSMutableString *count=[NSMutableString stringWithString:count1];
	[grnm replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [grnm length])];
	[grnm replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [grnm length])];
	[en_gr replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [en_gr length])];
	[en_gr replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [en_gr length])];
	[count replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, [count length])];
	[count replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [count length])];
	
	[hisc addObject:grnm];
	[Count addObject:count];
	[gcgm addObject:en_gr];
	[myTable reloadData];
}

-(void)addNewCount:(WorkInfo *)info
{
    [_newCountArray addObject:info];
}

-(void)getCount{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [_newCountArray removeAllObjects];
	[Count removeAllObjects];
	[hisc removeAllObjects];
	[gcgm removeAllObjects];
	[myTable reloadData];
	
	FileManager *config=[[FileManager alloc] init];
    NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWork"]];
    //NSString *baseURL = @"http://42.120.40.150/gq/DataService.asmx/";
    
	NSArray *locationArray=[config getLocation];
	[config release];
	/*
	 dscd:地区编码,如‘台州市 331000；
	 projectTypeName:工程类型名称,如：水库、水电站、河流、水闸、控制站等
     */
	NSString *convertV = [NSString stringWithFormat:@"%@|%@",[locationArray objectAtIndex:0],gclx];
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"ProjectStat" Parameter:convertV];
	//parse XML
	WorkCountXMLParser *paser=[[WorkCountXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
    
    [myTable reloadData];
    
    //create label
    if (_totalLabel == nil) {
        CGRect nameFrame = CGRectMake(35, 0, 226, 30);
        _totalLabel = [[UILabel alloc] initWithFrame:nameFrame];
        _totalLabel.font = [UIFont systemFontOfSize:16.0];
        _totalLabel.minimumFontSize = 6.0;
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.textAlignment = UITextAlignmentCenter;
        [self.navigationController.view addSubview:_totalLabel];
    }
    
    NSInteger totalValue = 0;
    NSInteger totalCount = 0;
    NSString *para0  = nil;
    NSString *unit = nil;
    for (int i = 0; i <[_newCountArray count]; i++) {
        WorkInfo *info = [_newCountArray objectAtIndex:i];
        if (i == 0) {
            para0 = [NSString stringWithFormat:@"%@",info.para0];
            unit = [NSString stringWithFormat:@"%@",info.unit0];
            
        }
        totalValue += [info.value0 integerValue];
        totalCount += [info.count integerValue];
    }
        
    if ([sgclx isEqualToString:@"水库"]&&totalValue>10000) {
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2f亿m³",[locationArray objectAtIndex:1],para0,totalValue/10000.0];
    } else if([sgclx isEqualToString:@"堤防"]&&totalValue>1000) {
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2fkm",[locationArray objectAtIndex:1],para0,totalValue/1000.0];
    } else if(totalValue>1000&&([sgclx isEqualToString:@"海塘"]||[sgclx isEqualToString:@"海堤"])){
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2fkm",[locationArray objectAtIndex:1],para0,totalValue/1000.0];
    } else if([sgclx isEqualToString:@"水闸"]&&totalValue>10000){
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2f万m³/s",[locationArray objectAtIndex:1],para0,totalValue/10000.0];
    } else if(totalValue>10000&&([sgclx isEqualToString:@"电站"]||[sgclx isEqualToString:@"水电站"])){
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2f万KW",[locationArray objectAtIndex:1],para0,totalValue/10000.0];
    } else if([sgclx isEqualToString:@"泵站"]&&totalValue>10000){
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%.2f万KW",[locationArray objectAtIndex:1],para0,totalValue/10000.0];
    } else if(totalCount > 0) {
        _totalLabel.text = [NSString stringWithFormat:@"%@%@%d%@",[locationArray objectAtIndex:1],para0,totalValue,unit];
    } else {
        _totalLabel.text = [NSString stringWithFormat:@"当前区域无%@",sgclx];
    }
    
    [self performSelectorOnMainThread:@selector(removeActivityAndSetTitle) withObject:nil waitUntilDone:YES];
	[pool release];

}

-(NSString *)convertUnitByProjectNm:(NSString *)projectNm;
{
    if ([projectNm isEqualToString:@"水库"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"水闸"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"水电站"]||[projectNm isEqualToString:@"电站"]) {
        return @"座";
    } else if ([projectNm isEqualToString:@"海塘"]||[projectNm isEqualToString:@"海堤"]||[projectNm isEqualToString:@"海堤（塘）"]) {
        return @"段";
    } else if ([projectNm isEqualToString:@"堤防"]||[projectNm isEqualToString:@"堤防（段）"]) {
        return @"条";
    } else if([projectNm isEqualToString:@"泵站"]) {
        return @"座";
    } else {
        return @"个";
    }
}

-(NSString *)convertTypeByOldType:(NSString *)oldType;
{
    if ([oldType isEqualToString:@"大（1）型"]) {
        return @"大(1)型";
    } else if ([oldType isEqualToString:@"大（2）型"]) {
        return @"大(2)型";
    } else if ([oldType isEqualToString:@"中型"]) {
        return @" 中  型";
    } else if ([oldType isEqualToString:@"小（1）型"]) {
        return @"小(1)型";
    } else if ([oldType isEqualToString:@"小（2）型"]) {
        return @"小(2)型";
    } else if([oldType isEqualToString:@"大（一）型"]) {
        return @"大(一)型";
    } else if([oldType isEqualToString:@"大（二）型"]) {
        return @"大(二)型";
    } else if([oldType isEqualToString:@"小（一）型"]) {
        return @"小(一)型";
    } else if([oldType isEqualToString:@"小（二）型"]) {
        return @"小(二)型";
    } else {
        return oldType;
    }
}

-(void)removeActivityAndSetTitle{
	self.navigationItem.title = @"";
	//remove activityview
	[self.myActivity stopAnimating];
	[self.myActivity removeFromSuperview];
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
	NSInteger i=[_newCountArray count];
	return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//tableView.rowHeight=20;
	NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier %i", indexPath.row];
	WorkStaticCell *cell = (WorkStaticCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[WorkStaticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}else{
		NSArray *subviews=[[NSArray alloc] initWithArray:cell.contentView.subviews];
		for(UIView *subview in subviews){
			[subview removeFromSuperview];
		}
		[subviews release];
	}
    WorkInfo *info = [_newCountArray objectAtIndex:indexPath.row];
    NSString *gcnm = info.grnm;
    info.grnm = [self convertTypeByOldType:gcnm];
    cell.unitStr = [self convertUnitByProjectNm:sgclx];
    cell.object = info;
    [cell setValue];
	return cell;	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //清出
    if (_totalLabel!=nil&&_totalLabel.superview != nil) {
        [_totalLabel removeFromSuperview];
    }
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	// Create a view controller with the title as its navigation title and push it.
    NSUInteger row = indexPath.row;
    if (row != NSNotFound) {
		selRowIndex=row;
		Work2Controller *targetViewController;
		targetViewController=[[Work2Controller alloc] initWithNibName:@"Work2" bundle:nil];
		if(targetViewController!=nil){
            WorkInfo *info = [_newCountArray objectAtIndex:indexPath.row];
            targetViewController.gcgm = info.en_gr;
            NSString *replaceWhitePlace = [[self convertTypeByOldType:info.grnm] stringByReplacingOccurrencesOfString:@" " withString:@""];
            targetViewController.ntitle=[NSString stringWithFormat:@"%@",replaceWhitePlace];
            targetViewController.navigationItem.title=[NSString stringWithFormat:@"%@%@",replaceWhitePlace,sgclx];
			[targetViewController initWork:gclx];
			[[self navigationController] pushViewController:targetViewController animated:YES];
			[targetViewController release];
		}
	}
}

- (void)dealloc {
	[hisc release];
	[Count release];
	[gclx release];
	[gcgm release];
	[myActivity release];
    [_newCountArray release];
    [_totalLabel release];
	[super dealloc];
}


@end
