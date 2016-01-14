//
//  CalculatorModel.m
//  iPhone Calculator
//
//  Created by SS D on 10/23/1394 AP.
//  Copyright © 1394 SS D. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel ()
@property CalculatorOperator lastOperator;
@property NSDecimalNumber * lastOperand;
@property NSDecimalNumber * result;
@property NSString * resultString;

-(void) checkString : (NSString *) string;
@end

@implementation CalculatorModel

-(NSString *)equalEval{
    NSLog(@"%@", self.lastOperand);
    [self eval];
    return self.resultString;
}

-(NSString *)equalEval:(NSString *) operand{
    [self addOperand:operand];
    NSLog(@"%@", self.lastOperand);
    [self eval];
    return self.resultString;
}

-(void)resetAll{
    self.result = nil;
    self.lastOperand = nil;
    self.lastOperator = N;
    self.resultString = nil;
}

//-(NSString *) resultString{
//    if (!_resultString || [_resultString isEqualToString:@""])
//        _resultString = [NSString stringWithFormat:@"%@", self.result];
//    return _resultString;
//}

- (id)init
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        [self resetAll];
    }
    return self;
}

-(void)addOperand:(NSString *)operand{
    
//    if ([self.result compare:@(0)] == NSOrderedSame){
    NSLog(@"%@", operand);
    if (! [CalculatorModel isValidNumber:operand]){
        [self checkString:operand];
        return;
    }
    if (!self.result){
        
        self.result = [NSDecimalNumber decimalNumberWithString:operand];
        self.resultString = [NSString stringWithFormat:@"%@", self.result];
    }
    self.lastOperand = [NSDecimalNumber decimalNumberWithString:operand];
    NSLog(@"%@", self.result);
}

-(NSString *)addOperator:(CalculatorOperator)calculatorOperator{
    if (self.lastOperator == N){
        self.lastOperator = calculatorOperator;
        self.resultString = [NSString stringWithFormat:@"%@", self.result];
    }
    else
    {
        
        [self eval];
        self.lastOperator = calculatorOperator;
    }
    NSLog(@"%@", self.result);
    NSLog(@"%@", self.resultString);
    return self.resultString;
}

-(void) checkString : (NSString *) number{
    if ([number isEqualToString:@""])
    {
        self.resultString = @"Empty Field";
        return;
    }
    //NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+(\\.[0-9]*)?" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:number options:0 range:NSMakeRange(0, number.length)];
    if (range.location != 0 || range.length != number.length){
        
        self.resultString = @"Wrong Format";
    }
}

+(BOOL)isValidNumber:(NSString*) number{
    if ([number isEqualToString:@""])
        return NO;
        //NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+(\\.[0-9]*)?" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:number options:0 range:NSMakeRange(0, number.length)];
    if (range.location != 0 || range.length != number.length){
        NSLog(@"Wrong format");
        return NO;
    }
    return YES;
}

-(void)eval{
    switch (self.lastOperator) {
        case ADD:
            //c = a + b;
            self.result = [self.result decimalNumberByAdding:self.lastOperand];
            //NSDecimalAdd(c, a, b, NSRoundPlain);
            break;
        case SUBTRACT:
            //c = a - b;
            self.result = [self.result decimalNumberBySubtracting:self.lastOperand];
            break;
        case MULTIPLY:
            //c = a * b;
            self.result = [self.result decimalNumberByMultiplyingBy:self.lastOperand];
            break;
        case DIVIDE:
            //c = a / b;
            if ([self.lastOperand compare:@(0)] == NSOrderedSame){
                self.resultString = @"Division By Zero";
                return; //@"Division By Zero";
            }
            self.result = [self.result decimalNumberByDividingBy:self.lastOperand];
            break;
        default:
            //            c = 0;
            break;
    }
    self.resultString = [NSString stringWithFormat:@"%@", self.result];
}

-(void) evalExpressionWithOperator:(CalculatorOperator)calculatorOperator secondOperand: (NSDecimalNumber*) operand{
//    NSDecimalNumber *c;
    
    
    switch (calculatorOperator) {
        case ADD:
            //c = a + b;
            self.result = [self.result decimalNumberByAdding:operand];
            //NSDecimalAdd(c, a, b, NSRoundPlain);
            break;
        case SUBTRACT:
            //c = a - b;
            self.result = [self.result decimalNumberBySubtracting:operand];
            break;
        case MULTIPLY:
            //c = a * b;
            self.result = [self.result decimalNumberByMultiplyingBy:operand];
            break;
        case DIVIDE:
            //c = a / b;
            if ([operand compare:@(0)] == NSOrderedSame){
                self.resultString = @"Division By Zero";
                return; //@"Division By Zero";
            }
            self.result = [self.result decimalNumberByDividingBy:operand];
            break;
        default:
//            c = 0;
            break;
    }
    self.resultString = [NSString stringWithFormat:@"%@", self.result];
}


//-(NSDecimalNumber *) calculateFirstOperand:(NSDecimalNumber *) a calculatorOperator:(CalculatorOperator)calculatorOperator secondOperator: (NSDecimalNumber*) b{
//    NSDecimalNumber *c;
//    
//    
//    switch (calculatorOperator) {
//        case ADD:
//            //c = a + b;
//            c = [a decimalNumberByAdding:b];
//            //NSDecimalAdd(c, a, b, NSRoundPlain);
//            break;
//        case SUBTRACT:
//            //c = a - b;
//            c = [a decimalNumberBySubtracting:b];
//            break;
//        case MULTIPLY:
//            //c = a * b;
//            c = [a decimalNumberByMultiplyingBy:b];
//            break;
//        case DIVIDE:
//            //c = a / b;
//            if ([b doubleValue] == 0){
//                NSLog(@"Division by zero");
//                return 0;
//            }
//            c = [a decimalNumberByDividingBy:b];
//            break;
//        default:
//            c = 0;
//            break;
//    }
//    return c;
//}

@end
