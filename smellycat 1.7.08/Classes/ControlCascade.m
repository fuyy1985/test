//
//  ControlCascade.m
//  smellycat
//
//  Created by apple on 10-11-19.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "ControlCascade.h"
#import "const.h"
@implementation ControlCascade
@synthesize delegate;
@synthesize dataSource,multiLayerEnable,typhoonLayer,rainLayer,waterLayer,projectLayer,satelliteLayer,totalLayer,searchMemLayer,mapType,aroundLayer;
@synthesize multiSw,removeAll,removeTyphoon,removeRain,removeWater,removeProject,removeSatellite,removeAround,removeSearchMem,mapSeg,tableView;


- (void)dealloc {
	[typhoonLayer release];
	[rainLayer release];
	[waterLayer release];
	[projectLayer release];
	[satelliteLayer release];
	[totalLayer release];
	[searchMemLayer release];
	[mapType release];
	[dataSource release];
    [aroundLayer release];
	
	[tableView release];
	[multiSw release];
	[removeAll release];
	[removeTyphoon release];
	[removeRain release];
	[removeWater release];
	[removeProject release];
    [removeAround release];
	[removeSatellite release];
	[removeSearchMem release];
	[mapSeg release];
	[multiLayerEnable release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil multiInfo:(BOOL)mInfo typhoonInfo:(BOOL)tInfo rainInfo:(BOOL)rInfo waterInfo:(BOOL)wInfo projectInfo:(BOOL)pInfo satelliteInfo:(BOOL)sInfo aroundInfo:(BOOL)aInfo searchInfo:(BOOL)seInfo mapType:(NSInteger)typeInfo{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		if (mInfo) {
			self.multiLayerEnable= [NSString stringWithFormat: @"多层叠加"];
		} else {
			self.multiLayerEnable = [NSString stringWithFormat: @"关闭"] ;
		}
		
		if (tInfo) {
			self.typhoonLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.typhoonLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (rInfo) {
			self.rainLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.rainLayer= [NSString stringWithFormat:@"NONELAYER"] ;
		}
		
		if (wInfo) {
			self.waterLayer=[NSString stringWithFormat:@"LAYER"];
		} else {
			self.waterLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (pInfo) {
			self.projectLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.projectLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (sInfo) {
			self.satelliteLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.satelliteLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
        
        if (aInfo) {
			self.aroundLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.aroundLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (seInfo) {
			self.searchMemLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.searchMemLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if ([self isHaveLayers]) {
			self.totalLayer = [NSString stringWithFormat:@"LAYER"];
		} else {
			self.totalLayer = [NSString stringWithFormat:@"NONELAYER"];
		}

		
		switch (typeInfo) {
			case 0:
				self.mapType = [NSString stringWithFormat: @"标准"];
				break;
			case 1:
				self.mapType = [NSString stringWithFormat: @"卫星"];
				break;
			case 2:
				self.mapType = [NSString stringWithFormat: @"混合"];
				break;
		}
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.dataSource = [NSMutableArray arrayWithObjects:[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
																				  @"多层叠加",@"TITLE",
																				  self.multiSw,@"SUBVIEW",nil],nil],
					   [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
												  @"台风",@"TITLE",
												  self.removeTyphoon,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"雨情",@"TITLE",
						 self.removeRain,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"水情",@"TITLE",
						 self.removeWater,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"工情",@"TITLE",
						 self.removeProject,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"云图",@"TITLE",
						 self.removeSatellite,@"SUBVIEW",nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:
						 @"周边",@"TITLE",
						 self.removeAround,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"搜索",@"TITLE",
						 self.removeSearchMem,@"SUBVIEW",nil],nil],
					   [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
												  @"none",@"TITLE",
												  self.mapSeg,@"SUBVIEW",nil],nil],
					   [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
												  @"当前图层",@"TITLE",
												  self.removeAll,@"SUBVIEW",nil],nil],nil];
	
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section==0) {
		return [NSString stringWithFormat: @""];
	} else if (section == 1) {
		return [NSString stringWithFormat: @"图层清除"];
	} else {
		return [NSString stringWithFormat: @"地图类型"];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	if (section == 2) {
		return [NSString stringWithFormat: @"当前版本:V%@\n发布日期:%@",VERSIONID,PUBLICDATE];
	} else {
		return [NSString stringWithFormat: @""];
	}

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if ([multiLayerEnable isEqualToString:@"关闭"]&&section == 1) {
		return 1;
	} else {
		return [[self.dataSource objectAtIndex:section] count];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [indexPath section]==2?64:50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	
	if ([indexPath section] == 0)
	{
		static NSString *kSwitchCellID = @"SwitchCellID";
		cell = [self.tableView dequeueReusableCellWithIdentifier:kSwitchCellID];
        if (cell == nil)
        {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSwitchCellID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
		else
		{
			
		}
		
		cell.textLabel.text = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"TITLE"];
		
		UISwitch *temSwitch = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"SUBVIEW"];
		[cell.contentView addSubview:temSwitch];
	}
	else if ([indexPath section] == 1)
	{
		static NSString *kRemoveCellID = @"RemoveCellID";
		cell = [self.tableView dequeueReusableCellWithIdentifier:kRemoveCellID];
        if (cell == nil)
        {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRemoveCellID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
		else
		{
			
		}
		
		if ([multiLayerEnable isEqualToString:@"关闭"]&&indexPath.section == 1) {
			cell.textLabel.text = [NSString stringWithFormat: @"当前图层"];
			UIButton *temButton = [[[self.dataSource objectAtIndex: 3] objectAtIndex:0] valueForKey:@"SUBVIEW"];
			[cell.contentView addSubview:temButton];
		} else {
			cell.textLabel.text = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"TITLE"];
			UIButton *temButton = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"SUBVIEW"];
			[cell.contentView addSubview:temButton];
		}
		
	}
	else if ([indexPath section] == 2)
	{
		static NSString *kSatelliteCellID = @"SatelliteCellID";
		cell = [self.tableView dequeueReusableCellWithIdentifier:kSatelliteCellID];
        if (cell == nil)
        {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSatelliteCellID] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
		else
		{
			
		}
		
		UISegmentedControl *temSeg = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"SUBVIEW"];
		[cell.contentView addSubview:temSeg];
	}
	return cell;
}

#pragma mark -
#pragma mark Init All Buttons
+ (UIButton *)newButtonWithInfo:(NSString *)info
						 target:(id)target
					   selector:(SEL)selector
						  frame:(CGRect)frame
						  image:(UIImage *)image
				   imagePressed:(UIImage *)imagePressed
{	
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	
	UIImage *newPressedImage = [imagePressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[button setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:newPressedImage forState:UIControlStateDisabled];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
    // in case the parent view draws with a custom color or gradient, use a transparent color
	button.backgroundColor = [UIColor clearColor];
	
	if ([info isEqualToString:@"NONELAYER"]) {
		[button setEnabled:NO];
	} else {
		[button setEnabled:YES];
	}

	
	return button;
}



-(UISwitch *)multiSw{
	if (multiSw == nil) {
		multiSw = [[UISwitch alloc] initWithFrame:CGRectMake(122.0, 12.0, 94, 27)];
	}
	
	if ([self.multiLayerEnable isEqualToString:@"多层叠加"]) {
		[multiSw setOn:YES];
	}
	
	[multiSw addTarget:self action:@selector(swAction:) forControlEvents:UIControlEventValueChanged];
	return multiSw;
}

-(UIButton *)removeAll{
	if (removeAll == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeAll addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeAll.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeAll = [ControlCascade newButtonWithInfo:self.totalLayer
														  target:self
														selector:@selector(allAction:)
														   frame:frame
														   image:buttonBackground
													imagePressed:buttonBackgroundPressed];
		removeAll.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeAll;
}

-(UIButton *)removeTyphoon{
	if (removeTyphoon == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeTyphoon addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeTyphoon.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeTyphoon = [ControlCascade newButtonWithInfo:self.typhoonLayer
															  target:self
															selector:@selector(typhoonAction:)
															   frame:frame
															   image:buttonBackground
														imagePressed:buttonBackgroundPressed];
		removeTyphoon.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeTyphoon;
}

-(UIButton *)removeRain{
	if (removeRain == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeRain addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeRain.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeRain = [ControlCascade newButtonWithInfo:self.rainLayer
														   target:self
														 selector:@selector(rainAction:)
															frame:frame
															image:buttonBackground
													 imagePressed:buttonBackgroundPressed];
		removeRain.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeRain;
}

-(UIButton *)removeWater{
	if (removeWater == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeWater addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeWater.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeWater = [ControlCascade newButtonWithInfo:self.waterLayer
															target:self
														  selector:@selector(waterAction:)
															 frame:frame
															 image:buttonBackground
													  imagePressed:buttonBackgroundPressed];
		removeWater.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeWater;
}

-(UIButton *)removeProject{
	if (removeProject == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeProject addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeProject.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeProject = [ControlCascade newButtonWithInfo:self.projectLayer
												 target:self
											   selector:@selector(projectAction:)
												  frame:frame
												  image:buttonBackground
										   imagePressed:buttonBackgroundPressed];
		removeProject.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeProject;
}


-(UIButton *)removeSatellite{
	if (removeSatellite == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeSatellite addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeSatellite.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeSatellite = [ControlCascade newButtonWithInfo:self.satelliteLayer
																target:self
															  selector:@selector(satelliteAction:)
																 frame:frame
																 image:buttonBackground
														  imagePressed:buttonBackgroundPressed];
		removeSatellite.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeSatellite;
}

-(UIButton *)removeAround{
	if (removeAround == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeAround addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeAround.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeAround = [ControlCascade newButtonWithInfo:self.aroundLayer
                                                     target:self
                                                   selector:@selector(aroundAction:)
                                                      frame:frame
                                                      image:buttonBackground
                                               imagePressed:buttonBackgroundPressed];
		removeAround.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeAround;
}

-(UIButton *)removeSearchMem{
	if (removeSearchMem == nil)
	{
		// create a UIButton (UIButtonTypeRoundedRect)
		[removeSearchMem addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
		
		removeSearchMem.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
		// create the UIButtons with various background images
		// white button:
		UIImage *buttonBackground = [UIImage imageNamed:@"blueButton.png"];
		UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"whiteButton.png"];
		CGRect frame = CGRectMake(122.0, 12.0, 94, 27);
		removeSearchMem = [ControlCascade newButtonWithInfo:self.searchMemLayer
													 target:self
												   selector:@selector(searchAction:)
													  frame:frame
													  image:buttonBackground
											   imagePressed:buttonBackgroundPressed];
		removeSearchMem.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeSearchMem;
}

-(UISegmentedControl *)mapSeg{
	if (mapSeg == nil) {
		mapSeg = [[UISegmentedControl alloc] initWithItems:[NSMutableArray arrayWithObjects:@"标准",@"卫星",@"混合",nil]];
		mapSeg.frame = CGRectMake(16.0, 12.0, 212, 40);
	}
	
	if ([self.mapType isEqualToString:self.mapType]) {
		if ([self.mapType isEqualToString:@"标准"]) {
			mapSeg.selectedSegmentIndex = 0;
		} else if ([self.mapType isEqualToString:@"卫星"]) {
			mapSeg.selectedSegmentIndex = 1;
		} else if ([self.mapType isEqualToString:@"混合"]) {
			mapSeg.selectedSegmentIndex = 2;
		}
	}
	[mapSeg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
	return mapSeg;
}

#pragma mark -
#pragma mark Response Actions
-(void)disableAllButtonAndRemoveAllLayers{
	self.removeTyphoon.enabled = NO;
	self.typhoonLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeRain.enabled = NO;
	self.rainLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeWater.enabled = NO;
	self.waterLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeProject.enabled = NO;
	self.projectLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeSatellite.enabled =NO;
	self.satelliteLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeSearchMem.enabled =NO;
	self.searchMemLayer = [NSString stringWithFormat:@"NONELAYER"];
}

-(BOOL)isHaveLayers{
	if ([self.typhoonLayer length]>5&&[self.rainLayer length]>5&&[self.waterLayer length]>5&&[self.projectLayer length]>5&&[self.satelliteLayer length]>5&&[self.searchMemLayer length]>5&&[self.aroundLayer length]>5) {
		return NO;
	} else {
		return YES;
	}
}

-(void)swAction:(id)sender{
	UISwitch *temSwitch = (UISwitch *)sender;
	if (temSwitch.on==YES) {
		self.contentSizeForViewInPopover = CGSizeMake(260, 550+20);
		self.multiLayerEnable = [NSString stringWithFormat: @"多层叠加"];
		[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
	} else {
		self.multiLayerEnable = [NSString stringWithFormat: @"关闭"];
		self.contentSizeForViewInPopover = CGSizeMake(260, 300+20);
		[self disableAllButtonAndRemoveAllLayers];
		[self.removeAll setEnabled:NO];
		[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
	}
	
	[delegate dealWithCascade:self removeName:self.multiLayerEnable];
}

-(void)typhoonAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrT = [NSString stringWithFormat:@"台风"];
	[delegate dealWithCascade:self removeName:temStrT];
	self.typhoonLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)rainAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrR = [NSString stringWithFormat:@"雨情"];
	[delegate dealWithCascade:self removeName:temStrR];
	self.rainLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)waterAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrW = [NSString stringWithFormat:@"水情"];
	[delegate dealWithCascade:self removeName:temStrW];
	self.waterLayer = [NSString stringWithFormat: @"NONELAYER"]; 
}

-(void)projectAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrP = [NSString stringWithFormat:@"工情"];
	[delegate dealWithCascade:self removeName:temStrP];
	self.projectLayer = [NSString stringWithFormat: @"NONELAYER"]; 
}

-(void)satelliteAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrS = [NSString stringWithFormat:@"云图"];
	[delegate dealWithCascade:self removeName:temStrS];
	self.satelliteLayer = [NSString stringWithFormat: @"NONELAYER"];
	/*
	if ([self isHaveLayers]==NO) {
		[self.removeAll setEnabled:NO];
		self.totalLayer = [NSString stringWithFormat: @"NONELAYER"];
	}
	*/
}

-(void)aroundAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrS = [NSString stringWithFormat:@"周边"];
	[delegate dealWithCascade:self removeName:temStrS];
	self.aroundLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)searchAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrSe = [NSString stringWithFormat:@"搜索"];
	[delegate dealWithCascade:self removeName:temStrSe];
	self.searchMemLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)allAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrTo = [NSString stringWithFormat:@"全部"];
	[delegate dealWithCascade:self removeName:temStrTo];
	[self disableAllButtonAndRemoveAllLayers];
}

-(void)segChanged:(id)sender{
	UISegmentedControl *temSeg = (UISegmentedControl *)sender;
	NSString *temStr;
	switch (temSeg.selectedSegmentIndex) {
		case 0:
			temStr = [NSString stringWithFormat: @"标准"];
			break;
		case 1:
			temStr = [NSString stringWithFormat: @"卫星"];
			break;
		case 2:
			temStr = [NSString stringWithFormat: @"混合"];
			break;
	}
	[delegate dealWithCascade:self removeName:temStr];
}

@end
