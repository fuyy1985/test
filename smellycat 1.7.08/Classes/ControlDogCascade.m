//
//  ControlCascade.m
//  smellycat
//
//  Created by apple on 10-11-19.
//  Copyright 2010 zjdayu. All rights reserved.
//

#import "ControlDogCascade.h"
#import "const.h"
@implementation ControlDogCascade
@synthesize delegate;
@synthesize dataSource,multiLayerEnable,typhoonLayer,satelliteLayer,searchMemLayer,mapType;
@synthesize removeTyphoon,removeSatellite,removeSearchMem,mapSeg,tableView;


- (void)dealloc {
	[typhoonLayer release];
	[satelliteLayer release];
	[searchMemLayer release];
	[mapType release];
	[dataSource release];
	
	[tableView release];
	[removeTyphoon release];
	[removeSatellite release];
	[removeSearchMem release];
	[mapSeg release];
	[multiLayerEnable release];

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil typhoonInfo:(BOOL)tInfo satelliteInfo:(BOOL)sInfo searchInfo:(BOOL)seInfo mapType:(NSInteger)typeInfo{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		if (tInfo) {
			self.typhoonLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.typhoonLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (sInfo) {
			self.satelliteLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.satelliteLayer= [NSString stringWithFormat:@"NONELAYER"];
		}
		
		if (seInfo) {
			self.searchMemLayer= [NSString stringWithFormat:@"LAYER"];
		} else {
			self.searchMemLayer= [NSString stringWithFormat:@"NONELAYER"];
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
	self.dataSource = [NSMutableArray arrayWithObjects:[NSArray arrayWithObjects:
                         [NSDictionary dictionaryWithObjectsAndKeys:
                          @"台风",@"TITLE",
                          self.removeTyphoon,@"SUBVIEW",nil],
						[NSDictionary dictionaryWithObjectsAndKeys:
						 @"云图",@"TITLE",
						 self.removeSatellite,@"SUBVIEW",nil],nil],
					   [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
												  @"none",@"TITLE",
												  self.mapSeg,@"SUBVIEW",nil],nil],nil];
	
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return [NSString stringWithFormat: @"图层清除"];
	} else {
		return [NSString stringWithFormat: @"地图类型"];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	if (section == 1) {
		return [NSString stringWithFormat: @"当前版本:%@\n发布日期:%@",VERSIONID,PUBLICDATE];
	} else {
		return [NSString stringWithFormat: @""];
	}

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [indexPath section]==1?64:50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if ([indexPath section] == 0){
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
		
        cell.textLabel.text = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"TITLE"];
        UIButton *temButton = [[[self.dataSource objectAtIndex: indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"SUBVIEW"];
        [cell.contentView addSubview:temButton];
		
	}
	else if ([indexPath section] == 1)
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
		removeTyphoon = [ControlDogCascade newButtonWithInfo:self.typhoonLayer
															  target:self
															selector:@selector(typhoonAction:)
															   frame:frame
															   image:buttonBackground
														imagePressed:buttonBackgroundPressed];
		removeTyphoon.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeTyphoon;
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
		removeSatellite = [ControlDogCascade newButtonWithInfo:self.satelliteLayer
																target:self
															  selector:@selector(satelliteAction:)
																 frame:frame
																 image:buttonBackground
														  imagePressed:buttonBackgroundPressed];
		removeSatellite.tag = 1;	// tag this view for later so we can remove it from recycled table cells
		
	}
	return removeSatellite;
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
		removeSearchMem = [ControlDogCascade newButtonWithInfo:self.searchMemLayer
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
	self.removeSatellite.enabled =NO;
	self.satelliteLayer = [NSString stringWithFormat:@"NONELAYER"];
	self.removeSearchMem.enabled =NO;
	self.searchMemLayer = [NSString stringWithFormat:@"NONELAYER"];
}

-(BOOL)isHaveLayers{
	if ([self.typhoonLayer length]>5&&[self.satelliteLayer length]>5&&[self.searchMemLayer length]>5) {
		return NO;
	} else {
		return YES;
	}
}

-(void)typhoonAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrT = [NSString stringWithFormat:@"台风"];
	[delegate dealWithDogCascade:self removeName:temStrT];
	self.typhoonLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)satelliteAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrS = [NSString stringWithFormat:@"云图"];
	[delegate dealWithDogCascade:self removeName:temStrS];
	self.satelliteLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)searchAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrSe = [NSString stringWithFormat:@"搜索"];
	[delegate dealWithDogCascade:self removeName:temStrSe];
	self.searchMemLayer = [NSString stringWithFormat: @"NONELAYER"];
}

-(void)allAction:(id)sender{
	UIButton *tempBtn = (UIButton *)sender;
	[tempBtn setEnabled:NO];
	NSString *temStrTo = [NSString stringWithFormat:@"全部"];
	[delegate dealWithDogCascade:self removeName:temStrTo];
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
	[delegate dealWithDogCascade:self removeName:temStr];
}

@end
