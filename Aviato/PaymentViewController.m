//
//  PaymentViewController.m
//  Aviato
//
//  Created by Michael Vinci on 4/17/15.
//  Copyright (c) 2015 TeamAviato. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

- (IBAction)openPayPal:(id)sender;

@end


@implementation PaymentViewController {
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

/*!
 *	dismisses keyboard upon use of [return] key
 *
 *	@param sender Sender is USer
 */
- (IBAction)textFieldReturn:(id)sender {
	[sender resignFirstResponder];
}

- (NSString *)urlEncode:(NSString *)rawStr {
	NSString *encodedStr = (NSString *)CFBridgingRelease(
	        CFURLCreateStringByAddingPercentEscapes(
	            NULL,
	            (__bridge CFStringRef)rawStr,
	            NULL,
	            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
	            kCFStringEncodingUTF8));
	return encodedStr;
}

/*!
 *	takes data from invoice form and submits it as JSON data to the PayPal Here app for processing
 *
 *	@param sender Sender is User
 */
- (void)openPayPal:(id)sender {
	NSMutableDictionary *itemListDictionary = [NSMutableDictionary dictionary];
	NSMutableArray *itemListArray = [NSMutableArray arrayWithCapacity:1];
	NSMutableDictionary *item = [NSMutableDictionary dictionary];


	[item setObject:@"0" forKey:@"taxRate"];
	[item setObject:_invoiceName.text forKey:@"name"];
	[item setObject:_invoiceDesc.text forKey:@"description"];
	[item setObject:_invoiceAmount.text forKey:@"unitPrice"];
	[item setObject:@"Tax" forKey:@"taxName"];
	[item setObject:@"1" forKey:@"quantity"];

	[itemListArray addObject:item];
	[itemListDictionary setObject:itemListArray forKey:@"item"];

	NSMutableDictionary *invoiceObj = [NSMutableDictionary dictionary];

	[invoiceObj setObject:@"DueOnReceipt" forKey:@"paymentTerms"];
	[invoiceObj setObject:@"0" forKey:@"discountPercent"];
	[invoiceObj setObject:@"USD" forKey:@"currencyCode"];
	[invoiceObj setObject:@"9876" forKey:@"number"];
	[invoiceObj setObject:_invoiceEmail.text forKey:@"payerEmail"];
	[invoiceObj setObject:itemListDictionary forKey:@"itemList"];

	NSError *e = nil;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:invoiceObj options:0 error:&e];
	NSString *jsonDataStr = [[NSString alloc]initWithData:jsonData encoding:1];
	NSString *encodedInvoiceJsonString = [self urlEncode:jsonDataStr];
	NSString *encodedAcceptedPaymentTypes = [self urlEncode:@"cash,card,paypal"];
	NSString *returnUrl = @"myapp://my-return-handler?{result}Type={Type}&InvoiceId={InvoiceId}&Tip={Tip}&Email={Email}&TxId={TxId}";
	NSString *encodedReturnUrl = [self urlEncode:returnUrl];
	NSString *pphUrlString = [NSString stringWithFormat:@"paypalhere://takePayment?accepted=%@&returnUrl=%@&invoice=%@&step=choosePayment",
	                          encodedAcceptedPaymentTypes, encodedReturnUrl, encodedInvoiceJsonString];
	NSLog(@"PayPal Here URL = %@", pphUrlString);

	NSURL *pphUrl = [NSURL URLWithString:pphUrlString];
	UIApplication *ourApplication = [UIApplication sharedApplication];

	if ([ourApplication canOpenURL:pphUrl]) {
		[ourApplication openURL:pphUrl];
	}
	else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PayPal Here Not Found"
		                                                    message:@"The PayPal Here App is not installed. It must be installed to take payment."
		                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}
}

@end
