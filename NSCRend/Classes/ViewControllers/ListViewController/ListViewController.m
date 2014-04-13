//
//  ListViewController.m
//  NSCRend
//
//  Created by Julio Carrettoni on 3/18/14.
//  Copyright (c) 2014 Julio Carrettoni. All rights reserved.
//

#import "ListViewController.h"
#import "UserCell.h"

@interface ListViewController ()

@end

@implementation ListViewController {
    __weak IBOutlet UITableView *usersTable;
    NSArray* data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [usersTable registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    [self generateFakeData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
#if SLOW_DEMO
    UserCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell_LALALA_ME_EQUIVOQUE_DE_IDENTIFIER"];
    if (!cell)
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:nil options:nil] lastObject];
#else
    UserCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
#endif
    
    
    [cell setData:data[indexPath.row]];
    
    return cell;
}





//HERE BE DRAGONS




















- (void) generateFakeData {
    
    NSMutableArray* mutArrayFemaleNames = [@[@"Lissette Paniagua",
                                             @"Leone Huebner",
                                             @"Rachelle Mey",
                                             @"Rosalee Fouts",
                                             @"Sade Dandrea",
                                             @"Claudie Corriveau",
                                             @"Joy Steppe",
                                             @"Ines Blakeman",
                                             @"Eugena Smithwick",
                                             @"Halley Baumann",
                                             @"Tomasa Fugitt",
                                             @"Ellie Ardrey",
                                             @"Karina Breece",
                                             @"Darcie Duer",
                                             @"Shana Harrell",
                                             @"Otilia Wellborn",
                                             @"Hiedi Bones",
                                             @"Britteny Buckler",
                                             @"Millie Bulter",
                                             @"Bethanie Shumake",
                                             @"Anita Giammarino",
                                             @"Faustina Macbeth",
                                             @"Hyo Bolick",
                                             @"Phillis Mayle",
                                             @"Dorothea Hafford",
                                             @"Pauletta Newberg",
                                             @"Janie Coombs",
                                             @"Vennie Courtright",
                                             @"Kathlene Yager",
                                             @"Charlene Rumsey"] mutableCopy];
    
    NSMutableArray* mutArrayFemaleImages = [@[@"1_woman.jpg",
                                              @"2_woman.jpg",
                                              @"3_woman.jpg",
                                              @"4_woman.jpg",
                                              @"5_woman.jpg",
                                              @"6_woman.jpg",
                                              @"7_woman.jpg",
                                              @"8_woman.jpg",
                                              @"9_woman.jpg",
                                              @"10_woman.jpg",
                                              @"11_woman.jpg",
                                              @"12_woman.jpg",
                                              @"13_woman.jpg",
                                              @"14_woman.jpg",
                                              @"15_woman.jpg",
                                              @"16_woman.jpg",
                                              @"17_woman.jpg",
                                              @"18_woman.jpg",
                                              @"19_woman.jpg",
                                              @"20_woman.jpg",
                                              @"21_woman.jpg",
                                              @"22_woman.jpg",
                                              @"23_woman.jpg",
                                              @"24_woman.jpg",
                                              @"25_woman.jpg",
                                              @"26_woman.jpg",
                                              @"27_woman.jpg",
                                              @"28_woman.jpg",
                                              @"29_woman.jpg",
                                              @"30_woman.jpg",] mutableCopy];
    
    NSMutableArray* mutArrayMaleNames = [@[@"Elias Krishnan",
                                           @"Gregg Kantor",
                                           @"Olin Caple",
                                           @"Ellsworth Desai",
                                           @"Benito Appel",
                                           @"Graham Ruch",
                                           @"Millard Walburn",
                                           @"Lyndon Mcelhaney",
                                           @"Dante Cusic",
                                           @"Carrol Yzaguirre",
                                           @"Leon Allred",
                                           @"Gaston Mertens",
                                           @"Gavin Mathewson",
                                           @"Donnie Hemminger",
                                           @"Kory Vigil",
                                           @"Laurence Maday",
                                           @"Stewart Woltz",
                                           @"Rashad Westberg",
                                           @"Benny Levasseur",
                                           @"Maurice Sasson",
                                           @"Carroll Debus",
                                           @"Marshall Tsai",
                                           @"Dong Tetrault",
                                           @"Jc Lampman",
                                           @"Phillip Nakken",
                                           @"Wes Halko",
                                           @"Sherman Leeper",
                                           @"Tommy Rowe",
                                           @"Murray Haile",
                                           @"Timothy Ammon"] mutableCopy];
    
    NSMutableArray* mutArrayMaleImages = [@[@"1_man.jpg",
                                            @"2_man.jpg",
                                            @"3_man.jpg",
                                            @"4_man.jpg",
                                            @"5_man.jpg",
                                            @"6_man.jpg",
                                            @"7_man.jpg",
                                            @"8_man.jpg",
                                            @"9_man.jpg",
                                            @"10_man.jpg",
                                            @"11_man.jpg",
                                            @"12_man.jpg",
                                            @"13_man.jpg",
                                            @"14_man.jpg",
                                            @"15_man.jpg",
                                            @"16_man.jpg",
                                            @"17_man.jpg",
                                            @"18_man.jpg",
                                            @"19_man.jpg",
                                            @"20_man.jpg",
                                            @"21_man.jpg",
                                            @"22_man.jpg",
                                            @"23_man.jpg",
                                            @"24_man.jpg",
                                            @"25_man.jpg",
                                            @"26_man.jpg",
                                            @"27_man.jpg",
                                            @"28_man.jpg",
                                            @"29_man.jpg",
                                            @"30_man.jpg",] mutableCopy];
    
    NSMutableArray* users = [NSMutableArray arrayWithCapacity:mutArrayMaleNames.count];
    
    while (mutArrayMaleNames.count > 0 || mutArrayFemaleNames.count > 0) {
        
        NSString* name = nil;
        NSString* avatar = nil;
        BOOL isMale = (rand()%2 == 0);
        int sexy = rand() % 30;
        int nosexy = 30 - sexy;
        
        
        if ((isMale || mutArrayFemaleNames.count == 0) && mutArrayMaleNames.count > 0) {
            int indexName = rand() % mutArrayMaleNames.count;
            int indexAvatar = rand() % mutArrayMaleImages.count;
            name = mutArrayMaleNames[indexName];
            avatar = mutArrayMaleImages[indexAvatar];
            [mutArrayMaleNames removeObjectAtIndex:indexName];
            [mutArrayMaleImages removeObjectAtIndex:indexAvatar];
        }
        else {
            int indexName = rand() % mutArrayFemaleNames.count;
            int indexAvatar = rand() % mutArrayFemaleImages.count;
            name = mutArrayFemaleNames[indexName];
            avatar = mutArrayFemaleImages[indexAvatar];
            [mutArrayFemaleNames removeObjectAtIndex:indexName];
            [mutArrayFemaleImages removeObjectAtIndex:indexAvatar];
        }
        [users addObject:@{@"name":name, @"avatar":avatar, @"isMale":@(isMale), @"sexy":@(sexy), @"nosexy":@(nosexy)}];
    }
    
    data = [NSArray arrayWithArray:users];
}



@end
