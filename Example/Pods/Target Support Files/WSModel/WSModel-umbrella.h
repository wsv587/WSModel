#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+WSJsonToModel.h"
#import "NSObject+WSModel.h"
#import "WSBOOLTranslator.h"
#import "WSModel.h"
#import "WSModelProtocol.h"
#import "WSPropertyInfo.h"

FOUNDATION_EXPORT double WSModelVersionNumber;
FOUNDATION_EXPORT const unsigned char WSModelVersionString[];

