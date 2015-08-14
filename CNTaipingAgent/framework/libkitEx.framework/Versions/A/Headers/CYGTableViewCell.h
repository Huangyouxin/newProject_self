//
//  CYGTableViewCell.h
//  CYGTableViewCell
//


@protocol CYGTableViewCellDelegate<NSObject>

@optional

// "More button"

/*
 * Tells the delegate that the "More" button for specified row was pressed.
 */
- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "More" button will not be created and the
 * cell will act like a common UITableViewCell.
 *
 * The "More" button also supports multiline titles.
 */
- (UIFont *)tableView:(UITableView *)tableView fontForOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
/*
 * If not implemented or returning nil the "More" button will have [UIColor whiteColor]
 * as titleColor.
 */
- (UIColor *)tableView:(UITableView *)tableView titleColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "More" button will have [UIColor lightGrayColor]
 * as backgroundColor.
 */
- (UIColor *)tableView:(UITableView *)tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

// "Delete button"

/*
 * If not implemented or returning nil the "Delete" button will have the default backgroundColor.
 */
- (UIColor *)tableView:(UITableView *)tableView backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the "Delete" button will have the default titleColor.
 */
- (UIColor *)tableView:(UITableView *)tableView titleColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CYGTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CYGTableViewCellDelegate> delegate;
@property (nonatomic, weak, readonly) UITableView* tableView;
@end
