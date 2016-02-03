/*

    File: SpeakHereViewController.m
Abstract: View controller for the SpeakHere application
 Version: 2.4

Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
Inc. ("Apple") in consideration of your agreement to the following
terms, and your use, installation, modification or redistribution of
this Apple software constitutes acceptance of these terms.  If you do
not agree with these terms, please do not use, install, modify or
redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and
subject to these terms, Apple grants you a personal, non-exclusive
license, under Apple's copyrights in this original Apple software (the
"Apple Software"), to use, reproduce, modify and redistribute the Apple
Software, with or without modifications, in source and/or binary forms;
provided that if you redistribute the Apple Software in its entirety and
without modifications, you must retain this notice and the following
text and disclaimers in all such redistributions of the Apple Software.
Neither the name, trademarks, service marks or logos of Apple Inc. may
be used to endorse or promote products derived from the Apple Software
without specific prior written permission from Apple.  Except as
expressly stated in this notice, no other rights or licenses, express or
implied, are granted by Apple herein, including but not limited to any
patent rights that may be infringed by your derivative works or by other
works in which the Apple Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Copyright (C) 2009 Apple Inc. All Rights Reserved.


*/

#import "SpeakSearchViewController.h"
#import "MyTableCell.h"
#import "FileManager.h"
#import "WebServices.h"
#import "Const.h"
#import "SearchXMLParser.h"
#import "typhoonXMLParser.h"
#import "Work3Controller.h"
#import "WorkXMLParser.h"
#import "WaterInfoController.h"
#import "WaterXMLParser.h"
#import "FlowLeftViewController.h"
#import "smellycatViewController.h"

#import "SectionControlInfo.h"
#import "SearchSectionInfo.h"
#import "SearchInfoModel.h"
#import "SearchSortCell.h"
#import "SSectionHeaderView.h"

#define DEFAULT_ROW_HEIGHT 35
#define HEADER_HEIGHT 27

static SpeakSearchViewController *me = nil;
@implementation SpeakSearchViewController
@synthesize myTable = _myTable;
@synthesize hisc = _hisc;
@synthesize hiscPath = _hiscPath;
@synthesize wattingView;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        self.hisc = [[NSMutableArray alloc] init];
        self.hiscPath = [[NSMutableArray alloc] init];
        self.waterHisc = [[NSMutableArray alloc] init];
        self.rainHisc = [[NSMutableArray alloc] init];
        self.typhoonHisc = [[NSMutableArray alloc] init];
        self.projectHisc = [[NSMutableArray alloc] init];
		isVirgin = YES;
        me = self;
        
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

