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
    else{
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:number];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSExpression * expression = [NSExpression expressionWithFormat:@"2+2="];
//    NSLog(@"%@", expression);
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
    if (![sender.titleLabel.text isEqualToString:@"0"])
        [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    
}

- (IBAction)pointButtonDidTouch:(UIButton *)sender {
    if (! [self.resultLabel.text containsString:@"."])
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:@"."];
}


@end
