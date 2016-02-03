    //
//  TyphoonNewRealPopover.m
//  smellycat
//
//  Created by apple on 11-5-27.
//  Copyright 2011 zjdayu. All rights reserved.
//

#import "TyphoonNewRealPopover.h"
#import "typhoonXMLParser.h"

@implementation TyphoonNewRealPopover
@synthesize nmLable,subNMLable,myTable,myTableArr,mySeg,myToolbar,myIndex,infoArray,hisArray;


-(id)initwithTyphoonInfoArray:(NSMutableArray *)temInfoArray historyArray:(NSMutableArray *)temHisArray{
	if (temInfoArray!= self.infoArray) {
		[temInfoArray retain];
		self.infoArray = temInfoArray;
	}
	if (temHisArray!= self.hisArray) {
		[temHisArray retain];
		self.hisArray = temHisArray;
	}
	
	//Initial the UISegmentController 's selectedIndex as 0
	myIndex = 0;
	
	//Initial the NSMutableArray
	self.myTableArr = [NSArray array];
	
	return self;
}


- (void)loadView {
	self.view =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 266, 226)];
	self.view.backgroundColor = [UIColor clearColor];
	UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 266, 226)];
	whiteView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:whiteView];
	[whiteView release];
	
	//Title
	nmLable = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, 140, 30)];
	nmLable.backgroundColor = [UIColor clearColor];
	nmLable.textColor = [UIColor whiteColor];
	nmLable.textAlignment = UITextAlignmentCenter;
	nmLable.font = [UIFont boldSystemFontOfSize:16];
	nmLable.adjustsFontSizeToFitWidth = YES;
	nmLable.minimumFontSize = 13;
	nmLable.text = @"";
	[self.view addSubview:nmLable];
	
	//SubTitle
	subNMLable = [[UILabel alloc] initWithFrame:CGRectMake(207, 10, 56, 16)];
	subNMLable.backgroundColor =[UIColor clearColor];
	subNMLable.textColor = [UIColor yellowColor];
	subNMLable.textAlignment = UITextAlignmentCenter;
	subNMLable.font = [UIFont boldSystemFontOfSize:11];
	subNMLable.text = @"";
	[self.view addSubview:subNMLable];

	
	//subTitle 's background
	UILabel *bgLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 100, 30)];
	bgLable.backgroundColor = [UIColor grayColor];
	bgLable.textColor = [UIColor clearColor];
	[self.view addSubview:bgLable];
	[bgLable release];
	
	//Time
	UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(1, 30, 100, 30)];
	timeLable.backgroundColor = [UIColor grayColor];
	timeLable.textColor = [UIColor whiteColor];
	timeLable.textAlignment = UITextAlignmentCenter;
	timeLable.font  = [UIFont boldSystemFontOfSize:16];
	timeLable.text = @"时 间";
	[self.view addSubview:timeLable];
	[timeLable release];
	
	//Stress
	UILabel *stressLable = [[UILabel alloc] initWithFrame:CGRectMake(101, 30, 55, 30)];
	stressLable.backgroundColor = [UIColor grayColor];
	stressLable.textColor = [UIColor whiteColor];
	stressLable.textAlignment = UITextAlignmentCenter;
	stressLable.font  = [UIFont boldSystemFontOfSize:16];
	stressLable.text = @"气压";
	[self.view addSubview:stressLable];
	[stressLable release];
	
	//Strong
	UILabel *strongLable = [[UILabel alloc] initWithFrame:CGRectMake(156, 30, 55, 30)];
	strongLable.backgroundColor = [UIColor grayColor];
	strongLable.textColor = [UIColor whiteColor];
	strongLable.textAlignment = UITextAlignmentCenter;
	strongLable.font  = [UIFont boldSystemFontOfSize:16];
	strongLable.text = @"风力";
	[self.view addSubview:strongLable];
	[strongLable release];
	
	//Speed
	UILabel *speedLable = [[UILabel alloc] initWithFrame:CGRectMake(211, 30, 55, 30)];
	speedLable.backgroundColor = [UIColor grayColor];
	speedLable.textColor = [UIColor whiteColor];
	speedLable.textAlignment = UITextAlignmentCenter;
	speedLable.font  = [UIFont boldSystemFontOfSize:16];
	speedLable.text = @"移速";
	[self.view addSubview:speedLable];
	[speedLable release];
	
	
	//initial the seg array
	NSMutableArray *mySegArray = [NSMutableArray array];
	for (int i = 0; i<[self.infoArray count]; i++) {
		TFList *list = [self.infoArray objectAtIndex:i];
		NSString *tyNM = list.cNAME;
		if ([tyNM length]==0) {
			tyNM = @"未命名";
		}
		[mySegArray addObject:tyNM];
	}
	mySeg = [[UISegmentedControl alloc] initWithItems:mySegArray];
	mySeg.frame = CGRectMake(0, 196, 266, 31);
	if ([mySegArray count]>1) {
		mySeg.selectedSegmentIndex = 0;
	}else {
		mySeg.userInteractionEnabled = NO;
	}

	[mySeg addTarget:self action:@selector(changeTheSegOfTyphoon) forControlEvents:UIControlEventValueChanged];
	mySeg.segmentedControlStyle = UISegmentedControlStyleBar;
	[self.view addSubview:mySeg];
	
	//UITableView
	CGRect myTableFrame = CGRectMake(0, 60, 266, 136);
	if ([infoArray count]<2) {
		myTableFrame.size.height +=31;
	}
	self.myTable = [[UITableView alloc] initWithFrame:myTableFrame];
	self.myTable.delegate = self;
	self.myTable.dataSource = self;	
	[self.view addSubview:myTable];
	
	//init data
	[self changeTheSegOfTyphoon];
	
}


