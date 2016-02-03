//
//  FlowLeftViewController.m
//  GovOfQGJ
//
//  Created by apple on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FlowLeftViewController.h"
#import "MyMFlowChart.h"
#import "MyMSFlowChart.h"
#import "WebServices.h"
#import "FileManager.h"
#import "WaterXMLParser.h"
#import "Work3Controller.h"
#import "WorkXMLParser.h"

static FlowLeftViewController *me=nil;
@implementation FlowLeftViewController

@synthesize flowdays,isOK,specialstring,myscrollview,chartView,chartView2,pointType;
@synthesize titleLabel,pointNM,myXMBtn,myGQBtn;

+(id)shareflowleft{
	return me;
}
- (void)addRainItem:(FlowInfo *)Items{
	[flowdays addObject:Items];
}

- (void)getSpecialData:(NSString *)str{
	[str retain];
	specialstring =str;
}

- (void)getWaterCrossProjectInfo:(WaterCrossProjectInfo *)info {
    [info retain];
    specialInfo = info;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withPointC:(NSString*)pointC {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Initialization code
		me=self;
		isOK = YES;
		pointCode = pointC;
		self.flowdays= [NSMutableArray array];
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        //初始化为NO
        isPMT = NO;
    }
	return self;
}


// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

	//定义一个滚动视图
	myscrollview.showsHorizontalScrollIndicator = NO;
	myscrollview.showsVerticalScrollIndicator = NO;
	myscrollview.multipleTouchEnabled=YES;
	myscrollview.scrollEnabled=YES;
	myscrollview.clipsToBounds=YES;
	myscrollview.delegate=self;
	//myscrollview.contentSize = CGSizeMake(1000, 1000);
	myscrollview.maximumZoomScale=3;
	myscrollview.minimumZoomScale=1;
    
    [NSThread detachNewThreadSelector:@selector(backgroundFetchData) toTarget:self withObject:nil];
}

