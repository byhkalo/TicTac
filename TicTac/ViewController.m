//
//  ViewController.m
//  TicTac
//
//  Created by Konstantyn Bykhkalo on 23.12.14.
//  Copyright (c) 2014 Bykhkalo Konstantyh. All rights reserved.
//

typedef enum {
    BKCellNumberOne = 1,
    BKCellNumberTwo = 2,
    BKCellNumberTree = 3,
    BKCellNumberFour = 4,
    BKCellNumberFive = 5,
    BKCellNumberSix = 6,
    BKCellNumberSeven = 7,
    BKCellNumberEight = 8,
    BKCellNumberNine = 9
    
}BKCellNumber;

typedef enum{
    BKDirectionDiagonalUp = 0,
    BKDirectionNext = 1,
    BKDirectionDiagonalDown = 2,
    BKDirectionDown = 3
    
}BKDirection;

#import "ViewController.h"
#import "BKButton.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray* mainArray;
@property (assign, nonatomic) NSInteger stepCount;

@property (strong, nonatomic) NSString* ourSign;
@property (strong, nonatomic) NSString* enemySign;

//@property (strong, nonatomic) NSString* signOfStep;

@end

@implementation ViewController

#pragma mark - Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //настраиваем все клетки (кнопки) и сбрасываем все нажатия
    
    self.stepCount = 0;
    [self setIndexToButtons];
    [self setEnabledtoAllButtons:NO];
    //self.signOfStep = @"X";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

-(void) setIndexToButtons {
    //создаем массив двумерный и настраиваем кнопки внутри
    
    self.mainArray = [[NSArray alloc]initWithObjects:self.arrayIOne,self.arrayITwo,self.arrayIThree, nil];
    
    for (NSInteger i = 0; i<[self.mainArray count]; i++) {
        NSArray* someArray = [self.mainArray objectAtIndex:i];
        for (NSInteger j = 0; j<[someArray count]; j++) {
            BKButton* someButton = [someArray objectAtIndex:j];
            someButton.direction = [NSMutableArray array];
            someButton.i = i;
            someButton.j = j;
            NSLog(@"someButton i = %ld, j= %ld", (long)someButton.i, (long)someButton.j);
        }
    }
}

-(void) clearAllButtons {
    for (NSArray* someArray in self.mainArray) {
        for (BKButton* someButton in someArray) {
            someButton.label.text = @"";
            someButton.label.textColor = [UIColor blackColor];
        }
    }
}

-(void) clearDirectionOfButtons {
    for (NSArray* someArray in self.mainArray) {
        for (BKButton* someButton in someArray) {
            [someButton.direction removeAllObjects];
        }
    }
}

-(void) makeMove {
    
    if (self.stepCount > 2) {
        
        
        NSArray* enemyButtons = [self findComplateLinesBySign:self.enemySign];
        
        NSArray* ourButtons = [self findComplateLinesBySign:self.ourSign];
        
        if ([ourButtons count]>0) {
            
            [self setSignOfStepInButtonFromArray:ourButtons atIndex:0];
            return;
        
        }else if ([enemyButtons count]>0) {
            
            [self setSignOfStepInButtonFromArray:enemyButtons atIndex:0];
            return;
        
        }else {
            
            NSArray* ourCapabilityArray = [self findCapabilityLinesBySign:self.ourSign];
            NSArray* enemyCapabilityArray = [self findCapabilityLinesBySign:self.enemySign];
            // Для IF -    [[[[self.arrayITwo objectAtIndex:1] label]text] isEqualToString: self.ourSign]
           if (self.firstStepSegmentControl.selectedSegmentIndex == 1) {
               //Если мы в центре
               if ([ourCapabilityArray count] > 0) {
                  
                   // У нас будут возможности
                   [self setSignOfStepInButtonFromArray:ourCapabilityArray atIndex:0];
              
               }else if ([enemyCapabilityArray count] > 0) {
                   
                   //У нас нет возможностей Но Есть у противника
                   [self setSignOfStepInButtonFromArray:enemyCapabilityArray atIndex:0];
                   
               }else{
                   
                   [self setSignOfStepInButtonFromArray:[self randomButton] atIndex:0];
               
               }
               
           }else{
               
               //Если мы не в центре
               if ([enemyCapabilityArray count] > 0) {
                   NSLog(@"\n [enemyCapabilityArray count] = %lu\n", (unsigned long)[enemyCapabilityArray count] );
                   if ([enemyCapabilityArray count]== 6) {
                       [self setSignOfStepInButtonFromArray:enemyCapabilityArray atIndex:2];
                   }else {
                       [self setSignOfStepInButtonFromArray:enemyCapabilityArray atIndex:0];
                   }
                   //У нас нет возможностей Но Есть у противника
                   
               
               }else if ([ourCapabilityArray count] > 0) {
                   
                   // У нас будут возможности
                   [self setSignOfStepInButtonFromArray:ourCapabilityArray atIndex:0];
                   
               }else{
                   
                   //Иначе Просто Рандомная клетка
                   [self setSignOfStepInButtonFromArray:[self randomButton] atIndex:0];
               
               }
            }
        }
        
        
        
    }else{
        //расмотрение первого хода
        if ([[[[self.arrayITwo objectAtIndex:1] label]text]isEqualToString:@""]) {
            
            //если центр свободен
            
            BKButton* centrButton = [self.arrayITwo objectAtIndex:1];
            centrButton.label.text = [self signOfStep];
        }else{
            
            //если центр занят
            
            BKButton* firstButton = [self.arrayIOne objectAtIndex:0];
            firstButton.label.text = [self signOfStep];
        }
        
    }
    
}

