//
//  UserCell.m
//  NSCRend
//
//  Created by Julio Carrettoni on 3/18/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "UserCell.h"
#import "EXPhotoViewer.h"
#import "UIImageView+UIImageView_FaceAwareFill.h"

@implementation UserCell

- (void) setData:(NSDictionary*) data {
    
    userImage.image = [self loadAvatarFor:data[@"avatar"]];
    
    userName.text = data[@"name"];
    
    sexyLabel.text = [data[@"sexy"] stringValue];
    
    noSexyLabel.text = [data[@"nosexy"] stringValue];
    
    if ([data[@"isMale"] boolValue]) {
        backgroundImage.image = [UIImage imageNamed:@"blue.jpg"];
    }
    else {
        backgroundImage.image = [UIImage imageNamed:@"pink.jpg"];
    }
}

- (IBAction)onAvatarButtonTUI:(id)sender {
    [EXPhotoViewer showImageFrom:userImage];
}





















- (UIImage*) loadAvatarFor:(NSString*) imageName {
    
#if SLOW_DEMO
    
    NSArray* nameArray = [imageName componentsSeparatedByString:@"."];
    
    if (nameArray.count < 1) {
        return nil;
    }
    
    NSString* fileExtension = [nameArray lastObject];
    
    NSMutableArray* mutableArray = [NSMutableArray array];
    
    [mutableArray addObjectsFromArray:nameArray];
    
    [mutableArray removeLastObject];
    
    NSString* fileName = [mutableArray componentsJoinedByString:@"."];
    
    NSString* imagePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        return [UIImage imageWithData:[[NSFileManager defaultManager] contentsAtPath:imagePath]];
    }
    
    return nil;
    
#else
    
    return [UIImage imageNamed:imageName];
    
#endif
}

@end