-(void)backgroundFetchData
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	FileManager *config=[[FileManager alloc] init];
	NSString *baseURL=[NSString stringWithFormat:@"%@/", [config getIPbyModule:@"mWater"]];
	[config release];
	
	//第一次解析：默认参数为空时，取的是当天的值
	NSURL *countURL=[WebServices getNRestUrl:baseURL Function:@"Water_Line_72" Parameter:[NSString stringWithFormat:@"%@",pointCode]];
	//parse XML
	WaterStaticXMLParser *paser=[[WaterStaticXMLParser alloc] init];
	[paser parseXMLFileAtURL:countURL parseError:nil];
	[paser release];
    
	//约定这样的格式（某水位站点数值）
    //	NSString *str = [NSString stringWithString:@"汛限水位,119.71&06-15 18时,0|06-15 19时,0|06-15 20时,0|06-15 21时,-121.71|06-15 22时,0|06-15 23时,0|06-16 0时,0|06-16 1时,0|06-16 2时,0|06-16 3时,0|06-16 4时,0|06-16 5时,0|06-16 6时,0|06-16 7时,0|06-16 8时,0|06-16 9时,0|06-16 10时,0|06-16 11时,0|06-16 12时,0|06-16 13时,0|06-16 14时,0|06-16 15时,0|06-16 16时,0|06-16 17时,0|06-16 18时,0|06-16 19时,0|06-16 20时,0|06-16 21时,0|06-16 22时,0|06-16 23时,0|06-17 0时,0|06-17 1时,0|06-17 2时,0|06-17 3时,0|06-17 4时,0|06-17 5时,0|06-17 6时,0|06-17 7时,0|06-17 8时,0|06-17 9时,0|06-17 10时,0|06-17 11时,0|06-17 12时,90|06-17 13时,0|06-17 14时,115.83|06-17 15时,115.84|06-17 16时,115.85|06-17 17时,88|06-17 18时,88|06-14 19时,100|06-14 20时,30|06-14 21时,40|06-14 22时,50|06-14 23时,70|06-15 0时,110|06-15 1时,200|06-15 2时,300|06-15 3时,0|06-15 4时,40|06-15 5时,0|06-15 6时,0|06-15 7时,0|06-15 8时,0|06-15 9时,0|06-15 10时,0|06-15 11时,0|06-15 12时,0|06-15 13时,0|06-15 14时,0|06-15 15时,0|06-15 16时,0|06-15 17时,0"];
	
	//spilt the string
	NSRange r = [specialstring rangeOfString:@"&"];
	NSString *specialStr;
	NSString *valueStr;
	if (r.length == 1&&[specialstring length]>1) {
		// there is a '$'
		specialStr = r.location>0?[specialstring substringToIndex:r.location]:@"";
		valueStr = [specialstring length]>(r.location+1)?[specialstring substringFromIndex:r.location+1]:@"";
	} else {
		// there is no '$'
		specialStr = @"";
		valueStr = @"";
	}
	
	//dealWith the special value
	NSArray *specialArr;
	if ([specialStr length]>0) {
		specialArr = [specialStr componentsSeparatedByString:@"|"];
	} else {
		specialArr = nil;
	}
    
	//dealWith the value of water of 3days
	NSArray *valueArr;
	if ([valueStr length]>0) {
		valueArr = [valueStr componentsSeparatedByString:@"|"];
	} else {
		valueArr = nil;
	}
	
    CGRect f=CGRectMake(-6, -8, 486, 268);
    chartView = [[MyMFlowChart alloc] initWithFrame:f withValue:valueArr withSpecial:specialArr];
	chartView.delegate = self;
	chartView.frame = f;
	[self.myscrollview addSubview:chartView];
    
    //判断是否需要加入按钮
    if ([pointType isEqualToString:@"水库站"]) {
        //示意
        BOOL isSY = YES;
        BOOL isGQ = YES;
        //add chart
        //第二次解析：默认参数是EMMCD，水库才需要这次获取数据呢 按照警戒水位来弄
        NSURL *countURL2=[WebServices getNRestUrl:baseURL Function:@"ProjectFeatureWaterLevel" Parameter:[NSString stringWithFormat:@"%@",pointCode]];
        //parse XML
        WaterMStaticXMLParser *paser2=[[WaterMStaticXMLParser alloc] init];
        [paser2 parseXMLFileAtURL:countURL2 parseError:nil];
        [paser2 release];
        /*
         <ennmcd>B330226000295</ennmcd>
         <ennm>西溪水库</ennm>
         <设计洪水标准>100</设计洪水标准>
         <校核洪水标准>1000</校核洪水标准>
         <校核洪水位>152.45</校核洪水位>
         <设计洪水位>152.02</设计洪水位>
         <防洪高水位>151.82</防洪高水位>
         <正常蓄水位>147.00</正常蓄水位>
         <防洪限制水位>145.00</防洪限制水位>
         <死水位>100.00</死水位>
         <调洪库容>1895.60</调洪库容>
         <防洪库容>1710.00</防洪库容>
         <兴利库容>6800.00</兴利库容>
         <死库容>300.00</死库容>
         <坝址多年平均径流>10900.00</坝址多年平均径流>
         <实时水位>147.16</实时水位>
         <警戒水位>145.00</警戒水位>
         <采集时间>2013-08-29 08</采集时间>
         <坝顶高程_x0028_m_x0029_>153.00</坝顶高程_x0028_m_x0029_>
         <主坝类型_x0028_材料分_x0029_>碾压混凝土坝</主坝类型_x0028_材料分_x0029_>
         <主坝类型_x0028_结构分_x0029_>重力坝</主坝类型_x0028_结构分_x0029_>
         */
        //（坝顶高程、校核洪水位、警戒水位、实时水位）
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"--",@"--",@"--",@"--", nil];
        if (specialInfo.bdgc !=nil) { //必须有
            [array replaceObjectAtIndex:0 withObject:specialInfo.bdgc];
        } else {
            isSY = NO;
        }
        if (specialInfo.xhhsw !=nil) {
            [array replaceObjectAtIndex:1 withObject:specialInfo.xhhsw];
        }
        if (specialInfo.jjsw !=nil) {
            [array replaceObjectAtIndex:2 withObject:specialInfo.jjsw];
        }
        if (specialInfo.dqsw !=nil) { //必须有
            [array replaceObjectAtIndex:3 withObject:specialInfo.dqsw];
        } else {
            isSY = NO;
        }
        if (specialInfo.ennmcd ==nil) {
            isGQ = NO;
        }
        //add chart2
        if (isSY == YES) {
            CGRect fS =CGRectMake(0, -8, 480, 268);
            chartView2 = [[MyMSFlowChart alloc] initWithFrame:fS withValue:array
                                                  withSpecial:specialInfo];
            [self.myscrollview insertSubview:chartView2 belowSubview:chartView];
        }
        if (isSY == YES && isGQ == YES) {
            myXMBtn.hidden = NO;
            myGQBtn.hidden = NO;
        } else if(isSY == NO && isGQ == YES) {
            myXMBtn.hidden = YES;
            myGQBtn.hidden = NO;
        } else if(isSY == YES && isGQ == NO) {
            myXMBtn.hidden = NO;
            myGQBtn.hidden = YES;
        }
    } else {
        myXMBtn.hidden = YES;
        myGQBtn.hidden = YES;
    }
    
    [pool release];
    
    [self performSelectorOnMainThread:@selector(showTheThingsOnView) withObject:nil waitUntilDone:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(480, 290);
}

