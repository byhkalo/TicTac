//
//  ViewController.h
//  TicTac
//
//  Created by Konstantyn Bykhkalo on 23.12.14.
//  Copyright (c) 2014 Bykhkalo Konstantyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BKButton;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *switchStep;

@property (weak, nonatomic) IBOutlet UISegmentedControl *firstStepSegmentControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeOfGameSegmentControl;

@property (weak, nonatomic) IBOutlet UIButton *startGameButton;


@property (strong, nonatomic) IBOutletCollection(BKButton) NSArray *arrayIOne;
@property (strong, nonatomic) IBOutletCollection(BKButton) NSArray *arrayITwo;
@property (strong, nonatomic) IBOutletCollection(BKButton) NSArray *arrayIThree;


- (IBAction)pressButton:(UIButton *)sender;
- (IBAction)changeValueOnSegments:(UISegmentedControl *)sender;
- (IBAction)startButtonPress:(UIButton *)sender;

@end

