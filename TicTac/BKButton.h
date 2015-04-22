//
//  BKButton.h
//  TicTac
//
//  Created by Konstantyn Bykhkalo on 29.01.15.
//  Copyright (c) 2015 Bykhkalo Konstantyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKButton : UIButton

@property (assign, nonatomic) NSInteger i;
@property (assign, nonatomic) NSInteger j;

@property (assign, nonatomic) NSInteger capabilities;
@property (strong, nonatomic) NSMutableArray* direction;

@property (strong, nonatomic) IBOutlet UILabel* label;

@end
