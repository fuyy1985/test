//
//  LocationController.m
//  navag
//
//  Created by Heiby He on 09-8-28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LocationController.h"
#import "Database.h"
#import "LocationInfo.h"
#import "FileManager.h"
#import "smellycatViewController.h"

@implementation LocationController
@synthesize picker, myLabel, timer;
@synthesize provinces, citys, towns,myButton;
@synthesize delegate;
@synthesize isFirstLoad, intProvince, intCity, intTown, current,isOnlyChoose;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.provinces = [NSMutableArray array];
		self.citys = [NSMutableArray array];
		self.towns = [NSMutableArray array];
		isFirstLoad = YES;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
}
*/

- (NSInteger)getIndexofArray:(NSArray *)locations withKey:(NSString *)key{
	NSInteger index = 0;
	for(int i=0; i<[locations count]; i++)
	{
		LocationInfo *location = [locations objectAtIndex:i];
		if([location.pac compare:key] == NSOrderedSame){
			index = i;
			break;
		}
	}
	return index;
}
-(void) viewWillAppear:(BOOL)animated{
	self.contentSizeForViewInPopover = CGSizeMake(320,337);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	if(isFirstLoad){
		FileManager *config=[[FileManager alloc] init];
		NSString *strCode = [config getValue:@"areacode"];
		NSString *defCode = [config getValue:@"defaultarea"];
		[config release];
		
		LocationInfo *defaultLocation = [[LocationInfo locationinfo] infoWithDefaultValue];
		
		Database *db=[[Database alloc] init];
		
		
		NSString *strArea = @"全省";
		// Province
		NSArray *areas = [strCode componentsSeparatedByString:@","];
		if([areas count]==1 && [(NSString *)[areas objectAtIndex:0] compare:@"00"]==NSOrderedSame){  //流域吧
			provinces=[[NSMutableArray alloc] initWithArray:[db getAllProvince]];
			[provinces insertObject:defaultLocation atIndex:0];
		}else{
			for(int i=0; i<[areas count]; i++){
				NSString *area = [NSString stringWithFormat:@"%@0000", [areas objectAtIndex:i]];
				//修改
				LocationInfo *lo = [db getCityInfoByCode:area];
				lo.pacname = @"全省";
				[provinces addObject:lo];
				strArea = lo.pacname;
			}
			if([areas count] != 1)
				[provinces insertObject:defaultLocation atIndex:0];
		}
		
		NSString *strProvince = [NSString stringWithFormat:@"%@0000", [defCode substringToIndex:2]];
		NSInteger index = [self getIndexofArray:provinces withKey:strProvince];
		[picker selectRow: index inComponent:ProvinceComponent animated:YES];
		if(index != 0){
			LocationInfo *liProvince = [provinces objectAtIndex:index];
			strArea = [NSString stringWithFormat:@"%@", liProvince.pacname];
		}
	
		// City
		LocationInfo *location1 = [self.provinces objectAtIndex:index];
		NSString *str1 = [NSString stringWithFormat:@"%@%%00", [location1.pac substringToIndex:2]];
		citys=[[NSMutableArray alloc] initWithArray:[db getCityByProvice:str1]];
		[citys insertObject:defaultLocation atIndex:0];
		NSString *strCity = [NSString stringWithFormat:@"%@00", [defCode substringToIndex:4]];
		[picker reloadComponent:CityComponent];
		index = [self getIndexofArray:citys withKey:strCity];
		[picker selectRow: index inComponent:CityComponent animated:YES];
		if(index != 0){
			LocationInfo *liCity = [citys objectAtIndex:index];
			strArea = [strArea stringByAppendingFormat:@"•%@", liCity.pacname];
		}
	
		// Town
		LocationInfo *location2 = [self.citys objectAtIndex:index];
		NSString *str2 = [NSString stringWithFormat:@"%@%%", [location2.pac substringToIndex:4]];
		towns=[[NSMutableArray alloc] initWithArray:[db getTownByCity:str2]];
		[towns insertObject:defaultLocation atIndex:0];
		[picker reloadComponent:TownComponent];
		index = [self getIndexofArray:towns withKey:defCode];
		[picker selectRow: index inComponent:TownComponent animated:YES];
		if(index != 0){
			LocationInfo *liTown = [towns objectAtIndex:index];
			strArea = [strArea stringByAppendingFormat:@"•%@", liTown.pacname];
		}
		
		[myLabel setText:strArea];
		
		
		[db release];
		
		isFirstLoad = NO;
	}
	self.myButton.enabled = NO;
}

