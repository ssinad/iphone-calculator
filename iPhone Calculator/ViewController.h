//
//  ViewController.h
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorModel.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property CalculatorModel * calculatorModel;

- (IBAction)clearResultLabel:(UIButton *)sender;
- (IBAction)numberButtonDidTouch:(UIButton *)sender;
- (IBAction)pointButtonDidTouch:(UIButton *)sender;
- (IBAction)negationButtonDidTouch:(UIButton *)sender;
- (IBAction)addButtonDidTouch:(UIButton *)sender;
- (IBAction)subtractButtonDidTouch:(UIButton *)sender;
- (IBAction)multiplicationButtonDidTouch:(UIButton *)sender;
- (IBAction)divisionButtonDidTouch:(UIButton *)sender;
- (IBAction)equalButtonDidTouch:(UIButton *)sender;

@end

