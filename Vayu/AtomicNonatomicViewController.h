//
//  AtomicNonatomicViewController.h
//  Vayu
//
//  Created by Akhilesh Rathor on 02/09/25.
//
/*
 Q. 64) what is Atomic and nonAtomic in objective - C ?
 Ans.
 
 Atomic:-
 
* Default behavior if you don’t specify otherwise.
* Ensures thread-safe access to the property.
* The getter and setter are implemented to guarantee that a complete value is always returned or set, even if multiple threads access the property simultaneously.
* Achieved by adding a lock or synchronization internally.
* Slower performance due to this overhead.
* Does not guarantee full thread safety for complex operations, only for the getter/setter.
 
 NonAtomic:-
 
 * Does not guarantee thread safety.
 * Getter and setter are simple and faster.
 * No locking or synchronization is used.
 * Use when you don’t need thread safety or when you manage synchronization yourself.
 * Commonly used in iOS development for better performance.
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AtomicNonatomicViewController)

@property (atomic, strong) NSString *name;    // Thread-safe getter/setter (default)
@property (nonatomic, strong) NSString *title; // Faster, no thread safety

@end

NS_ASSUME_NONNULL_END
