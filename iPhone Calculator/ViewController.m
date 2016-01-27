//
//  ViewController.m
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorFSMModel.h"
//#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
-(void)setResultLabelText:(NSString*) number;
-(void)addCharacterToResultLabelText:(NSString*) number;
-(void)addPointToResultLabel;
@property NSNumberFormatter * numberFormatter;

typedef NS_ENUM(NSUInteger, CalculatorViewState) {
    CalculatorViewInitial,
    CalculatorViewEnteringNumber,
    CalculatorViewOperatorDidSelect,
    CalculatorViewEqualDidPress
};
@property CalculatorViewState viewState;

-(void)resetButtonBorderWidths;

@end

@implementation ViewController
- (IBAction)clearResultLabel:(UIButton *)sender {
    self.resultLabel.text = @"0";
    [self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
    [self.calculatorFSMModel resetAll];
    self.viewState = CalculatorViewInitial;
}

-(void)addCharacterToResultLabelText:(NSString *)labelText{
    NSString * temporaryString = self.resultLabel.text;
    if (self.resultLabel.text.length >= 11)
        return;
    if ([self.resultLabel.text isEqualToString:@"0"] || self.viewState == CalculatorViewEqualDidPress || self.viewState == CalculatorViewOperatorDidSelect){
        temporaryString = labelText;
    }
    else{
        temporaryString = [temporaryString stringByAppendingString:labelText];
    }
    
    NSNumber * number = [self.numberFormatter numberFromString:temporaryString];
    self.resultLabel.text = [self.numberFormatter stringFromNumber:number];
    
}

-(void)addPointToResultLabel{
    NSString * temporaryString = self.resultLabel.text;
    if (self.resultLabel.text.length >= 11)
        return;
    if (! [self.resultLabel.text containsString:@"."]){
        temporaryString = [self.resultLabel.text stringByAppendingString:@"."];
    }
    NSNumber* number = [self.numberFormatter numberFromString:temporaryString];
    self.resultLabel.text = [self.numberFormatter stringFromNumber:number];
}

-(void)setResultLabelText:(NSString *)inputNumber{
    NSNumber* number = [self.numberFormatter numberFromString:inputNumber];
    self.resultLabel.text = [self.numberFormatter stringFromNumber:number];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSExpression * expression = [NSExpression expressionWithFormat:@"2.1+2"];
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    NSLog(@"%@", result);
    self.viewState = CalculatorViewInitial;
    self.calculatorFSMModel = [[CalculatorFSMModel alloc]init];
    self.numberFormatter = [[NSNumberFormatter alloc]init];
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.numberFormatter.lenient = YES;
//    self.ACButton.layer.borderWidth = 1.0f;
//    self.ACButton.layer.borderColor = [UIColor blackColor].CGColor;
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;

}
-(void)viewDidAppear:(BOOL)animated{
    
}
-(void)viewWillAppear:(BOOL)animated{
//    NSLog(@"view will appear");
    for (UIButton * button in self.view.subviews){
        if ([button isKindOfClass:[UIButton class]]) {
            button.layer.borderWidth = 0.25f;
            button.layer.borderColor = [UIColor blackColor].CGColor;
        }
    }
}

-(void)viewDidLayoutSubviews{
    for (UIButton * button in self.view.subviews){
        if ([button isKindOfClass:[UIButton class]]) {
            if ([button.titleLabel.text isEqualToString:@"0"]){
                button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, button.frame.size.width / 2);
            }
        }
    }
    
}

-(void)resetButtonBorderWidths{
    for (UIButton * button in self.view.subviews){
        if ([button isKindOfClass:[UIButton class]]) {
            button.layer.borderWidth = 0.25f;
//            button.layer.borderColor = [UIColor blackColor].CGColor;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteButtonDidTouch:(UIButton *)sender {
    unsigned long length = self.resultLabel.text.length;
    if (self.viewState == CalculatorViewOperatorDidSelect || self.viewState == CalculatorViewEqualDidPress)
        return;
    if (length > 1){
        self.resultLabel.text = [self.resultLabel.text substringToIndex:length - 1];
    }
    else{
        self.resultLabel.text = @"0";
    }
}


- (IBAction)numberButtonDidTouch:(UIButton *)sender {
    [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    [self addCharacterToResultLabelText:sender.titleLabel.text];
    [self.calculatorFSMModel addCharacter];
    [self resetButtonBorderWidths];
    double textSize = [self.resultLabel.text sizeWithAttributes:nil].width;
    NSLog(@"%lf", textSize);
    if (self.resultLabel.frame.size.width <= textSize){
        NSLog(@"Overflow");
    }
    self.viewState = CalculatorViewEnteringNumber;
//    if (![sender.titleLabel.text isEqualToString:@"0"])
//        [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
}



- (IBAction)pointButtonDidTouch:(UIButton *)sender {
    [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
    if (self.viewState == CalculatorViewEqualDidPress || self.viewState == CalculatorViewOperatorDidSelect)
        self.resultLabel.text = @"0";
    if (! [self.resultLabel.text containsString:@"."]){
        [self addPointToResultLabel];
        [self.calculatorFSMModel addCharacter];
    }
    
    self.viewState = CalculatorViewEnteringNumber;
    [self resetButtonBorderWidths];
}
- (IBAction)negationButtonDidTouch:(UIButton *)sender {
    if ([self.resultLabel.text containsString:@"-"]) {
        self.resultLabel.text = [self.resultLabel.text substringFromIndex:1];
    }
    else{
        self.resultLabel.text = [@"-" stringByAppendingString:self.resultLabel.text];
    }
    [self.calculatorFSMModel addCharacter];
}

- (IBAction)addButtonDidTouch:(UIButton *)sender {
    NSNumber * number = [self.numberFormatter numberFromString:self.resultLabel.text];
    [self setResultLabelText:[self.calculatorFSMModel addOperator:ADD andLabelText:number]];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonBorderWidths];
    sender.layer.borderWidth = 2.0f;
}

- (IBAction)subtractButtonDidTouch:(UIButton *)sender {
    NSNumber * number = [self.numberFormatter numberFromString:self.resultLabel.text];
    [self setResultLabelText:[self.calculatorFSMModel addOperator:SUBTRACT andLabelText:number]];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonBorderWidths];
    sender.layer.borderWidth = 2.0f;
}

- (IBAction)multiplicationButtonDidTouch:(UIButton *)sender {
    NSNumber * number = [self.numberFormatter numberFromString:self.resultLabel.text];
    [self setResultLabelText:[self.calculatorFSMModel addOperator:MULTIPLY andLabelText:number]];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonBorderWidths];
        sender.layer.borderWidth = 2.0f;
}

- (IBAction)divisionButtonDidTouch:(UIButton *)sender {
    NSNumber * number = [self.numberFormatter numberFromString:self.resultLabel.text];
    [self  setResultLabelText:[self.calculatorFSMModel addOperator:DIVIDE andLabelText:number]];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonBorderWidths];
        sender.layer.borderWidth = 2.0f;
}

- (IBAction)equalButtonDidTouch:(UIButton *)sender {
    self.viewState = CalculatorViewEqualDidPress;
    NSNumber * number = [self.numberFormatter numberFromString:self.resultLabel.text];
    [self setResultLabelText:[self.calculatorFSMModel equalEvaluateWithLabelText:number]];
    [self resetButtonBorderWidths];
}


@end
