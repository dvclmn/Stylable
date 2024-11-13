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


/// # Configuration
///
/// What is really required of a config, and it's contents?
///
/// What purpose will the properties within a `Configuration`
/// serve for the receiving View?
///
/// - Define modifications to the appearance and behaviour of the View
/// - As an alternative to filling in the parameters in the initialiser
/// - Keeps the initialiser clean, and dedicated to more important things?
/// - Can be composed/chained, using dot syntax, in any order
///
/// Before:
/// `Argument 'x' must precede argument 'y'`
///
///
/// # `Stylable` View
///
/// Recieves:
/// - `Stylable` protocol conformance
/// - `typealias StyleConfiguration = ExampleConfiguration`
/// - `var config = ExampleConfiguration()`. Might consider defaults here?
///
/// The user will then reference `config` when applying values to SwiftUI modifiers, e.g.
/// `.background(config.backgroundColour)`
///
///
///
/// # Usage
///
/// - Define a modifier as an 'entry point', to then chain modifications together
/// - These modifications are based directly on the properties defined in the `Configuration`
///
public protocol Stylable {
  associatedtype Config: Sendable
  
  /// Views seem able to easily infer the `associatedtype`, from the below
  var config: Config { get set }

}

/// This does *not* seem to work, if I place the below `where` clause on the extension.
///
/// It needs to be placed on the `withStyle` function return type.
///
public extension View {
  func withStyle(_ style: Self.Config) -> some View where Self: Stylable {
    var copy = self
    copy.config = style
    return copy
  }
}
