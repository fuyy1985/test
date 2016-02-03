//
//  SearchSortCell.m
//  navag
//
//  Created by GPL on 13-11-11.
//
//

#import "SearchSortCell.h"
#import "SearchInfoModel.h"

@implementation SearchSortCell
@synthesize name,sectioninfo;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValue;
{
    self.name.text = sectioninfo.srName;
}

- (void)dealloc
{
    [name release];
    [sectioninfo release];
    [super dealloc];
}

@end
