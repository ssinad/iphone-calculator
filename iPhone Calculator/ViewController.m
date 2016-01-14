//
//  ViewController.m
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
-(void)setResultLabelText:(NSString*) number;
@property BOOL sent;
@end

@implementation ViewController
- (IBAction)clearResultLabel:(UIButton *)sender {
    self.resultLabel.text = @"0";
    [self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
}
-(void)setResultLabelText:(NSString *)number{
    if ([self.resultLabel.text isEqualToString:@"0"]){
        self.resultLabel.text = number;
    }
    else if (self.sent){
        self.resultLabel.text = number;
        self.sent = NO;
    }
    else{
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:number];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSExpression * expression = [NSExpression expressionWithFormat:@"2.1+2"];
    NSNumber *result = [expression expressionValueWithObject:nil context:nil];
    NSLog(@"%@", result);
    self.calculatorModel = [[CalculatorModel alloc]init];
    self.sent = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)NumberButtonDidTouch:(id)sender {
//    if (! [sender isKindOfClass:[UIButton class]])
//        return;
//    [self setResultLabelText:((UIButton *) sender).titleLabel.text];
//}
- (IBAction)numberButtonDidTouch:(UIButton *)sender {
    [self setResultLabelText:sender.titleLabel.text];
//    if (![sender.titleLabel.text isEqualToString:@"0"])
//        [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
}

- (IBAction)pointButtonDidTouch:(UIButton *)sender {
    if (! [self.resultLabel.text containsString:@"."])
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:@"."];
}
- (IBAction)negationButtonDidTouch:(UIButton *)sender {
    if ([self.resultLabel.text containsString:@"-"]) {
        self.resultLabel.text = [self.resultLabel.text substringFromIndex:1];
    }
    else{
        self.resultLabel.text = [@"-" stringByAppendingString:self.resultLabel.text];
    }
}

- (IBAction)addButtonDidTouch:(UIButton *)sender {
    [self.calculatorModel addOperand:self.resultLabel.text];
    self.resultLabel.text = [self.calculatorModel addOperator:ADD];
    self.sent = YES;
}

- (IBAction)subtractButtonDidTouch:(UIButton *)sender {
    [self.calculatorModel addOperand:self.resultLabel.text];
    self.resultLabel.text = [self.calculatorModel addOperator:SUBTRACT];
    self.sent = YES;
}

- (IBAction)multiplicationButtonDidTouch:(UIButton *)sender {
    [self.calculatorModel addOperand:self.resultLabel.text];
    self.resultLabel.text = [self.calculatorModel addOperator:MULTIPLY];
    self.sent = YES;
}

- (IBAction)divisionButtonDidTouch:(UIButton *)sender {
    [self.calculatorModel addOperand:self.resultLabel.text];
    self.resultLabel.text = [self.calculatorModel addOperator:DIVIDE];
    self.sent = YES;
}

- (IBAction)equalButtonDidTouch:(UIButton *)sender {
    self.resultLabel.text = [self.calculatorModel equalEval:self.resultLabel.text];
}


@end