- (NSString *)getAreaName{
	// Get the Area Name String
	NSString *areaName = @"";
	//NSInteger selectProvince = [picker selectedRowInComponent:ProvinceComponent];
	NSInteger selectCity = [picker selectedRowInComponent:CityComponent];
	NSInteger selectTown = [picker selectedRowInComponent:TownComponent];
	LocationInfo *liProvince = [provinces objectAtIndex:[picker selectedRowInComponent:ProvinceComponent]];
	LocationInfo *liCity = [citys objectAtIndex:[picker selectedRowInComponent:CityComponent]];
	LocationInfo *liTown =[towns objectAtIndex:[picker selectedRowInComponent:TownComponent]];
	switch (current) {
		case ProvinceComponent:
			liCity = [citys objectAtIndex:intCity];
			liTown = [towns objectAtIndex:intTown];
			selectCity = intCity;
			selectTown = intTown;
			break;
		case CityComponent:
			liTown = [towns objectAtIndex:intTown];
			selectTown = intTown;
			break;
		default:
			break;
	}
	
	NSString *strCity = [NSString stringWithFormat:@"•%@", liCity.pacname];
	if([liCity.pac compare:@"000000"] == NSOrderedSame)
		strCity = @"";
	NSString *strTown = [NSString stringWithFormat:@"•%@", liTown.pacname];
	if([liTown.pac compare:@"000000"] == NSOrderedSame)
		strTown = @"";
	areaName = [NSString stringWithFormat:@"%@%@%@", liProvince.pacname, strCity, strTown];
	
	return areaName;
}

-(IBAction)SaveArea:(id)sender{
	// Get the Area Name String
	//NSString *areaName = @"";
	NSInteger selectProvince = [picker selectedRowInComponent:ProvinceComponent];
	NSInteger selectCity = [picker selectedRowInComponent:CityComponent];
	NSInteger selectTown = [picker selectedRowInComponent:TownComponent];
	//LocationInfo *liProvince = [provinces objectAtIndex:[picker selectedRowInComponent:ProvinceComponent]];
	LocationInfo *liCity = [citys objectAtIndex:[picker selectedRowInComponent:CityComponent]];
	LocationInfo *liTown =[towns objectAtIndex:[picker selectedRowInComponent:TownComponent]];
	switch (current) {
		case ProvinceComponent:
			liCity = [citys objectAtIndex:intCity];
			liTown = [towns objectAtIndex:intTown];
			selectCity = intCity;
			selectTown = intTown;
			break;
		case CityComponent:
			liTown = [towns objectAtIndex:intTown];
			selectTown = intTown;
			break;
		default:
			break;
	}
	
	// Save Default Area
	LocationInfo *location;
	if(selectTown == 0){
		if(selectCity == 0){
			location = [provinces objectAtIndex:selectProvince];
			if(selectProvince == 0){
			}
		}else{
			location = [citys objectAtIndex:selectCity];
		}
	}else{
		location = [towns objectAtIndex:selectTown];
	}
	
	FileManager *config=[[FileManager alloc] init];
	[config writeConfigFile:@"defaultarea" ValueForKey:location.pac]; 
	[config release];
	
	//convert to smellycatviewcontroller ,change the button'show
	//[delegate dealLocationController:self withName:location.pacname withPac:location.pac];
	smellycatViewController *tc=[smellycatViewController sharedCat];
	objc_msgSend(tc,@selector(dealLocationwithName:withPac:withKey:),location.pacname,location.pac,isOnlyChoose);
	self.myButton.enabled = NO;
}

-(IBAction)dismissPopover:(id)sender{
	smellycatViewController *myCon = [smellycatViewController sharedCat];
	[myCon dismissLocation];
}
	   
