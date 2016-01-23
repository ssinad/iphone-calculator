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
typedef NS_ENUM(NSUInteger, CalculatorViewState) {
    CalculatorViewInitial,
    CalculatorViewEnteringNumber,
    CalculatorViewOperatorDidSelect,
    CalculatorViewEqualDidPress
};
@property CalculatorViewState viewState;

-(void)resetButtonWidths;

@end

@implementation ViewController
- (IBAction)clearResultLabel:(UIButton *)sender {
    self.resultLabel.text = @"0";
    [self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
    [self.calculatorFSMModel resetAll];
    self.viewState = CalculatorViewInitial;
}
-(void)setResultLabelText:(NSString *)number{
    if ([self.resultLabel.text isEqualToString:@"0"] || self.viewState == CalculatorViewEqualDidPress || self.viewState == CalculatorViewOperatorDidSelect){
        self.resultLabel.text = number;
    }
    else{
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:number];
    }
    self.viewState = CalculatorViewEnteringNumber;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSExpression * expression = [NSExpression expressionWithFormat:@"2.1+2"];
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    NSLog(@"%@", result);
    self.viewState = CalculatorViewInitial;
    self.calculatorFSMModel = [[CalculatorFSMModel alloc]init];
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

-(void)resetButtonWidths{
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
    if (self.viewState == CalculatorViewOperatorDidSelect)
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
    [self setResultLabelText:sender.titleLabel.text];
    [self.calculatorFSMModel addCharacter:sender.titleLabel.text];
    [self resetButtonWidths];
//    if (![sender.titleLabel.text isEqualToString:@"0"])
//        [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
}

- (IBAction)pointButtonDidTouch:(UIButton *)sender {
    [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
    if (self.viewState == CalculatorViewEqualDidPress || self.viewState == CalculatorViewOperatorDidSelect)
        self.resultLabel.text = @"0";
    if (! [self.resultLabel.text containsString:@"."]){
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:@"."];
        [self.calculatorFSMModel addCharacter:sender.titleLabel.text];
    }
    
    self.viewState = CalculatorViewEnteringNumber;
    [self resetButtonWidths];
}
- (IBAction)negationButtonDidTouch:(UIButton *)sender {
    if ([self.resultLabel.text containsString:@"-"]) {
        self.resultLabel.text = [self.resultLabel.text substringFromIndex:1];
    }
    else{
        self.resultLabel.text = [@"-" stringByAppendingString:self.resultLabel.text];
    }
    [self.calculatorFSMModel addCharacter:@"-"];
}

- (IBAction)addButtonDidTouch:(UIButton *)sender {
    self.resultLabel.text = [self.calculatorFSMModel addOperator:ADD andLabelText:self.resultLabel.text];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonWidths];
    sender.layer.borderWidth = 2.0f;
}

- (IBAction)subtractButtonDidTouch:(UIButton *)sender {
        self.resultLabel.text = [self.calculatorFSMModel addOperator:SUBTRACT andLabelText:self.resultLabel.text];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonWidths];
    sender.layer.borderWidth = 2.0f;
}

- (IBAction)multiplicationButtonDidTouch:(UIButton *)sender {
        self.resultLabel.text = [self.calculatorFSMModel addOperator:MULTIPLY andLabelText:self.resultLabel.text];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonWidths];
        sender.layer.borderWidth = 2.0f;
}

- (IBAction)divisionButtonDidTouch:(UIButton *)sender {
        self.resultLabel.text = [self.calculatorFSMModel addOperator:DIVIDE andLabelText:self.resultLabel.text];
    self.viewState = CalculatorViewOperatorDidSelect;
    [self resetButtonWidths];
        sender.layer.borderWidth = 2.0f;
}

- (IBAction)equalButtonDidTouch:(UIButton *)sender {
    self.viewState = CalculatorViewEqualDidPress;
    self.resultLabel.text = [self.calculatorFSMModel equalEvaluateWithLabelText:self.resultLabel.text];
    [self resetButtonWidths];
}


@end