-(void)showTheThingsOnView{
    
    //if(isError==NO)
        self.titleLabel.text = [NSString stringWithFormat:@"%@●72小时水位过程线",pointNM];
    //[self.view setNeedsDisplay];
    
    //[self.myActivity stopAnimating];
	//[self.myActivity removeFromSuperview];
}

-(IBAction)toggle:(id)sender
{
    if (isPMT== NO) {
        isPMT = YES;
        chartView.hidden = YES;
        chartView2.hidden = NO;
        NSArray *temArray = [titleLabel.text componentsSeparatedByString:@"●"];
        titleLabel.text = [NSString stringWithFormat:@"%@●示意图",[temArray objectAtIndex:0]];
        self.navigationItem.rightBarButtonItem.title = @"过程";
        [myXMBtn setImage:[UIImage imageNamed:@"water_gc"] forState:UIControlStateNormal];
        [myXMBtn setImage:[UIImage imageNamed:@"water_gc"] forState:UIControlStateDisabled];
        [myXMBtn setImage:[UIImage imageNamed:@"water_gc"] forState:UIControlStateSelected];
        [myXMBtn setImage:[UIImage imageNamed:@"water_gc"] forState:UIControlStateHighlighted];
    } else {
        isPMT = NO;
        chartView2.hidden = YES;
        chartView.hidden = NO;
        NSArray *temArray = [titleLabel.text componentsSeparatedByString:@"●"];
        titleLabel.text= [NSString stringWithFormat:@"%@●72小时水位过程线",[temArray objectAtIndex:0]];
        [myXMBtn setImage:[UIImage imageNamed:@"water_sy"] forState:UIControlStateNormal];
        [myXMBtn setImage:[UIImage imageNamed:@"water_sy"] forState:UIControlStateDisabled];
        [myXMBtn setImage:[UIImage imageNamed:@"water_sy"] forState:UIControlStateSelected];
        [myXMBtn setImage:[UIImage imageNamed:@"water_sy"] forState:UIControlStateHighlighted];
    }
}

-(IBAction)pushToProject:(id)sender
{
    //仅支持水库
    WorkInfo *workInfo = [[WorkInfo alloc] init];
    workInfo.ennmcd = specialInfo.ennmcd;
    workInfo.isOver = @"1";
    Work3Controller *targetViewController;
    targetViewController=[[Work3Controller alloc] initWithNibName:@"Work3" bundle:nil];
    if(targetViewController!=nil){
        targetViewController.info= workInfo;
        targetViewController.myEnnmcd = workInfo.ennmcd;
        NSArray *temArray = [titleLabel.text componentsSeparatedByString:@"●"];
		targetViewController.myEnnm = [temArray objectAtIndex:0];
        targetViewController.gclx = @"水库";
        targetViewController.backShow = YES;
        targetViewController.titleName = [NSString stringWithFormat:@"%@",specialInfo.ennm];
        [self.navigationController pushViewController:targetViewController animated:YES];
        [targetViewController release];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft?YES:NO);
}


#pragma mark UIScrollViewDelegate Method
- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView{
	return chartView;
}
- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (float) scale{
	CGAffineTransform transform = CGAffineTransformIdentity;
	transform = CGAffineTransformScale(transform, scale, scale);
	view.transform = transform;
}

#pragma mark -
#pragma mark CHARTVIEWDELEGAT
-(void)changeTheTitleStatus:(MyMFlowChart *)myPunkChartView withSignal:(NSInteger)punkSignal{
	NSArray *myArray;
	switch (punkSignal) {
		case 0:
			titleLabel.text = @"未能获取数据，请稍候重试";
			break;
		case 1:
			myArray = [titleLabel.text componentsSeparatedByString:@"●"];
			if([myArray count]==2)
			{
				titleLabel.text =[NSString stringWithFormat:@"%@●72小时无水位数据",[myArray objectAtIndex:0]];
			 }else{
				 titleLabel.text = @"72小时内无水位数据";
			 }
			break;
	}
}


- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// For the readonly properties, they must be released and set to nil directly.
	// e.g. self.myOutlet = nil;
	[super viewDidUnload];

	self.chartView=nil;
    self.chartView2=nil;
	self.myscrollview=nil;
	self.flowdays=nil;
	self.specialstring=nil;
}

- (void)dealloc {
	[chartView release];
    [chartView2 release];
	[myscrollview release];
	[flowdays release];
//	[specialstring release];
    [pointNM release];
    [titleLabel release];
    [myXMBtn release];
    [myGQBtn release];
    [pointType release];
	[super dealloc];
}
@end