- (NSString *)getAreaname{
	NSString *areaName = @"";
	LocationInfo *liProvince = [provinces objectAtIndex:[picker selectedRowInComponent:ProvinceComponent]];
	LocationInfo *liCity = [citys objectAtIndex:[picker selectedRowInComponent:CityComponent]];
	LocationInfo *liTown =[towns objectAtIndex:[picker selectedRowInComponent:TownComponent]];
	switch (current) {
		case ProvinceComponent:
			liCity = [citys objectAtIndex:intCity];
			liTown = [towns objectAtIndex:intTown];
			break;
		case CityComponent:
			liTown = [towns objectAtIndex:intTown];
			break;
		default:
			break;
	}

	NSString *strCity = [NSString stringWithFormat:@"•%@", liCity.pacname];
	if([liCity.pac compare:@"000000"] == NSOrderedSame)
		strCity = @"";
	NSString *strTown = [NSString stringWithFormat:@"•%@", liTown.pacname];
	if([liTown.pac compare:@"000000"] == NSOrderedSame)
		strTown = @"";
	areaName = [NSString stringWithFormat:@"%@%@%@", liProvince.pacname, strCity, strTown];
	
	return areaName;
}

- (void)timerEvent
{
	[myLabel setText:[self getAreaName]];
	[timer invalidate];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.myButton = nil;
}


- (void)dealloc {
	[myButton release];
	[timer release];
	[super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (component == CityComponent)
		return [self.citys count];
	else if(component == TownComponent)
		return [self.towns count];
	return [self.provinces count];
}
#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	LocationInfo *location;
	
	if (component == CityComponent)
		location = [self.citys objectAtIndex:row];
	else if(component == TownComponent)
		location = [self.towns objectAtIndex:row];
	else if(component == ProvinceComponent)
		location = [self.provinces objectAtIndex:row];

	return location.pacname;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	self.myButton.enabled = YES;
	LocationInfo *defaultLocation = [[LocationInfo locationinfo] infoWithDefaultValue];
	
	if (component == ProvinceComponent)
	{
		LocationInfo *location1 = [self.provinces objectAtIndex:row];
		if([location1.pac compare:@"000000"] == NSOrderedSame)
		{
			[citys removeAllObjects];
			[citys insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:CityComponent];
			[picker selectRow: 0 inComponent:CityComponent animated:YES];
			
			[towns removeAllObjects];
			[towns insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:TownComponent];
			[picker selectRow: 0 inComponent:TownComponent animated:YES];
		}
		else
		{
			Database *db=[[Database alloc] init];
		
			NSString *str1 = [NSString stringWithFormat:@"%@%%00", [location1.pac substringToIndex:2]];
			citys=[[NSMutableArray alloc] initWithArray:[db getCityByProvice:str1]];
			[citys insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:CityComponent];
			[picker selectRow:0 inComponent:CityComponent animated:YES];
		
			LocationInfo *location2 = [self.citys objectAtIndex:0];
			NSString *str2 = [NSString stringWithFormat:@"%@%%", [location2.pac substringToIndex:4]];
			towns=[[NSMutableArray alloc] initWithArray:[db getTownByCity:str2]];
			[towns insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:TownComponent];
			[picker selectRow:0 inComponent:TownComponent animated:YES];
		
			[db release];
			
		}
		current = ProvinceComponent;
		intCity = 0;
		intTown = 0;
	}
	else if (component == CityComponent)
	{
		LocationInfo *location2 = [self.citys objectAtIndex:row];
		if([location2.pac compare:@"000000"] == NSOrderedSame)
		{
			[towns removeAllObjects];
			[towns insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:TownComponent];
			[picker selectRow: 0 inComponent:TownComponent animated:YES];
		}
		else
		{
			Database *db=[[Database alloc] init];
		
			NSString *str2 = [NSString stringWithFormat:@"%@%%", [location2.pac substringToIndex:4]];
			towns=[[NSMutableArray alloc] initWithArray:[db getTownByCity:str2]];
			[towns insertObject:defaultLocation atIndex:0];
			[picker reloadComponent:TownComponent];
			[picker selectRow:0 inComponent:TownComponent animated:YES];
		
			[db release];
		}
		
		intTown = 0;
		current = CityComponent;
	}
	else if(component == TownComponent)
	{
		current = TownComponent;
	}
	
	timer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerEvent) userInfo:nil repeats:NO] retain];
	[timer fire];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	if (component == ProvinceComponent)
		return 85;
	return 105;
}

@end
