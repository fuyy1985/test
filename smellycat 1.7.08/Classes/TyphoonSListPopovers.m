//
//  TyphoonSListPopovers.m
//  smellycat
//
//  Created by apple on 10-11-27.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "TyphoonSListPopovers.h"
#import "MyTableCell.h"
#import "typhoonXMLParser.h"
#import "WebServices.h"
#import "const.h"
#import "smellycatViewController.h"

static TyphoonSListPopovers *me=nil;
@implementation TyphoonSListPopovers
@synthesize hiscPath;
@synthesize dTfid;
@synthesize dTfName;
@synthesize myTable;
@synthesize wattingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithTfID:(NSString*)tfIDStr WIthTfName:(NSString *)tfNameStr{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.hiscPath =[[NSMutableArray alloc]init];
		[tfIDStr retain];
		[tfNameStr retain];
		self.dTfid = tfIDStr;
		self.dTfName = tfNameStr;
		me = self;
	}
	[self addWaitting];
	return self;
}

+(id)shareSTf{
	return me;
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


-(void)viewDidAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(266, 342);
	[self performSelector:@selector(dealWithData) withObject:nil afterDelay:0.01];
	[self performSelector:@selector(convertTyphoonArrayToDelegate) withObject:nil afterDelay:0.02];
}

-(void)getHistoryTyphoonPath:(TFPathInfo *)item{
	[self.hiscPath addObject:item];
}

-(void)dealWithData{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSString *baseURL = [NSString stringWithFormat:@"http://%@/%@/",ServerMain,MainServerURLPath];
	NSURL *countURL=[WebServices getRestUrl:baseURL Function:@"GetTfLSPath" Parameter:[NSDictionary dictionaryWithObjectsAndKeys:self.dTfid,@"tfid",nil]];
	
	//parse XML
	sHistoryTyphoonXMLParser *paser=[[sHistoryTyphoonXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];		
	[paser release];
	[pool release];
}

-(void)convertTyphoonArrayToDelegate{
	[myTable reloadData];

	smellycatViewController *myCon = [smellycatViewController sharedCat];
	NSString *myTfNm;
	if ([self.dTfName length]>0) {
		NSArray *temArr = [self.dTfName componentsSeparatedByString:@"·"];
		if ([temArr count]==2) {
			myTfNm = [temArr objectAtIndex:0];
		}else {
			return;
		}
	}
	if ([myTfNm length]==0) {
		myTfNm = [NSString stringWithString:@"未命名"];
	}
	objc_msgSend(myCon,@selector(receviceSearchTyphoonArrayAndDrawIt:WithName:WithID:),self.hiscPath,myTfNm,self.dTfid);
	[self removeWaitting];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
	[wattingView release];
	[dTfid release];[dTfid release];
	[dTfName release];[dTfName release];
	
	[hiscPath release];
	[super dealloc];
}


@end
