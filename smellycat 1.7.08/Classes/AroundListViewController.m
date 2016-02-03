//
//  AroundListViewController.m
//  smellycat
//
//  Created by GPL on 13-3-11.
//
//

#import "AroundListViewController.h"
#import "CellControlCell.h"
#import "smellycatViewController.h"

#define AROUND_WIDTH 320
#define AROUND_CELL_HEIGHT 48

@interface AroundListViewController ()

@end

@implementation AroundListViewController
@synthesize contentArray = _contentArray;
@synthesize totalNum = _totalNum;
@synthesize pageNo = _pageNo;
@synthesize navigationController = _navigationController;
@synthesize hasLoaded = _hasLoaded;
@synthesize typeNm = _typeNm;

- (id)init
{
    self = [super init];
    if (self) {
        _contentArray = [[NSMutableArray alloc] init];
        _hasLoaded = NO;
    }
    return self;
}

- (void)dealloc
{
    [_contentArray release];
    [_navigationController release];
    [super dealloc];
}

- (void)getDataOnNewThread{
	if(!_hasLoaded){
		[self.tableView reloadData];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return AROUND_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSInteger temInt = (_totalNum-(_pageNo-0)*6);
	return temInt/6>0?6:temInt%6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CellControlCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        CGRect rect = CGRectMake(0, 0, AROUND_WIDTH, AROUND_CELL_HEIGHT);
        cell = [[[CellControlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = rect;
    }
    GPLNAnnotation *anno = [_contentArray objectAtIndex:(_pageNo-0)*6+indexPath.row];
    cell.cellObject = anno;
    [cell setValue];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //change look
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSUInteger row = indexPath.row;
    if (row != NSNotFound) {
        GPLNAnnotation *info = [_contentArray objectAtIndex:(_pageNo-0)*6+indexPath.row];
        NSString *infoIndex = [NSString stringWithFormat:@"%d",(_pageNo-0)*6+indexPath.row];
        NSString *typeFinal = [NSString stringWithFormat:@"%d",_typeNm];
		if (info!=nil) {
			smellycatViewController *myCon = [smellycatViewController sharedCat];
			objc_msgSend(myCon,@selector(responseAroundWithType:WithIndex:),typeFinal,infoIndex);
		}  else {
            //异常处理
			//[self showAlertView];
		}
	}
}

@end
