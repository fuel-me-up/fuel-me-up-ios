/**
* Created by Matthias Steeger on 28.11.13.
* Copyright (c) 2013 Maurício Hanika. All rights reserved.
*/

#import "FMUStyle.h"

////////////////////////////////////////////////////////////////////////////////
@interface FMUStyle ()

@end


////////////////////////////////////////////////////////////////////////////////
@implementation FMUStyle
{

}

+(void)styleFMUFilterLabel:(UILabel *) label {
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.textColor = [UIColor darkGrayColor];
}

@end