-(void) setSignOfStepInButtonFromArray:(NSArray*)someArray atIndex:(NSInteger) index{
    
    BKButton* someButton = [someArray objectAtIndex:index];
    someButton = [[self.mainArray objectAtIndex:someButton.i ]objectAtIndex:someButton.j];
    someButton.label.text = [self signOfStep];
    
}

-(NSArray*) randomButton {
    
    NSMutableArray* mutableArray = [NSMutableArray array];
    
    for (NSArray* array in self.mainArray) {
        for (BKButton* someButton in array) {
            
            if ([someButton.label.text isEqualToString:@""]) {
                
                [mutableArray addObject:someButton];
                
            }
            
        }
    }
    
    BKButton* button = [mutableArray objectAtIndex:arc4random()%mutableArray.count];
    if (button) {
        return @[button];
    }
    
    NSLog(@"return Nill in RandomButton");
    return nil;
}

-(NSArray*) findCapabilityLinesBySign:(NSString*) sign {
    
    NSMutableArray * someMutableArray = [NSMutableArray array];
    
    for (NSArray* array in self.mainArray) {
        for (BKButton* someButton in array) {
            
            if ([someButton.label.text isEqualToString:@""]) {
                NSLog(@"Создаем воображаемый Массив добавляя Знак - %@ в клетку - %ld Для поиска наиболее опасных точек",sign, (long)someButton.tag);
                someButton.label.text = sign;
                NSArray* array = [self findComplateLinesBySign:sign];
                someButton.label.text = @"";
                
                if ([array count]>0) {
                    someButton.capabilities = [array count];
                    [someMutableArray addObject:someButton];
                }
            }
        }
    }
    if ([someMutableArray count]>0) {
        NSArray* sortedArray = [NSArray arrayWithArray:someMutableArray];
        
        sortedArray = [sortedArray sortedArrayUsingComparator:^NSComparisonResult(BKButton* obj1, BKButton* obj2) {
            
            NSInteger count1 = obj1.capabilities;
            NSInteger count2 = obj2.capabilities;
            if (count1 > count2){
                return NSOrderedAscending;
            }else {
                return NSOrderedDescending;
            }
        }];
        
        return sortedArray;
    }else{
        return nil;
    }
   
}


-(NSArray*) findComplateLinesBySign:(NSString*) sign {
    
    NSMutableArray * someMutableArray = [NSMutableArray array];
    
    for (NSArray* array in self.mainArray) {
        for (BKButton* someButton in array) {
            
            if ([someButton.label.text isEqualToString:@""]) {
                NSLog(@"К полученому массиву мы добавляем знак - %@ в пустую клетку - %ld, для поиска готовых линий",sign, (long)someButton.tag);
                someButton.label.text = sign;
                NSArray* array = [self completlyLinesBySign:sign];
                someButton.label.text = @"";
                
                if ([array count]>0) {
                    [someMutableArray addObject:someButton];
                }
                
            }
            
        }
    }
    if ([someMutableArray count]>0) {
        return someMutableArray;
    }else{
        return nil;
    }
}

