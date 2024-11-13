// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// A protocol that defines an element that can be styled using a `StyleConfiguration`.
///
/// Types conforming to `Styler` can be modified using chainable
/// dot-syntax style modifications.
///
/// ## Example
/// ```swift
/// let style = CustomLabel.custom
///     .emphasis(.strong)
///     .size(.large)
///     .iconOnly
/// ```
///



public protocol Stylable {
  associatedtype StyleConfiguration
  var config: StyleConfiguration { get set }
  func modified(_ transform: (inout StyleConfiguration) -> Void) -> Self
}

public protocol StyleConfiguration {
  static var `default`: Self { get }
}

public extension Stylable {
  
  /// Creates a new instance with modified configuration.
  ///
  /// This method is the foundation for the chainable modification pattern.
  ///
  /// - Parameter transform: A closure that modifies the configuration
  /// - Returns: A new instance with the modified configuration
  ///
  func modified(_ transform: (inout StyleConfiguration) -> Void) -> Self {
    var new = self
    transform(&new.config)
    return new
  }
  
  /// Pass in a whole specific config, from somewhere else, no changes
  //  func with(_ newConfig: StyleConfiguration) -> Self {
  //    modified { $0 = newConfig }
  //  }
  
  func with(_ config: StyleConfiguration) -> Self {
    modified { $0 = config }
  }
}



//
//public extension View where Self: Stylable {
//  
//  func stylable<S>(_ config: S) -> some View where S == Self.StyleConfiguration {
//    return self.modified { $0 = config }
//  }
//}

public extension View {
  func withStyle(_ style: Self.StyleConfiguration) -> some View where Self: Stylable, Self.StyleConfiguration: StyleConfiguration {
    var copy = self
    copy.config = style
    return copy
  }
}

//public struct StylerModifier: ViewModifier {
//  
//  public func body(content: Content) -> some View {
//    content
//  }
//}