+(id)sharedWork{
	return me;
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad.*/
- (void)viewDidLoad {
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
    //这里清除，相当于初次加载
    isVirgin = YES;
	[self.hisc removeAllObjects];
	[_myTable reloadData];
	_texto.text = [NSString stringWithFormat:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [_myTable release];
    [_hisc release];
    [_hiscPath release];
    [wattingView release];
    [_waterHisc release];
    [_rainHisc release];
    [_typhoonHisc release];
    [_projectHisc release];
    [super dealloc];
}

-(void)convertSTextToView:(NSString *)str;
{
    _texto.text = str;
    //获取成功后，开始获取数据
    [self addWaitting];
    [self performSelector:@selector(dealWithData:) withObject:str afterDelay:0.00001];

}

-(void)addData:(SearchInfoModel *)info{
    if ([info.srSort isEqualToString:@"水情"]) {
        [_waterHisc addObject:info];
    } else if ([info.srSort isEqualToString:@"雨情"]) {
        [_rainHisc addObject:info];
    } else if ([info.srSort isEqualToString:@"台风"]) {
        [_typhoonHisc addObject:info];
    } else if ([info.srSort isEqualToString:@"工情"]) {
        [_projectHisc addObject:info];
    }
	//[myTable reloadData];
}

-(void)showKeyBoard;
{
    [_texto becomeFirstResponder];
}

-(void)hideKeyBoard;
{
    [_texto resignFirstResponder];
}

-(void)dealWithData:(NSString*)txt{
	[_hisc removeAllObjects];
	[_waterHisc removeAllObjects];
    [_rainHisc removeAllObjects];
    [_typhoonHisc removeAllObjects];
    [_projectHisc removeAllObjects];
    
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
	
    //处理得到的数据
    if ([_waterHisc count] > 0) {
        SectionControlInfo *sectionControl = [[SectionControlInfo alloc] init];
        SearchSectionInfo *sectionObject = [[SearchSectionInfo alloc] init];
        sectionObject.sectionname = [NSString stringWithFormat:@"水情(%d个)",[_waterHisc count]];
        sectionObject.searchInfos = _waterHisc;
        sectionControl.sectioninfo = sectionObject;
        [sectionObject release];
        sectionControl.open = false;
        NSNumber *defaultRowHeight = [NSNumber numberWithInteger:78];
        NSInteger countOfQuotations = [_waterHisc count];
        for (NSInteger i = 0; i < countOfQuotations; i++) {
            [sectionControl insertObject:defaultRowHeight inRowHeightsAtIndex:i];
        }
        [_hisc addObject:sectionControl];
        [sectionControl release];
    }
    if ([_rainHisc count] > 0) {
        SectionControlInfo *sectionControl = [[SectionControlInfo alloc] init];
        SearchSectionInfo *sectionObject = [[SearchSectionInfo alloc] init];
        sectionObject.sectionname = [NSString stringWithFormat:@"雨情(%d个)",[_rainHisc count]];
        sectionObject.searchInfos = _rainHisc;
        sectionControl.sectioninfo = sectionObject;
        [sectionObject release];
        sectionControl.open = false;
        NSNumber *defaultRowHeight = [NSNumber numberWithInteger:78];
        NSInteger countOfQuotations = [_rainHisc count];
        for (NSInteger i = 0; i < countOfQuotations; i++) {
            [sectionControl insertObject:defaultRowHeight inRowHeightsAtIndex:i];
        }
        [_hisc addObject:sectionControl];
        [sectionControl release];
    }
    if ([_typhoonHisc count] > 0) {
        SectionControlInfo *sectionControl = [[SectionControlInfo alloc] init];
        SearchSectionInfo *sectionObject = [[SearchSectionInfo alloc] init];
        sectionObject.sectionname = [NSString stringWithFormat:@"台风(%d个)",[_typhoonHisc count]];
        sectionObject.searchInfos = _typhoonHisc;
        sectionControl.sectioninfo = sectionObject;
        [sectionObject release];
        sectionControl.open = false;
        NSNumber *defaultRowHeight = [NSNumber numberWithInteger:78];
        NSInteger countOfQuotations = [_typhoonHisc count];
        for (NSInteger i = 0; i < countOfQuotations; i++) {
            [sectionControl insertObject:defaultRowHeight inRowHeightsAtIndex:i];
        }
        [_hisc addObject:sectionControl];
        [sectionControl release];
    }
    if ([_projectHisc count] > 0) {
        SectionControlInfo *sectionControl = [[SectionControlInfo alloc] init];
        SearchSectionInfo *sectionObject = [[SearchSectionInfo alloc] init];
        sectionObject.sectionname = [NSString stringWithFormat:@"工情(%d个)",[_projectHisc count]];
        sectionObject.searchInfos = _projectHisc;
        sectionControl.sectioninfo = sectionObject;
        [sectionObject release];
        sectionControl.open = false;
        NSNumber *defaultRowHeight = [NSNumber numberWithInteger:78];
        NSInteger countOfQuotations = [_projectHisc count];
        for (NSInteger i = 0; i < countOfQuotations; i++) {
            [sectionControl insertObject:defaultRowHeight inRowHeightsAtIndex:i];
        }
        [_hisc addObject:sectionControl];
        [sectionControl release];
    }
    //确认哪个要展开
    int total = [_hisc count];
    if(total > 0) {
        SectionControlInfo *sectionControl = [_hisc objectAtIndex:(total - 1)];
        sectionControl.open = YES;
        [_hisc replaceObjectAtIndex:(total - 1) withObject:sectionControl];
    }
    
	[pool release];
	[_myTable reloadData];
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
	[_hiscPath addObject:item];
}


#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[_texto resignFirstResponder];
    [self addWaitting];
    //获取数据
    [self performSelector:@selector(dealWithData:) withObject:_texto.text afterDelay:0.00001];
	return YES;
}

#pragma mark UITableView delegates and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if ([_hisc count] == 0) {
        if (isVirgin) {
            isVirgin = NO;
            return 0;
        } else {
            return 1;
        }
    } else {
        return [_hisc count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if ([_hisc count] == 0) {
        return 0;
    } else {
        return HEADER_HEIGHT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_ROW_HEIGHT; //returns floating point which will be used for a cell row height at specified row index
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_hisc count] == 0) {
        if (isVirgin) {
            isVirgin = NO;
            return 0;
        } else {
            return 1;
        }
    } else {
        SectionControlInfo *sectionControl = [_hisc objectAtIndex:section];
        NSInteger numStoriesInSection = [[sectionControl.sectioninfo searchInfos] count];
        return sectionControl.open ? numStoriesInSection : 0;
        return [_hisc count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_hisc count] == 0 && isVirgin==NO) {
        static NSString *NQuoteCellIdentifier = @"NSearchCellIdentifier";
        SearchSortCell *cell = (SearchSortCell*)[tableView dequeueReusableCellWithIdentifier:NQuoteCellIdentifier];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchSortCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        cell.name.text = @"抱歉，没有找到相关的信息。";
        return cell;
    } else {
        static NSString *QuoteCellIdentifier = @"SearchCellIdentifier";
        SearchSortCell *cell = (SearchSortCell*)[tableView dequeueReusableCellWithIdentifier:QuoteCellIdentifier];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchSortCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        SectionControlInfo *sectionObject = (SectionControlInfo *)[_hisc objectAtIndex:indexPath.section];
        cell.sectioninfo = [sectionObject.sectioninfo.searchInfos objectAtIndex:indexPath.row];
        [cell setValue];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[_texto resignFirstResponder];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	// Create a view controller with the title as its navigation title and push it.
    NSUInteger row = indexPath.row;
	BOOL ISTYPHOON = NO;
    if (row != NSNotFound) {
        SectionControlInfo *sectionControlInfo =[_hisc objectAtIndex:indexPath.section];
        SearchInfoModel *info = [sectionControlInfo.sectioninfo.searchInfos objectAtIndex:indexPath.row];		if([info.srSort compare:@"雨情"] == NSOrderedSame){
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
            NSArray *myTemArray = [info.srName componentsSeparatedByString:@"·"];
            NSString *waterT = nil;
            if ([myTemArray count] == 4 ) {
                waterT = [myTemArray objectAtIndex:1];
            } else {
                waterT = @"另外";
            }
            
			if (info.srStandLng!=nil&info.srStandLat!=nil&info.srSateLng!=nil&info.srSateLat!=nil) {
				NSString *temStr = [NSString stringWithFormat:@"搜水情"];
				NSArray *temArr = [NSArray arrayWithObjects:info.srStandLng,info.srStandLat,info.srSateLng,info.srSateLat,info.srDescription,info.srEnnmcd,waterT,nil];
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


-(void)forWatting:(SearchReaultInfo *)myInfo{
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
	objc_msgSend(myCon,@selector(receviceSearchTyphoonArrayAndDrawIt:WithName:WithID:),_hiscPath,myTfNm,myInfo.srEnnmcd);
	[self removeWaitting];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
    if ([_hisc count] == 0) {
        return UITableViewCellAccessoryNone;
    } else {
        return UITableViewCellAccessoryDisclosureIndicator;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    /*
     Create the section header views lazily.
     */
    if (tableView == _myTable && [_hisc count] >0) {
        SectionControlInfo *sectionControl = [_hisc objectAtIndex:section];
        if (!sectionControl.headerView) {
            BOOL s = NO;
            if ((section+1) == [_hisc count]&&[_hisc count] > 0) {
                s = YES;
            }
            NSString *playName = sectionControl.sectioninfo.sectionname;
            CGRect f = CGRectMake(0.0, 0.0, _myTable.bounds.size.width, HEADER_HEIGHT) ;
            sectionControl.headerView = [[[SSectionHeaderView alloc] initWithFrame:f title:playName section:section delegate:self withSigleSignal:s] autorelease];
        }
        return sectionControl.headerView;
    } else {
        return nil;
    }
}

#pragma mark Section header delegate
-(void)sectionHeaderView:(SSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	SectionControlInfo *sectionControl = [_hisc objectAtIndex:sectionOpened];
	sectionControl.open = YES;
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [sectionControl.sectioninfo.searchInfos count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    insertAnimation = UITableViewRowAnimationTop;
    // Apply the updates.
    [_myTable beginUpdates];
    [_myTable insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [_myTable endUpdates];
    [indexPathsToInsert release];
}


-(void)sectionHeaderView:(SSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionControlInfo *sectionControl = [_hisc objectAtIndex:sectionClosed];
    sectionControl.open = NO;
    NSInteger countOfRowsToDelete = [_myTable numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [_myTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
        [indexPathsToDelete release];
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

@end
