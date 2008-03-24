//
//  GPGMailPatching.m
//  GPGMail
//
//  Created by Dave Lopper on Sat Sep 20 2004.
//

/*
 * Copyright (c) 2000-2008, St�phane Corth�sy <stephane at sente.ch>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of St�phane Corth�sy nor the names of GPGMail
 *       contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY ST�PHANE CORTH�SY AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL ST�PHANE CORTH�SY AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "GPGMailPatching.h"


IMP GPGMail_ReplaceImpOfClassSelectorOfClassWithImpOfClassSelectorOfClass(SEL aSelector, Class aClass, SEL newSelector, Class newClass)
{
#ifdef LEOPARD
    Method	aMethod, newMethod;
    IMP		anIMP, newIMP;
    
    aMethod = class_getClassMethod(aClass, aSelector);
    if(aMethod == NULL)
        return NULL;
    anIMP = method_getImplementation(aMethod);
	
    newMethod = class_getClassMethod(newClass, newSelector);
    if(newMethod == NULL)
        return NULL;
    newIMP = method_getImplementation(newMethod);

    method_setImplementation(aMethod, newIMP);
	NSCAssert(method_getImplementation(aMethod) == newIMP, @"Replacement failed!");
	
    return anIMP;
#else
    Method	aMethod, newMethod;
    IMP		anIMP, newIMP;
    
    aMethod = class_getClassMethod(aClass, aSelector);
    if(aMethod == NULL)
        return NULL;
    anIMP = aMethod->method_imp;
    
    newMethod = class_getClassMethod(newClass, newSelector);
    if(newMethod == NULL)
        return NULL;
    newIMP = newMethod->method_imp;
    
    aMethod->method_imp = newIMP;
    return anIMP;
#endif
}

IMP GPGMail_ReplaceImpOfInstanceSelectorOfClassWithImpOfInstanceSelectorOfClass(SEL aSelector, Class aClass, SEL newSelector, Class newClass)
{
#ifdef LEOPARD
    Method	aMethod, newMethod;
    IMP		anIMP, newIMP;
    
    aMethod = class_getInstanceMethod(aClass, aSelector);
    if(aMethod == NULL)
        return NULL;
    anIMP = method_getImplementation(aMethod);
	
    newMethod = class_getInstanceMethod(newClass, newSelector);
    if(newMethod == NULL)
        return NULL;
    newIMP = method_getImplementation(newMethod);
	
    method_setImplementation(aMethod, newIMP);
	NSCAssert(method_getImplementation(aMethod) == newIMP, @"Replacement failed!");
	
    return anIMP;
#else
    Method	aMethod, newMethod;
    IMP		anIMP, newIMP;
    
    aMethod = class_getInstanceMethod(aClass, aSelector);
    if(aMethod == NULL)
        return NULL;
    anIMP = aMethod->method_imp;
    
    newMethod = class_getInstanceMethod(newClass, newSelector);
    if(newMethod == NULL)
        return NULL;
    newIMP = newMethod->method_imp;
    
    aMethod->method_imp = newIMP;
    return anIMP;
#endif
}

@implementation NSObject(GPGMailPatching)

- (void) gpgSetClass:(Class)class
{
    isa = class;
}

@end