-(void)changeTheSegOfTyphoon{
	//the selectedIndex
	myIndex = mySeg.selectedSegmentIndex;
	if (myIndex<0) {
		myIndex = 0;
	}
	//Set Title
	TFList *myList = [self.infoArray objectAtIndex:myIndex];
	NSString *tyCNM = myList.cNAME;
	NSString *tyNM = myList.NAME;
	//judge the chinese name
	if ([tyCNM length]==0||[tyCNM isEqualToString:@"未命名"]==YES) {
		tyCNM = @"未命名";
	}
	//judge the english name
	if ([tyNM length]==0||[tyNM isEqualToString:@"NAMELESS"]==YES) {
		tyNM = @"NAMELESS";
	}
	
	self.nmLable.text = [NSString stringWithFormat:@"%@(%@)",tyCNM,tyNM];

	//Not a terrible bug as I think ,breath, It' OK here!!!
	if ([self.hisArray count]>0) {
		self.myTableArr = [self.hisArray objectAtIndex:myIndex];
	}
	
	//SetSubTitle
	if ([self.myTableArr count]>0) {
		TFPathInfo *myPathInfo = [self.myTableArr objectAtIndex:[self.myTableArr count]-1];
		NSString *tyType = myPathInfo.type;
	/*	
		if ([tyType isEqualToString:@"热带低气压"]) {
			subNMLable.textColor  = [UIColor colorWithRed:44.0/255 green:252.0/255 blue:50.0/255 alpha:1];
			tyType = @"热带低压";
		} else if ([tyType isEqualToString:@"热带风暴"]) {
			subNMLable.textColor  = [UIColor colorWithRed:52.0/255 green:11.0/255 blue:255.0/255 alpha:1];
		}  else if ([tyType isEqualToString:@"强热带风暴"]) {
			subNMLable.textColor  = [UIColor colorWithRed:253.0/255 green:250.0/255 blue:0.0/255 alpha:1];
		} else if ([tyType isEqualToString:@"台风"]) {
			subNMLable.textColor  = [UIColor colorWithRed:255.0/255 green:153.0/255 blue:0.0/255 alpha:1];
		} else if ([tyType isEqualToString:@"强台风"]) {
			subNMLable.textColor  = [UIColor colorWithRed:255.0/255 green:102.0/255 blue:255.0/255 alpha:1];
		} else if ([tyType isEqualToString:@"超强台风"]) {
			subNMLable.textColor  = [UIColor colorWithRed:248.0/255 green:48.0/255 blue:50.0/255 alpha:1];
		} else {
			subNMLable.textColor  = [UIColor greenColor];
			tyType = @"";
		}
     */
        //diliberately set out to write the typhoon type name as white color
        if ([tyType isEqualToString:@"热带低压"]) {
			subNMLable.textColor  = [UIColor whiteColor];
			tyType = @"热带低压";
		} else if ([tyType isEqualToString:@"热带风暴"]) {
			subNMLable.textColor  = [UIColor whiteColor];
		}  else if ([tyType isEqualToString:@"强热带风暴"]) {
			subNMLable.textColor  = [UIColor whiteColor];
		} else if ([tyType isEqualToString:@"台风"]) {
			subNMLable.textColor  = [UIColor whiteColor];
		} else if ([tyType isEqualToString:@"强台风"]) {
			subNMLable.textColor  = [UIColor whiteColor];
		} else if ([tyType isEqualToString:@"超强台风"]) {
			subNMLable.textColor  = [UIColor whiteColor];
		} else {
			subNMLable.textColor  = [UIColor whiteColor];
			tyType = @"";
		}

		
		subNMLable.text = tyType;
	}else {
		//if there is no historyPathInfo , set it empty!
		subNMLable.text = @"";
	}


				
	//Reload TableView
	[self.myTable reloadData];
}


