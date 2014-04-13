//
//  UserCell.h
//  NSCRend
//
//  Created by Julio Carrettoni on 3/18/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell {
    __weak IBOutlet UIImageView *backgroundImage;
    __weak IBOutlet UIImageView *userImage;
    __weak IBOutlet UILabel *sexyLabel;
    __weak IBOutlet UILabel *noSexyLabel;
    __weak IBOutlet UILabel *userName;
}

- (void) setData:(NSDictionary*) data;

@end
