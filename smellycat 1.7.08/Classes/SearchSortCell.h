//
//  SearchSortCell.h
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import <UIKit/UIKit.h>

@class SearchInfoModel;
@interface SearchSortCell : UITableViewCell
/*
 <name>青山江·&gt;=100km2·宁波市·余姚市</name>
 <sort>工情</sort>
 <type>河流</type>
 <ennmcd>AGD103B2</ennmcd>
 <en_gr>1</en_gr>
 <description>青山江</description>
 */
@property(nonatomic,retain) IBOutlet UILabel *name;
@property(nonatomic,retain) SearchInfoModel *sectioninfo;
-(void)setValue;
@end