-(NSArray*) completlyLinesBySign:(NSString*) sign {
    
    NSMutableArray* arrayWithComplatingButton = [NSMutableArray array];
    NSInteger count = 0;
    BOOL changingElement = NO;
    
    for (NSArray* array in self.mainArray) {
        for (BKButton* someButton in array) {
            
            count = 1;
            
            if ([someButton.label.text isEqualToString:sign]) {
                NSLog(@"Стартовая КЛЕТКА. В клетке - %ld находится знак - %@", (long)someButton.tag, sign);
                
                BKButton* sourseButton = someButton;
                
                for (NSInteger i = 0;i<=3; i++) {
                    
                    BKDirection direction = (BKDirection)i;
        
                    BOOL indicator = YES;
                    
                  
                    while (indicator) {
                        //Проверка на наличие линии клеток по направлению direction
                        if ([self isNextButtonFromSourseButton:sourseButton withDirection:direction andSign:sign]) {
                            count++;
                            changingElement = YES;
                            sourseButton = [self buttonFromDirection:direction bySourceButton:sourseButton];
                            NSLog(@"По направлению - %d в клетке №%ld лежит знак - %@", direction, (long)sourseButton.tag, sign);
                        }else{
                            
                            indicator = NO;
                            count = 1;
                            
                            if (changingElement) {
                            sourseButton = someButton;
                            }
                        }
                        
                        if (count == 3) {
                            indicator = NO;
                            NSLog(@"От клетки %ld по направлению - %d лежат ТРИ ПОДРЯД одинаковых знака - %@", (long)someButton.tag, direction, sign);
                            [someButton.direction addObject:[NSNumber numberWithInt:direction]];
                            count = 1;
                        }
                    }
                }
                if ([someButton.direction count]>0) {
                    [arrayWithComplatingButton addObject:someButton];
                }
                
            }
        }
    }
    
    if ([arrayWithComplatingButton count]>0) {
        //Возвращемый массив содержит Buttons из который выходят соответствующие линии
        
        NSArray * returnArray = [NSArray arrayWithArray:arrayWithComplatingButton];
        
        returnArray = [returnArray sortedArrayUsingComparator:^NSComparisonResult(BKButton* obj1, BKButton* obj2) {
            NSInteger count1 = obj1.direction.count;
            NSInteger count2 = obj2.direction.count;
            if (count1 > count2){
                return NSOrderedAscending;
            }else {
                return NSOrderedDescending;
            }
        }];
        [self clearDirectionOfButtons];
        return returnArray;
        
    }else {
        return nil;
    }
    
}

-(BOOL) isNextButtonFromSourseButton:(BKButton*)sourse withDirection:(BKDirection)direction andSign:(NSString*) sign{
    
    BKButton* someButton = [self buttonFromDirection:direction bySourceButton:sourse];
    
    if (!someButton) {
        return NO;
    }
    if ([someButton.label.text isEqualToString:sign]) {
        return YES;
    }else {
        return NO;
    }
}

-(BKButton*) buttonFromDirection:(BKDirection) direction bySourceButton:(BKButton*) sourceButton {
    
    
    
    NSInteger i = sourceButton.i;
    NSInteger j = sourceButton.j;
    
    switch (direction) {
        case BKDirectionDiagonalUp:
            i = i-1;
            j = j+1;
            break;
            
        case BKDirectionNext:
            i = i;
            j = j+1;
            break;
            
        case BKDirectionDiagonalDown:
            i = i+1;
            j = j+1;
            break;
            
        case BKDirectionDown:
            i = i+1;
            j = j;
            break;
    }
    
    if ((i<0)||(i>2)||(j>2)) {
        return nil;
    }
    
    BKButton* someButton = [[self.mainArray objectAtIndex:i ] objectAtIndex:j];
    return someButton;
    
}