#pragma mark UITableViewDelegate And UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.myTableArr count]==0?1:[self.myTableArr count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger trueRow;
	TFPathInfo *myPathInfo;
	if ([self.myTableArr count]>0) {
		trueRow = [self.myTableArr count] - indexPath.row-1;
		myPathInfo = [self.myTableArr objectAtIndex:trueRow];
	}else {
		myPathInfo = [[[TFPathInfo alloc] init] autorelease];
		myPathInfo.RQSJ2 = @"暂无路径信息";
		myPathInfo.QY = @"--";
		myPathInfo.FL = @"--";
		myPathInfo.movesd = @"--";
	}

	 
	 
	NSString *myIdentify = [NSString stringWithFormat:@"typhoonnew %d  %d",indexPath.row ,myIndex];
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:myIdentify];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:myIdentify];
		
		UILabel *lable1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 34)];
		lable1.textColor = [UIColor blueColor];
		lable1.textAlignment = UITextAlignmentLeft;
		lable1.font = [UIFont systemFontOfSize:14];
		lable1.text = myPathInfo.RQSJ2;
		[cell.contentView addSubview:lable1];
		[lable1 release];
		
		UILabel *lable2 =[[UILabel alloc] initWithFrame:CGRectMake(115, 0, 40, 34)];
		lable2.textAlignment = UITextAlignmentLeft;
		lable2.font = [UIFont systemFontOfSize:14];
		if ([myPathInfo.QY intValue]==0||[myPathInfo.QY isEqualToString:@""]==YES) {
			lable2.text = @"---";
		} else {
			lable2.text = myPathInfo.QY;
		}		
		[cell.contentView addSubview:lable2];
		[lable2 release];
		
		UILabel *lable3 =[[UILabel alloc] initWithFrame:CGRectMake(175, 0, 30, 34)];
		lable3.textAlignment = UITextAlignmentLeft;
		lable3.font = [UIFont systemFontOfSize:14];
		if ([myPathInfo.FL intValue]==0||[myPathInfo.FL isEqualToString:@""]==YES) {
			lable3.text = @"---";
		}else {
			lable3.text = myPathInfo.FL;
		}		
		[cell.contentView addSubview:lable3];
		[lable3 release];
		
		UILabel *lable4 =[[UILabel alloc] initWithFrame:CGRectMake(230, 0, 30, 34)];
		lable4.textAlignment = UITextAlignmentLeft;
		lable4.font = [UIFont systemFontOfSize:14];
		if ([myPathInfo.movesd intValue]==0||[myPathInfo.movesd isEqualToString:@""]==YES) {
			lable4.text = @"---";
		}else {
			lable4.text = myPathInfo.movesd;
		}		
		[cell.contentView addSubview:lable4];
		[lable4 release];
		
	}
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nmLable release];
	[myTable release];
	[myTableArr release];
	[mySeg release];
	[myToolbar release];
	[infoArray release];
	[hisArray release];
    [super dealloc];
}

@end