-(void) testOnComplateLinesForWin {
    
    NSArray* withWinX = [self completlyLinesBySign:@"X"];
    NSArray* withWinO = [self completlyLinesBySign:@"O"];
    
    BKButton* winStartButton = nil;
    
    if (self.switchStep.on) {
        if ([withWinX count]>0) {
            winStartButton = [withWinX firstObject];
        }else if ([withWinO count]>0) {
            winStartButton = [withWinO firstObject];
        }
    }else {
        if ([withWinO count]>0) {
            winStartButton = [withWinO firstObject];
        }else if ([withWinO count]>0) {
            winStartButton = [withWinO firstObject];
        }
    }
    
    if (winStartButton) {
        
        NSLog(@"winStartButton. tag = %ld; winStartButton. direction = %@ ", (long)winStartButton.tag, winStartButton.direction);
        NSInteger count = 1;
        BOOL changingElement = NO;
        BKButton* sourseButton = winStartButton;
        
        NSMutableArray* winnerButtonLines = [NSMutableArray array ];
        
        for (NSInteger i = 0;i<=3; i++) {
            
            BKDirection direction = (BKDirection)i;
            BOOL indicator = YES;
            
            
            while (indicator) {
                //Проверка на наличие линии клеток по направлению direction
                if ([self isNextButtonFromSourseButton:sourseButton withDirection:direction andSign:sourseButton.label.text]) {
                    count++;
                    changingElement = YES;
                    [winnerButtonLines addObject:sourseButton];
                    sourseButton = [self buttonFromDirection:direction bySourceButton:sourseButton];
                    //NSLog(@"По направлению - %d в клетке №%d лежит знак - %@", direction, sourseButton.tag, sign);
                }else{
                    
                    indicator = NO;
                    count = 1;
                    
                    if (changingElement) {
                        [winnerButtonLines  removeAllObjects];
                        sourseButton = winStartButton;
                    }
                }
                
                if (count == 3) {
                    [winnerButtonLines addObject:sourseButton];
                    indicator = NO;
                    count = 1;
                }
            }
            
            for (BKButton* someButton in winnerButtonLines) {
                someButton.label.textColor = [UIColor redColor];
                self.stepCount = 9;
            }
            
            [self setEnabledtoAllButtons:NO];
        }
        
    }
    
}

-(void) setEnabledtoAllButtons:(BOOL) yesNo  {
    
    for (NSArray* array in self.mainArray) {
        for (BKButton* someButton in array) {
            someButton.enabled = yesNo;
        }
    }
    
}

-(NSString*) signOfStep {
    
    if (self.switchStep.on == NO) {
        [self.switchStep setOn:YES animated:YES];
        return @"X";
    }else{
        [self.switchStep setOn:NO animated:YES];
        return @"O";
    }
    
}

#pragma mark - Actions

- (IBAction)pressButton:(BKButton *)sender {
    
    if ([sender.label.text isEqualToString:@""]) {
        
        sender.label.text = [self signOfStep];
    self.stepCount++;
    if (self.stepCount >=5) {
        [self testOnComplateLinesForWin];
    }
    //Вставить проверку на линию через пять ходов
    if (self.stepCount == 9) {
        [self setEnabledtoAllButtons:NO];
    }
    
    if (self.stepCount < 9) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
            if (self.typeOfGameSegmentControl.selectedSegmentIndex == 1) {
        self.stepCount++;
        [self makeMove];
        if (self.stepCount >=5) {
            [self testOnComplateLinesForWin];
        }
        if (self.stepCount == 9) {
            [self setEnabledtoAllButtons:NO];
        }
        }
            
            //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
        
    });
        
        
        
    }

        
    }
    
        
    
    //[[UIApplication sharedApplication]endIgnoringInteractionEvents];
    
}

- (IBAction)changeValueOnSegments:(UISegmentedControl *)sender {
    
    if ([sender isEqual:self.typeOfGameSegmentControl]) {
        
        //self.stepCount = 0;
        //[self clearAllButtons];
        [self setEnabledtoAllButtons:NO];
        
        if(sender.selectedSegmentIndex == 1) {
            self.firstStepSegmentControl.enabled = YES;
            self.startGameButton.enabled = NO;
        }else{
            [self.firstStepSegmentControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
            self.firstStepSegmentControl.enabled = NO;
            self.startGameButton.enabled = YES;
            
        }
    }else {
        
        //self.stepCount = 0;
        //[self clearAllButtons];
        [self setEnabledtoAllButtons:NO];
        self.startGameButton.enabled = YES;
    }
    
}

- (IBAction)startButtonPress:(UIButton *)sender {
    [self.switchStep setOn:NO animated:YES];
    self.stepCount = 0;
    [self clearAllButtons];
    [self setEnabledtoAllButtons:YES];
    
    
    
    if (self.typeOfGameSegmentControl.selectedSegmentIndex == 1) {
        if (self.firstStepSegmentControl.selectedSegmentIndex == 1) {
            self.ourSign = @"X";
            self.enemySign = @"O";
            self.stepCount++;
            [self makeMove];
        }else {
            self.ourSign = @"O";
            self.enemySign = @"X";
        }
    }
}
@end
