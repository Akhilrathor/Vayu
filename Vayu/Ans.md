1) what is difference between subclass & extension?
74) what is extension?

In iOS Swift, subclass and extension are both used to add or change functionality, but they work differently.
👉 Subclass:
Creates a new class that inherits from another class.
You can override methods, properties, and add new ones.
Used when you want to modify or customize behavior.
Example:
class Animal {
    func sound() {
        print("Some sound")
    }
}

class Dog: Animal {
    override func sound() {
        print("Bark")
    }
}

👉 Extension:
Adds functionality to an existing class, struct, or enum without inheritance.
Cannot override existing methods.
Good for organizing code or adding helper functions.
Example:
extension String {
    func isEmail() -> Bool {
        return self.contains("@")
    }
}

Main Difference:
Subclass = Inherit and customize
Extension = Add functionality without changing the original class
Would you like a use-case based question example for this topic?

An extension in Swift is a feature that allows you to add new functionality (methods, computed properties, initializers, etc.) to an existing class, structure, enumeration, or protocol without modifying or subclassing the original source code. It promotes code reusability, organization, and adherence to the Open-Closed Principle. In Objective-C, the equivalent is called a category, which serves a similar purpose but is limited to classes.


Example:
extension Int {
    func squared() -> Int {
        return self * self
    }

    var isEven: Bool {
        return self % 2 == 0
    }
}

let number = 8
print(number.squared()) // Output: 64
print(number.isEven)    // Output: true



1. Differences between Swift extensions and Objective-C categories:
Swift extensions work at compile-time, support structs/enums/protocols (not just classes), and allow computed properties/subscripts. Objective-C categories are runtime-based, limited to classes, and can lead to method conflicts if not careful. Extensions are safer for modern SwiftUI/Combine apps, while categories are useful for extending legacy Objective-C code without recompiling.

2. Adding stored properties to extensions:
No, you cannot add stored properties directly to extensions as they don't own the type's storage. Workarounds include using a private wrapper class with the property and an extension method to access it, or associated objects via objc_setAssociatedObject (runtime hack, less recommended in pure Swift). For example, in networking, use a computed property that fetches from UserDefaults.

3. Extensions in protocol-oriented programming:
Extensions provide default implementations for protocol methods, encouraging composition over inheritance. Example: Extend Equatable for a custom Point struct to auto-generate == operator. This is powerful in SwiftUI for reusable view traits or in Combine for custom publishers.

4. Pitfalls and best practices:
Pitfalls: Over-extending system types can cause naming conflicts or bloat; extensions aren't discoverable like subclasses. Best practices: Use one extension per feature (e.g., String+Validation), document them, avoid in tight loops for performance, and prefer them for protocol conformance in team projects to keep code modular and testable.

5. Extensions with Swift Concurrency:
You can add async methods to existing types, e.g., extending URLSession with func loadAsync(url: URL) async throws -> Data. This bridges legacy networking to async/await in iOS 17+, improving readability without rewriting APIs. Ensure error handling with throws and test for cancellation.





2)  what is difference between subclass SOAP and REST?(API)

| Category            | SOAP                                                            | REST                                                                       |
|---------------------|-----------------------------------------------------------------|----------------------------------------------------------------------------|
| **Stands for**      | Simple Object Access Protocol                                   | Representational State Transfer                                            |
| **What is it?**     | SOAP is a protocol for communication between applications       | REST is an architecture style for designing communication             |
| **Design**          | SOAP API exposes the operation.                                 | REST API exposes the data.                                                 |
| **Transport Protocol** | SOAP is independent and can work with any transport protocol.| REST works only with HTTPS.                                                |
| **Data format**     | SOAP supports only XML data exchange.                           | REST supports XML, JSON, plain text.                                  |
| **Performance**     | SOAP messages are larger, which makes communication slower.     | REST has faster performance due to smaller messages and caching.      |
| **Scalability**     | SOAP is difficult to scale. The server maintains state by storing all previous messages. | REST is easy to scale. It’s stateless, so every message is processed independently. |
| **Security**        | SOAP supports encryption with additional overheads.             | REST supports encryption without affecting performance.               |
| **Use case**        | SOAP is useful in legacy applications and private APIs.         | REST is useful in modern applications and public APIs.                |


3) what is idempotency?

Ans. Idempotency means making the same API request multiple times will have the same result – no side effects after the first call.
It ensures safe retries in case of network failure.


5) singleton pattern drawback?
Ans. The main drawback of Singleton is that it introduces global state, which can:
Make unit testing hard – because the singleton is shared and hard to mock.
Tight coupling – classes become dependent on the singleton directly.
Hidden dependencies – makes code less flexible and harder to manage.

6) what is typecasting in Swift?
Ans. Typecasting is used when we have an object of one type (usually a superclass or Any) and we want to check or convert it to a more specific type (like a subclass).
Swift provides:


Example: 

let views: [UIView] = [UILabel(), UIButton(), UIView()]

for view in views {
    if let label = view as? UILabel {
        label.text = "Hello"
    } else if view is UIButton {
        print("It's a button")
    }
}


as? UILabel checks if the view is a UILabel, and if yes, safely casts it.
view is UIButton checks if it's a UIButton.


❌ Why avoid as!?

let label = view as! UILabel  // ❌ Crashes if it's not a UILabel

Use as? unless you're 100% sure about the type.


7) What is @autoclosure?
Ans. @autoclosure is a Swift attribute that automatically wraps an expression into a closure.
It lets us pass an expression without writing {}, making function calls cleaner.

✅ Example:

func log(_ message: @autoclosure () -> String) {
    print("Log:", message())
}

log("Something went wrong") // ✅ No need to write: { return "Something..." }

Here, "Something went wrong" is automatically converted into a closure.

8)what is property wrapper in Swift?
Ans. A property wrapper in Swift is a reusable layer of code that adds custom logic (like validation, formatting, or storage behavior) to a property using the @propertyWrapper attribute, while keeping the property access simple and clean.
It helps separate logic from property declarations, making the code more modular and readable.


❌ Common way (with extension):

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let name = "  John  "
print(name.trimmed) // Output: "John"

"Using an extension is useful, but I have to manually call .trimmed every time. If I don’t want to give that control to every string and instead want to apply it only where needed, I use a property wrapper. That way, I decide which String properties should auto-trim."


✅ Better way (using Property Wrapper – Auto Trim String):

@propertyWrapper
struct AutoTrimmed {
    private var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.trimmingCharacters(in: .whitespacesAndNewlines) }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

✅ Step 2: Use it in your model

struct User {
    @AutoTrimmed var name: String
}

var user = User(name: "   Alice   ")
print(user.name) // Output: "Alice"

Final line for interviewer:
Instead of extending String and calling custom functions, I use property wrappers to give automatic behavior (like trimming, capitalizing, clamping) to any property, making my app smarter and the code cleaner.

9) what is @MainActor?
Ans.  @MainActor is a Swift Concurrency attribute that tells the compiler a piece of code should always run on the main thread — usually for UI updates.

✅ Example:

@MainActor
class ViewModel {
    func updateUI() {
        // Always runs on main thread
    }
}

Or:

@MainActor func showAlert() {
    // Runs on main thread, safe for UIKit/SwiftUI
}


Final line for interviewer:
I use @MainActor to make sure all UI-related code runs on the main thread, especially in SwiftUI or async code with view models.


10) what tools do you use for profiling & optimising an ios application?

Ans. For profiling and optimizing an iOS app, I mainly use Xcode Instruments and Xcode's built-in tools.

🔧 Tools I use:
Instruments (in Xcode)
Time Profiler → to check CPU usage
Leaks → to find memory leaks
Allocations → to track memory usage
Core Animation → to analyze rendering performance and dropped frames
Energy Log → to reduce battery usage
Xcode Debug Navigator
Real-time memory, CPU, and energy usage while running the app
Console & Logs
For tracking runtime issues and checking background thread operations
In-App Debug Tools
os_signpost, print, or custom logging to measure execution time

Final line for interviewer:
I use Xcode Instruments for deep performance analysis, especially Time Profiler and Leaks, and combine it with Debug Navigator for real-time insights during development.

11) what is designed patterns and explain all?
Ans. Design patterns are reusable solutions to common problems that arise in software design. They are not specific code, but rather general blueprints for solving recurring design challenges, acting as a shared language for developers to communicate and collaborate effectively. 

Design patterns are broadly categorized into three main types:

Creational Design Pattern
Structural Design Pattern
Behavioural Design Pattern

Creational Design Pattern:  focus on the process of object creation or problems related to object creation. They help in making a system independent of how its objects are created, composed and represented.
    
Types of Creational Design Patterns:

a )  Factory Method is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

💡 Problem:

Imagine you're building a delivery app. Initially, your app only supports bike delivery, so all logic is tied to a BikeDelivery class.
Later, you need to add car and drone deliveries. If your code is tightly coupled to the BikeDelivery class, you'll need to modify everywhere — which breaks Open/Closed Principle.

✅ Solution:

Instead of creating delivery classes directly with new or init(), we define a factory method that creates objects based on the delivery type.
This allows us to:
Create objects without exposing the instantiation logic
Use polymorphism to return the correct object
Keep the client code clean and scalable


🧑‍💻 Swift Code Example:

// Product
protocol Transport {
    func deliver()
}

// Concrete Products
class Bike: Transport {
    func deliver() {
        print("Delivering by Bike 🚴‍♂️")
    }
}

class Car: Transport {
    func deliver() {
        print("Delivering by Car 🚗")
    }
}

class Drone: Transport {
    func deliver() {
        print("Delivering by Drone 🚁")
    }
}

// Creator
protocol DeliveryCreator {
    func createTransport() -> Transport
}

// Concrete Creators
class BikeDeliveryCreator: DeliveryCreator {
    func createTransport() -> Transport {
        return Bike()
    }
}

class CarDeliveryCreator: DeliveryCreator {
    func createTransport() -> Transport {
        return Car()
    }
}

class DroneDeliveryCreator: DeliveryCreator {
    func createTransport() -> Transport {
        return Drone()
    }
}

✅ Usage:

func deliverOrder(using creator: DeliveryCreator) {
    let transport = creator.createTransport()
    transport.deliver()
}

// App logic
let creator = DroneDeliveryCreator()
deliverOrder(using: creator) // Output: Delivering by Drone 🚁

"Factory Method lets us create objects in a flexible and decoupled way, allowing us to extend logic without touching existing code.”


b ) Abstract Factory:- Abstract Factory is a creational design pattern that lets you produce families of related objects without specifying their concrete classes.

Problem:

Imagine you're building a theming system for an iOS app that supports Light Mode and Dark Mode.
Each mode uses:
A different Button
A different Label

Intent:
Create a factory for each theme. Each factory will return theme-specific components, but your app code won’t know which concrete class is being used.

1. Abstract Product Protocols:

protocol AppButton {
    func render()
}

protocol AppLabel {
    func display()
}

2. Concrete Products:

class LightButton: AppButton {
    func render() {
        print("Light Button ☀️")
    }
}

class DarkButton: AppButton {
    func render() {
        print("Dark Button 🌙")
    }
}

class LightLabel: AppLabel {
    func display() {
        print("Light Label ☀️")
    }
}

class DarkLabel: AppLabel {
    func display() {
        print("Dark Label 🌙")
    }
}

3. Abstract Factory Protocol:

protocol UIThemeFactory {
    func createButton() -> AppButton
    func createLabel() -> AppLabel
}

4. Concrete Factories:

class LightThemeFactory: UIThemeFactory {
    func createButton() -> AppButton {
        return LightButton()
    }
    
    func createLabel() -> AppLabel {
        return LightLabel()
    }
}

class DarkThemeFactory: UIThemeFactory {
    func createButton() -> AppButton {
        return DarkButton()
    }
    
    func createLabel() -> AppLabel {
        return DarkLabel()
    }
}


5. Client Code:

func setupUI(using factory: UIThemeFactory) {
    let button = factory.createButton()
    let label = factory.createLabel()
    
    button.render()
    label.display()
}

Usage:

let factory = DarkThemeFactory()
setupUI(using: factory)

Output:

Dark Button 🌙
Dark Label 🌙


Interview Summary Answer:

Abstract Factory lets us create families of related objects like themed buttons and labels. I used it in theming where Light and Dark modes had their own factory to supply correct UI components without repeating conditional logic.


c) Builder Pattern:-

Builder is a creational design pattern that lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code.

Problem:

Imagine you're building a screen where users can configure a custom Burger Order in a food delivery app. The burger may have:
Bun type
Patty type
Sauce
Extra toppings
Writing long initializers like this:

Burger(bun: "Wheat", patty: "Chicken", sauce: "Mayo", extras: ["Cheese", "Lettuce"])

...can get messy and hard to read/extend.

Intent:

Use Builder to build complex objects step by step, without using a long init() and keeping the code readable and scalable.

1. Product (Burger):

struct Burger {
    var bun: String?
    var patty: String?
    var sauce: String?
    var extras: [String] = []
    
    func describe() {
        print("Burger with \(bun ?? "no bun"), \(patty ?? "no patty"), sauce: \(sauce ?? "none"), extras: \(extras.joined(separator: ", "))")
    }
}

2. Builder:

class BurgerBuilder {
    private var burger = Burger()
    
    func setBun(_ type: String) -> BurgerBuilder {
        burger.bun = type
        return self
    }
    
    func setPatty(_ type: String) -> BurgerBuilder {
        burger.patty = type
        return self
    }
    
    func addSauce(_ sauce: String) -> BurgerBuilder {
        burger.sauce = sauce
        return self
    }
    
    func addExtras(_ extras: [String]) -> BurgerBuilder {
        burger.extras.append(contentsOf: extras)
        return self
    }
    
    func build() -> Burger {
        return burger
    }
}

3. Client Code:

let burger = BurgerBuilder()
    .setBun("Wheat")
    .setPatty("Chicken")
    .addSauce("Mayo")
    .addExtras(["Cheese", "Lettuce"])
    .build()

burger.describe()


Output:

Burger with Wheat, Chicken, sauce: Mayo, extras: Cheese, Lettuce


Interview Summary Answer:
Builder is used to create complex objects step by step. It’s useful when an object needs many parts or optional configuration. I used it in a food-ordering module to build a customizable burger with chaining methods like setBun, setPatty, etc.


d) Prototype Pattern:-

Prototype is a creational design pattern that lets you copy existing objects without making your code dependent on their classes.

🧩 Problem:

Imagine you have a complex UserProfile object that takes time to create or load (e.g., from disk or network), and you want to create a copy of it (like for editing, undo, or testing) without affecting the original.

🎯 Intent:

Use Prototype when creating an object is expensive or complicated, and you need to clone it efficiently.

1. Prototype Protocol:

protocol Clonable {
    func clone() -> Self
}

2. Concrete Class:

class UserProfile: Clonable {
    var name: String
    var age: Int
    var hobbies: [String]

    init(name: String, age: Int, hobbies: [String]) {
        self.name = name
        self.age = age
        self.hobbies = hobbies
    }

    func clone() -> Self {
        return UserProfile(name: self.name, age: self.age, hobbies: self.hobbies) as! Self
    }
}


3. Client Code:

let originalProfile = UserProfile(name: "John", age: 28, hobbies: ["iOS", "Cricket"])
let copiedProfile = originalProfile.clone()

copiedProfile.name = "Jane"
copiedProfile.hobbies.append("Travel")

print("Original: \(originalProfile.name), hobbies: \(originalProfile.hobbies)")
print("Copied: \(copiedProfile.name), hobbies: \(copiedProfile.hobbies)")


🧾 Output:

Original: John, hobbies: ["iOS", "Cricket"]
Copied: Jane, hobbies: ["iOS", "Cricket", "Travel"]

🎯 Interview Summary Answer:

Prototype is used to clone objects instead of creating new ones from scratch. I use it when object creation is expensive or needs to be duplicated (e.g., deep copying models like UserProfile before editing). We implement a clone() method for that.

e) Singleton Pattern:-

Singleton is a creational design pattern that lets you ensure that a class has only one instance, while providing a global access point to this instance.

🎯 Real-Life Analogy:
Think of the App Settings or UserDefaults in iOS. There's only one shared instance used across the entire app — you don't want multiple conflicting copies.

class Logger {
    static let shared = Logger() // shared single instance

    private init() {} // restrict external initialization

    func log(_ message: String) {
        print("Log: \(message)")
    }
}

Usage:

Logger.shared.log("App started")
Logger.shared.log("User tapped button")


❌ Without Singleton (Problem):

If you create multiple Logger() instances, logs could go to different places or conflict. That’s why we make the initializer private.


📝 Interview Summary Answer:

Singleton ensures only one instance exists, useful for shared services like Logger, NetworkManager, or UserDefaults. In Swift, we use a static let shared and make the initializer private. It helps manage shared state, but it's hard to test and mock in unit testing.


Structural Design Patterns:

Structural design patterns explain how to assemble objects and classes into larger structures, while keeping these structures flexible and efficient.

a) Adapter Pattern:-

Adapter is a structural design pattern that lets objects with incompatible interfaces work together by converting one interface into another.

🎯 Real-Life Analogy:
Imagine you have a laptop charger with a US plug, but you're in Europe. You can't use it directly, so you use a power adapter to convert the plug. 💡 The charger and socket are incompatible, but the adapter makes them work together.


✅ Swift Example:
🎯 Scenario:
You have a NewAnalytics system, but much of your codebase uses an old trackEvent(name:) API.
🎯 Goal:
Adapt NewAnalytics to fit the old interface.


🔷 1. New Class (incompatible):

class NewAnalytics {
    func send(eventName: String) {
        print("Sending new event: \(eventName)")
    }
}

🔶 2. Target Protocol (expected interface):

protocol OldAnalytics {
    func trackEvent(name: String)
}

🧩 3. Adapter:

class AnalyticsAdapter: OldAnalytics {
    private let newAnalytics = NewAnalytics()

    func trackEvent(name: String) {
        newAnalytics.send(eventName: name)
    }
}

🧪 Usage:

let analytics: OldAnalytics = AnalyticsAdapter()
analytics.trackEvent(name: "AppLaunched")

📝 Interview Summary Answer:

Adapter pattern is used to make two incompatible interfaces work together. In iOS, it's useful when integrating new SDKs into existing code. We create an adapter that translates the existing interface to the new one without changing either. This promotes code reusability and flexibility.


b) Bridge Pattern:-

Bridge is a structural pattern that decouples an abstraction from its implementation so the two can vary independently.

🎯 Real-Life Analogy:
Imagine you have a TV remote.
The remote is the abstraction (you press buttons).
The TV (Sony, LG, Samsung) is the implementation.
The same remote should work with different brands (TVs). So, you bridge the remote and the TV — they can change independently.


✅ Swift Example

🔹 Abstraction:

protocol Remote {
    func power()
}


🔹 Implementor:

protocol TV {
    func turnOn()
    func turnOff()
}

🔸 Concrete Implementations:

class SonyTV: TV {
    func turnOn() { print("Sony TV is ON") }
    func turnOff() { print("Sony TV is OFF") }
}

class LGTV: TV {
    func turnOn() { print("LG TV is ON") }
    func turnOff() { print("LG TV is OFF") }
}

🔹 Bridge – Refined Abstraction:

class BasicRemote: Remote {
    private var device: TV

    init(device: TV) {
        self.device = device
    }

    func power() {
        print("Remote: toggle power")
        device.turnOn()
    }
}


🧪 Usage:

let sony = SonyTV()
let remote = BasicRemote(device: sony)
remote.power() // Output: Sony TV is ON


📝 Interview Summary Answer:

Bridge pattern is used to separate abstraction (like a remote) from its implementation (like a TV). In iOS, it’s useful when building cross-platform components or when you want to avoid tight coupling between logic and platform-specific code. This way both abstraction and implementation can evolve independently.


C) Composite Pattern:-

Composite is a structural design pattern that lets you treat individual objects and groups of objects in the same way.

🎯 Real-Life Analogy:
Think of a folder (directory) on your computer.
A folder can contain files or other folders.
You can perform the same operation on both (like delete, move, etc.).
So both File and Folder conform to a common interface — and that’s the Composite pattern.

✅ Swift Example

🔹 Component Protocol:

protocol FileSystemItem {
    func display(indentation: String)
}

🔸 Leaf (File):

class File: FileSystemItem {
    private let name: String

    init(name: String) {
        self.name = name
    }

    func display(indentation: String) {
        print("\(indentation)- File: \(name)")
    }
}


🔸 Composite (Folder):

class Folder: FileSystemItem {
    private let name: String
    private var items: [FileSystemItem] = []

    init(name: String) {
        self.name = name
    }

    func add(item: FileSystemItem) {
        items.append(item)
    }

    func display(indentation: String = "") {
        print("\(indentation)+ Folder: \(name)")
        for item in items {
            item.display(indentation: indentation + "  ")
        }
    }
}

🧪 Usage:

let mainFolder = Folder(name: "Projects")
let file1 = File(name: "README.md")
let file2 = File(name: "main.swift")

let subFolder = Folder(name: "Sources")
subFolder.add(item: File(name: "AppDelegate.swift"))
subFolder.add(item: File(name: "ViewController.swift"))

mainFolder.add(item: file1)
mainFolder.add(item: file2)
mainFolder.add(item: subFolder)

mainFolder.display()


Output:

+ Folder: Projects
  - File: README.md
  - File: main.swift
  + Folder: Sources
    - File: AppDelegate.swift
    - File: ViewController.swift


📝 Interview Summary Answer:


Composite pattern lets us treat individual objects (like File) and compositions of objects (like Folder) the same way. In iOS, it’s helpful when building tree-like structures like file managers or nested views.


d) Decorator Pattern:-

The Decorator pattern lets you add new behaviors or responsibilities to an object dynamically without altering its structure.

🎯 Real-Life Analogy:
Think of a coffee at a café:
Base: Coffee ☕️
Add-ons: Milk, Sugar, Whipped Cream Each add-on decorates the coffee without modifying the original class.

✅ Swift Example

🔹 Step 1: Define the Component

protocol Coffee {
    func cost() -> Double
    func description() -> String
}

🔹 Step 2: Concrete Component

class BasicCoffee: Coffee {
    func cost() -> Double { return 2.0 }
    func description() -> String { return "Basic Coffee" }
}

🔹 Step 3: Base Decorator

class CoffeeDecorator: Coffee {
    private let decoratedCoffee: Coffee

    init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }

    func cost() -> Double {
        return decoratedCoffee.cost()
    }

    func description() -> String {
        return decoratedCoffee.description()
    }
}


🔹 Step 4: Concrete Decorators

class MilkDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 0.5
    }

    override func description() -> String {
        return super.description() + ", Milk"
    }
}

class SugarDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 0.2
    }

    override func description() -> String {
        return super.description() + ", Sugar"
    }
}


🧪 Usage

var myCoffee: Coffee = BasicCoffee()
myCoffee = MilkDecorator(decoratedCoffee: myCoffee)
myCoffee = SugarDecorator(decoratedCoffee: myCoffee)

print(myCoffee.description())  // Output: Basic Coffee, Milk, Sugar
print(myCoffee.cost())         // Output: 2.7


📝 Interview Summary Answer:

Decorator pattern allows adding functionality to objects at runtime without changing their original code. In iOS, I can use it to decorate UIViews with borders, shadows, etc., or to build flexible systems like adding behaviors to analytics or logging.


e ) Facade Design Pattern:-


Facade pattern provides a simple interface to a complex subsystem. It hides the complexity and exposes only what’s necessary to the client.

🎯 Real-Life Analogy:
Imagine you're ordering a pizza 🍕:
You call a restaurant.
You don’t care about dough prep, oven temperature, or ingredients.
The restaurant is the Facade—it simplifies access to the entire kitchen (subsystem).


✅ Swift iOS Example: Media Player
Let’s say you want to play a video. Internally, you need to:
Load the file,
Decode it,
Start audio and video.
This is complex, so you create a Facade:


🔹 Subsystems (Internal Complex Classes)

class VideoDecoder {
    func decodeVideo(file: String) {
        print("Decoding video from \(file)")
    }
}

class AudioDecoder {
    func decodeAudio(file: String) {
        print("Decoding audio from \(file)")
    }
}

class PlayerEngine {
    func play() {
        print("Playing video and audio")
    }
}


🔹 Facade Class

class MediaPlayerFacade {
    private let videoDecoder = VideoDecoder()
    private let audioDecoder = AudioDecoder()
    private let playerEngine = PlayerEngine()

    func playMedia(file: String) {
        videoDecoder.decodeVideo(file: file)
        audioDecoder.decodeAudio(file: file)
        playerEngine.play()
    }
}


🧪 Usage

let player = MediaPlayerFacade()
player.playMedia(file: "movie.mp4")

// Output:
// Decoding video from movie.mp4
// Decoding audio from movie.mp4
// Playing video and audio


📝 Interview Summary Answer:

Facade pattern helps reduce complexity by exposing a single simplified interface to a set of complex subsystems. In iOS, I might use it to simplify calls to AVFoundation or CoreData by wrapping complex logic into a single manager or service class.


f ) Flyweight Design Pattern:-

Flyweight is a structural design pattern used to reduce memory usage by sharing common objects instead of creating new ones every time.

🎯 Real-Life Analogy:
Imagine a text editor 📄:
You write 1 million characters.
Instead of storing a new font object for every character, the app stores one font object and shares it.
Only the character, position, and color are unique.

🔹 Shared Object (Flyweight)

class PinImage {
    let imageName: String

    init(imageName: String) {
        self.imageName = imageName
        print("Created new PinImage for: \(imageName)")
    }
}


🔹 Flyweight Factory

class PinImageFactory {
    private var cache = [String: PinImage]()

    func getImage(for imageName: String) -> PinImage {
        if let cached = cache[imageName] {
            return cached
        }
        let newImage = PinImage(imageName: imageName)
        cache[imageName] = newImage
        return newImage
    }
}

🔹 Context Object (Map Pin with location)

struct MapPin {
    let latitude: Double
    let longitude: Double
    let pinImage: PinImage
}

🧪 Usage

let factory = PinImageFactory()

let pin1 = MapPin(latitude: 12.9716, longitude: 77.5946, pinImage: factory.getImage(for: "restaurant"))
let pin2 = MapPin(latitude: 28.7041, longitude: 77.1025, pinImage: factory.getImage(for: "restaurant"))
let pin3 = MapPin(latitude: 19.0760, longitude: 72.8777, pinImage: factory.getImage(for: "hospital"))

// Output:
// Created new PinImage for: restaurant
// Created new PinImage for: hospital


📝 Interview Summary Answer:
Flyweight pattern is used to minimize memory usage by sharing common parts of objects instead of duplicating them. In iOS, I might use it in maps, where 1000s of pins share the same icon, or in drawing apps where colors or shapes repeat.

g) Proxy:-

Proxy is a structural design pattern that lets you provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request gets through to the original object.

🎯 Real-Life Analogy:
You don’t talk directly to a celebrity. You go through their agent (proxy) who manages communication, filters requests, and handles access.

🧠 When to Use in iOS:
Lazy loading (e.g. loading large images or data only when needed).
Access control (e.g. user permissions).
Caching (e.g. cache network responses).
Remote proxies (e.g. service calls).


🔹 Real Object (Expensive to load)
protocol Image {
    func display()
}

class RealImage: Image {
    private let filename: String

    init(filename: String) {
        self.filename = filename
        loadFromDisk()
    }

    private func loadFromDisk() {
        print("Loading image from disk: \(filename)")
    }

    func display() {
        print("Displaying image: \(filename)")
    }
}

🔹 Proxy Class
class ProxyImage: Image {
    private let filename: String
    private var realImage: RealImage?

    init(filename: String) {
        self.filename = filename
    }

    func display() {
        if realImage == nil {
            realImage = RealImage(filename: filename)
        }
        realImage?.display()
    }
}

🧪 Usage
let image = ProxyImage(filename: "profile.png")

// Image not loaded yet

image.display() // Loads only when needed (lazy)
image.display() // Doesn't load again

📝 Interview Summary Answer:
Proxy pattern provides a substitute object that controls access to another object. In iOS, I can use it for lazy image loading, permission checks, or network call wrappers.


Behavioral Design Patterns:-

Behavioral design patterns are concerned with algorithms and the assignment of responsibilities between objects.


a) Chain of Responsibility:-

Chain of Responsibility is a behavioral design pattern that lets you pass requests along a chain of handlers. Upon receiving a request, each handler decides either to process the request or to pass it to the next handler in the chain.

🎯 Real-Life Analogy:
Think of customer service: You call support, the first-level agent tries to help. If they can’t, they escalate to supervisor, then to manager, and so on.

🧠 When to Use in iOS:
Handling UI event propagation (like responder chain in UIKit).
Middleware processing in networking (e.g., logging, auth, validation).
Form validation step-by-step.

🔹 Handler Protocol
protocol Validator {
    var next: Validator? { get set }
    func validate(input: String) -> Bool
}

🔹 Concrete Handlers
class EmptyValidator: Validator {
    var next: Validator?

    func validate(input: String) -> Bool {
        if input.isEmpty {
            print("Validation failed: Input is empty")
            return false
        } else {
            return next?.validate(input: input) ?? true
        }
    }
}

class EmailValidator: Validator {
    var next: Validator?

    func validate(input: String) -> Bool {
        if input.contains("@") {
            return next?.validate(input: input) ?? true
        } else {
            print("Validation failed: Invalid email")
            return false
        }
    }
}

🔹 Setup Chain

let empty = EmptyValidator()
let email = EmailValidator()

empty.next = email

let isValid = empty.validate(input: "user@example.com") // ✅

📝 Interview Summary Answer:
Chain of Responsibility lets me pass a request through a chain of objects. Each handler either processes the request or forwards it. In iOS, it's useful for things like input validation, middleware, or responder chain handling in UIKit.


b) Command:-

Command is a behavioural design pattern that turns a request into a stand-alone object that contains all information about the request. This transformation lets you pass requests as a method arguments, delay or queue a request’s execution, and support undoable operations.

🎯 Real-Life Analogy:
Think of a TV remote control. Each button (command) knows what it does: turn TV on/off, increase volume, etc. The remote holds these commands and executes them when needed.

🧠 When to Use in iOS:
Undo/Redo functionality.
Button actions decoupled from business logic.
Macro commands (batching multiple commands).
Task queueing for background execution.


🔹 Command Protoco
protocol Command {
    func execute()
    func undo()
}

🔹 Receiver (Text Editor)
class TextEditor {
    var text = ""

    func write(_ newText: String) {
        text += newText
    }

    func erase(_ count: Int) {
        text = String(text.dropLast(count))
    }
}

🔹 Concrete Command
class WriteCommand: Command {
    private let editor: TextEditor
    private let text: String

    init(editor: TextEditor, text: String) {
        self.editor = editor
        self.text = text
    }

    func execute() {
        editor.write(text)
    }

    func undo() {
        editor.erase(text.count)
    }
}

🔹 Invoker

class CommandManager {
    private var history: [Command] = []

    func execute(_ command: Command) {
        command.execute()
        history.append(command)
    }

    func undoLast() {
        guard let last = history.popLast() else { return }
        last.undo()
    }
}

🔹 Usage

let editor = TextEditor()
let manager = CommandManager()

let writeHello = WriteCommand(editor: editor, text: "Hello ")
let writeWorld = WriteCommand(editor: editor, text: "World!")

manager.execute(writeHello)
manager.execute(writeWorld)

print(editor.text) // "Hello World!"
manager.undoLast()
print(editor.text) // "Hello "


📝 Interview Summary Answer:
The Command pattern lets me encapsulate a request as an object. This is useful for undo/redo, delayed actions, or queuing commands. In iOS, it fits well in cases like text editors or decoupling button actions from actual logic.


c) Iterator Design Pattern:-

Iterator is a behavioral design pattern that lets you traverse elements of a collection without exposing its internal structure.

🎯 Real-Life Analogy:
Think of a TV channel remote – you can flip through channels one at a time, but you don’t need to know how they’re stored inside the remote.

🧠 When to Use in iOS:
When you want to loop through custom collections (e.g. custom data structures).
To keep collection logic separate from iteration logic.

🔹 Song Model

struct Song {
    let name: String
}

🔹 Custom Collection

class Playlist {
    private var songs: [Song] = []

    func add(_ song: Song) {
        songs.append(song)
    }

    func createIterator() -> PlaylistIterator {
        return PlaylistIterator(songs)
    }
}

🔹 Iterator

class PlaylistIterator: IteratorProtocol {
    private let songs: [Song]
    private var index = 0

    init(_ songs: [Song]) {
        self.songs = songs
    }

    func next() -> Song? {
        guard index < songs.count else { return nil }
        let song = songs[index]
        index += 1
        return song
    }
}

🔹 Usage

let playlist = Playlist()
playlist.add(Song(name: "Song A"))
playlist.add(Song(name: "Song B"))
playlist.add(Song(name: "Song C"))

let iterator = playlist.createIterator()
while let song = iterator.next() {
    print(song.name)
}
// Output:
// Song A
// Song B
// Song C


📝 Interview Summary Answer:
The Iterator pattern allows me to access elements of a collection one by one without exposing how the collection is built. In iOS, it's useful when building custom collections or when I want to decouple data and traversal logic.


d) Mediator:-

Mediator is a behavioral design pattern that defines an object (Mediator) to centralize communication between multiple objects, so objects don’t directly communicate with each other.

🎯 Real-Life Analogy:
In an airport, planes don’t talk to each other. Instead, they talk to the air traffic controller (mediator) who coordinates everything.

🧠 When to Use in iOS:
To reduce tight coupling between objects.
When multiple objects need to communicate but shouldn't depend on each other.
Often used in chat apps, UI components coordination, form coordination etc.


🔹 Mediator Protocol
protocol ChatRoom {
    func send(message: String, from user: User)
}

🔹 Concrete Mediator

class ChatRoomImpl: ChatRoom {
    func send(message: String, from user: User) {
        print("\(user.name): \(message)")
    }
}

🔹 Colleague (User)

class User {
    let name: String
    private let chatRoom: ChatRoom

    init(name: String, chatRoom: ChatRoom) {
        self.name = name
        self.chatRoom = chatRoom
    }

    func send(message: String) {
        chatRoom.send(message: message, from: self)
    }
}

🔹 Usage

let chatRoom = ChatRoomImpl()

let user1 = User(name: "Alice", chatRoom: chatRoom)
let user2 = User(name: "Bob", chatRoom: chatRoom)

user1.send(message: "Hello Bob!")
user2.send(message: "Hi Alice!")

🔎 Output:

Alice: Hello Bob!
Bob: Hi Alice!

📝 Interview Summary Answer:
Mediator pattern centralizes communication between objects. In iOS, I can use it to handle communication between view controllers, UI components, or for chat systems where objects don’t directly depend on each other.

e) Memento:- 

Memento is a behavioral design pattern that allows capturing and restoring an object’s state without exposing its internal details.

🎯 Real-Life Analogy:
Think of undo/redo in a text editor. Before making changes, you save the current state. If needed, you can restore the previous state.

🧠 When to Use in iOS:
Implementing Undo/Redo functionality
Saving state in games, text editors, drawing apps
Keeping snapshots before making risky changes


🔹 Originator (object whose state we want to save)

class TextEditor {
    var text: String = ""

    func save() -> Memento {
        return Memento(state: text)
    }

    func restore(from memento: Memento) {
        self.text = memento.state
    }
}

🔹 Memento (state container)

class Memento {
    let state: String

    init(state: String) {
        self.state = state
    }
}

🔹 Caretaker (manages mementos)

class Caretaker {
    private var history: [Memento] = []

    func save(state: Memento) {
        history.append(state)
    }

    func undo() -> Memento? {
        return history.popLast()
    }
}

🔹 Usage

let editor = TextEditor()
let caretaker = Caretaker()

editor.text = "Version 1"
caretaker.save(state: editor.save())

editor.text = "Version 2"
caretaker.save(state: editor.save())

editor.text = "Version 3"
print(editor.text) // Version 3

if let previous = caretaker.undo() {
    editor.restore(from: previous)
}
print(editor.text) // Version 2

📝 Interview Summary Answer:
Memento allows me to save and restore an object’s state without breaking encapsulation. In iOS, I can use it for undo/redo features, state restoration in apps, or even for game saves.


F) Observer:-

Observer is a behavioral design pattern where an object (subject) maintains a list of dependents (observers) and notifies them automatically of any state changes.

🎯 Real-Life Analogy:
Think of YouTube Subscriptions:
When a channel uploads a new video, all subscribers (observers) get notified automatically.

🧠 When to Use in iOS:
UI updates when data changes.
NotificationCenter.
Combine framework (Publisher / Subscriber).
KVO (Key-Value Observing).

🔹 Subject (Publisher)

protocol WeatherStation {
    func addObserver(_ observer: WeatherObserver)
    func removeObserver(_ observer: WeatherObserver)
    func notifyObservers()
}

🔹 Concrete Subject

class WeatherData: WeatherStation {
    private var observers = [WeatherObserver]()
    var temperature: Double = 0.0 {
        didSet {
            notifyObservers()
        }
    }

    func addObserver(_ observer: WeatherObserver) {
        observers.append(observer)
    }

    func removeObserver(_ observer: WeatherObserver) {
        observers.removeAll { $0 === observer }
    }

    func notifyObservers() {
        for observer in observers {
            observer.update(temperature: temperature)
        }
    }
}

🔹 Observer (Subscriber)

protocol WeatherObserver: AnyObject {
    func update(temperature: Double)
}

🔹 Concrete Observer

class PhoneDisplay: WeatherObserver {
    func update(temperature: Double) {
        print("Phone Display: Current temperature is \(temperature)°C")
    }
}

class TVDisplay: WeatherObserver {
    func update(temperature: Double) {
        print("TV Display: Current temperature is \(temperature)°C")
    }
}

🔹 Usage

let weatherData = WeatherData()

let phone = PhoneDisplay()
let tv = TVDisplay()

weatherData.addObserver(phone)
weatherData.addObserver(tv)

weatherData.temperature = 25.0
weatherData.temperature = 30.0

🔎 Output:

Phone Display: Current temperature is 25.0°C
TV Display: Current temperature is 25.0°C
Phone Display: Current temperature is 30.0°C
TV Display: Current temperature is 30.0°C


📝 Interview Summary Answer:
Observer allows objects to subscribe and get notified when something changes. In iOS, it’s heavily used in:
NotificationCenter
Combine framework
KVO
Delegation pattern

g) State:-

State Pattern allows an object to change its behavior when its internal state changes. The object will appear to change its class.

🎯 Real-Life Analogy:
Think of a Traffic Signal:
The signal changes its behavior based on its state — Red, Yellow, Green.

🧠 When to Use in iOS:
When object behavior depends on its state.
When you want to avoid big if-else or switch statements.
Used in media players, UI state management, games, etc.

🔹 State Protocol

protocol PlayerState {
    func play()
    func pause()
}

🔹 Concrete States

class PlayingState: PlayerState {
    func play() {
        print("Already Playing")
    }

    func pause() {
        print("Pausing the player")
    }
}

class PausedState: PlayerState {
    func play() {
        print("Resuming playback")
    }

    func pause() {
        print("Already Paused")
    }
}

🔹 Context

class MediaPlayer {
    private var state: PlayerState

    init(state: PlayerState) {
        self.state = state
    }

    func setState(_ state: PlayerState) {
        self.state = state
    }

    func play() {
        state.play()
    }

    func pause() {
        state.pause()
    }
}

🔹 Usage

let player = MediaPlayer(state: PausedState())

player.play()   // Resuming playback
player.setState(PlayingState())
player.pause()  // Pausing the player


📝 Interview Summary Answer:
State pattern allows objects to change behavior based on their current state. In iOS, it’s useful for media players, UI flows, network request states, and any object whose behavior changes based on internal state.


h) Strategy:-

Strategy Pattern allows you to define a family of algorithms, put them in separate classes, and make them interchangeable at runtime.

🎯 Real-Life Analogy:
Think of navigation apps:
You can choose different route strategies: fastest, shortest, or avoid tolls.
The algorithm changes, but interface stays same.


🧠 When to Use in iOS:
When you have multiple ways to perform a task.
To avoid multiple if-else or switch conditions.
Examples: sorting algorithms, payment methods, compression algorithms, etc.


🔹 Strategy Protocol

protocol PaymentStrategy {
    func pay(amount: Double)
}


🔹 Concrete Strategies

class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Credit Card.")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using PayPal.")
    }
}

class ApplePayPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Apple Pay.")
    }
}

🔹 Context

class PaymentContext {
    private var strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func pay(amount: Double) {
        strategy.pay(amount: amount)
    }
}

🔹 Usage

let payment = PaymentContext(strategy: CreditCardPayment())
payment.pay(amount: 100)

payment.setStrategy(PayPalPayment())
payment.pay(amount: 200)

payment.setStrategy(ApplePayPayment())
payment.pay(amount: 300)


🔎 Output:

Paid 100.0 using Credit Card.
Paid 200.0 using PayPal.
Paid 300.0 using Apple Pay.


📝 Interview Summary Answer:
Strategy pattern lets me switch algorithms or behaviors at runtime. In iOS, it’s useful for payment gateways, sorting algorithms, UI themes switching, layout strategies, etc.


I) Template Method:-

Template Method defines the skeleton of an algorithm in a superclass but lets subclasses override specific steps without changing the structure of the algorithm.

🎯 Real-Life Analogy:
Think of preparing tea or coffee:
Steps: boil water → brew → pour → add extras.
The base process is same, but brewing & extras differ for tea & coffee.

🧠 When to Use in iOS:
When you have fixed algorithm flow but some steps need customization.
Used in table view cell configurations, network requests, game loops, onboarding flows, etc.

🔹 Template (Base Class)

class Beverage {
    // Template method (final)
    final func prepare() {
        boilWater()
        brew()
        pourInCup()
        addExtras()
    }

    func boilWater() {
        print("Boiling water")
    }

    func pourInCup() {
        print("Pouring into cup")
    }

    // Steps to be overridden
    func brew() { }
    func addExtras() { }
}

🔹 Concrete Subclasses

class Tea: Beverage {
    override func brew() {
        print("Steeping the tea")
    }

    override func addExtras() {
        print("Adding lemon")
    }
}

class Coffee: Beverage {
    override func brew() {
        print("Brewing coffee grounds")
    }

    override func addExtras() {
        print("Adding sugar and milk")
    }
}

🔹 Usage

let tea = Tea()
tea.prepare()

let coffee = Coffee()
coffee.prepare()


🔎 Output:

Boiling water
Steeping the tea
Pouring into cup
Adding lemon

Boiling water
Brewing coffee grounds
Pouring into cup
Adding sugar and milk


📝 Interview Summary Answer:
Template Method allows me to define a common algorithm structure in a superclass while letting subclasses customize specific steps. In iOS, I can use it for UITableViewDataSource, UIViewController lifecycle methods, networking layers, etc.


J) Visitor:-

Visitor Pattern allows you to separate algorithms from the objects on which they operate, by moving behavior into a visitor object.

🎯 Real-Life Analogy:
Think of a tax inspector visiting different businesses:
Inspector (Visitor) knows how to calculate tax for each business.
Each business (Element) allows the visitor to visit and apply the operation.

🧠 When to Use in iOS:
When you want to perform operations on objects without modifying their classes.
Often used in serialization, analytics, export functionality, or reporting modules.

🔹 Visitor Protocol

protocol FileVisitor {
    func visit(file: File)
    func visit(folder: Folder)
}

🔹 Elements Protocol

protocol FileSystemElement {
    func accept(visitor: FileVisitor)
}

🔹 Concrete Elements

class File: FileSystemElement {
    let name: String
    let size: Int

    init(name: String, size: Int) {
        self.name = name
        self.size = size
    }

    func accept(visitor: FileVisitor) {
        visitor.visit(file: self)
    }
}

class Folder: FileSystemElement {
    let name: String
    var contents: [FileSystemElement] = []

    init(name: String) {
        self.name = name
    }

    func accept(visitor: FileVisitor) {
        visitor.visit(folder: self)
        contents.forEach { $0.accept(visitor: visitor) }
    }
}

🔹 Concrete Visitor

class SizeCalculator: FileVisitor {
    var totalSize = 0

    func visit(file: File) {
        totalSize += file.size
    }

    func visit(folder: Folder) {
        // Folder itself may not have size, but can include this logic
    }
}

🔹 Usage

let file1 = File(name: "File1.txt", size: 100)
let file2 = File(name: "File2.txt", size: 200)
let folder = Folder(name: "MyFolder")
folder.contents = [file1, file2]

let sizeCalculator = SizeCalculator()
folder.accept(visitor: sizeCalculator)
print("Total size: \(sizeCalculator.totalSize) KB")


🔎 Output:

Total size: 300 KB

📝 Interview Summary Answer:
Visitor lets me add new operations to existing object structures without modifying them. In iOS, I can use it for analytics tracking, serialization, exporting data, reporting, or validation frameworks.


33) difference between Framework vs XCFramework?

Ans.

Frameworks and XCFrameworks are both used to distribute binary libraries in iOS development. The key difference is that XCFrameworks support multiple architectures and platforms within a single package, allowing for better compatibility across different devices, while traditional frameworks typically support only one architecture at a time.

34) string memory allocation?(low priority)
Ans.

In Swift, string memory allocation is managed automatically by the Swift runtime, which uses a system called "copy-on-write" (COW) to optimize memory usage and performance. Understanding how strings are allocated and managed in memory can help you write more efficient Swift code.

String Memory Allocation in Swift
Value Type:

In Swift, String is a value type, which means that when you assign a string to a new variable or pass it to a function, a copy of the string is created. However, due to the copy-on-write mechanism, the actual data is not copied until it is modified.
Copy-on-Write (COW):

When a string is created, it is stored in a memory buffer. If you assign this string to another variable, both variables point to the same memory location. The actual string data is only copied when one of the strings is modified. This optimization helps reduce memory usage and improves performance.
Memory Management:

Swift uses Automatic Reference Counting (ARC) to manage memory. When a string is no longer needed, ARC automatically deallocates the memory associated with it. This means that you don't have to manually manage memory allocation and deallocation.
String Internals:

Internally, a Swift string is represented as a collection of characters. It can store its data in different formats, such as UTF-8 or UTF-16, depending on the content. Swift strings are designed to be efficient and safe, handling Unicode characters seamlessly.

Example of String Memory Allocation:

var str1 = "Hello, World!" // str1 is allocated in memory
var str2 = str1            // str2 points to the same memory as str1

print(str1) // Output: Hello, World!
print(str2) // Output: Hello, World!

str2 += " How are you?"    // Now str2 is modified, triggering a copy

print(str1) // Output: Hello, World!
print(str2) // Output: Hello, World! How are you?

35) Appdelegate vs sceneDelegate ?
Ans.

AppDelegate
1. Purpose:

The AppDelegate is responsible for handling application-level events and managing the overall lifecycle of the app. It is the entry point of the app and is used to respond to high-level events such as app launch, backgrounding, foregrounding, and termination.

2. Lifecycle Methods:

Common methods in AppDelegate include:
application(_:didFinishLaunchingWithOptions:): Called when the app has completed its launch process.
applicationDidEnterBackground(_:): Called when the app enters the background.
applicationWillEnterForeground(_:): Called when the app is about to enter the foreground.
applicationWillTerminate(_:): Called when the app is about to terminate.

3. Single Instance:

There is only one instance of AppDelegate for the entire application, regardless of how many scenes are active.

4. Usage:

It is used for setting up global app configurations, handling notifications, and managing shared resources.

SceneDelegate

1. Purpose:

The SceneDelegate is introduced in iOS 13 to manage individual scenes (UI instances) of the app. It allows for multiple windows or scenes to be managed independently, which is particularly useful for multitasking on iPad and supporting multiple instances of the app.

2. Lifecycle Methods:

Common methods in SceneDelegate include:

scene(_:willConnectTo:options:): Called when a new scene is being created and is about to be added to the app.
sceneDidBecomeActive(_:): Called when the scene has moved from an inactive state to an active state.
sceneWillResignActive(_:): Called when the scene will move from an active state to an inactive state.
sceneDidDisconnect(_:): Called when the scene is being released by the system.

3. Multiple Instances:

There can be multiple instances of SceneDelegate if the app supports multiple scenes. Each scene can have its own UI and state.

4. Usage:

It is used for managing the UI and state of a specific scene, handling scene-specific events, and managing the lifecycle of the scene.


36) What is application(_:willFinishLaunchingWithOptions:)?
Ans.

Definition:
application(_:willFinishLaunchingWithOptions:) is a method of UIApplicationDelegate that is called before the app has completed launching.

Purpose:

* It's used to perform early setup (before the app's interface is fully initialized).

You can use it for:

* Configuring app services

* Registering defaults

* Setting up dependency containers

* Light logging or early state restoration

37) what always didfinishlaunchoption returns true what happens if its return false ?
Ans.

didFinishLaunchingWithOptions returns true if the app has successfully initialized and is ready to run. According to Apple, I should return false if the app cannot handle a launch request like a deep link (URL), Handoff user activity, or other custom launchOptions.

However, in most normal launches, returning false won’t stop the app from running — UIKit will still launch the app. The return value is more relevant in edge cases like handling launch via URL schemes, Handoff, or background fetches.

38) types of Architecture Pattern?
Ans.

1. MVC (Model-View-Controller)

Model: Manages app data, business logic, and rules. It’s independent of UI.
View: Displays UI elements and handles user interactions.
Controller: Mediates between Model and View; retrieves data from Model and updates View. It contains UI logic.

Why Use MVC?
* It’s the default iOS architecture pattern and simple to implement.
* Fits small to medium apps with straightforward flow.

Pros
* Easy to understand and implement.
* Works well for apps with simple UI and limited complexity.

Cons
* Controller often becomes a “Massive View Controller” with too many responsibilities (business logic + UI logic).
* Tight coupling between View and Controller can reduce maintainability.
* Harder to scale for large or complex apps.

2. MVVM (Model-View-ViewModel)

Model: Same as MVC, holds raw data/business logic.
View: Displays data and receives user actions.
ViewModel: Prepares data from Model in a format usable by View. Handles logic to separate UI and business logic.

Why Use MVVM?

* Better separation of concerns than MVC.
* Simplifies unit testing since ViewModel contains no UI code.
* Works well with SwiftUI and reactive programming.

Pros
* Clear separation of UI and logic.
* Easier to test ViewModels independently.
* Reduces Massive View Controller problem.

Cons
* Can introduce complexity in data binding.
* Requires extra boilerplate code for binding between View and ViewModel.
* May be overkill for very simple apps.

3. VIPER (View-Interactor-Presenter-Entity-Router)

View: Displays UI, sends user actions to Presenter.
Interactor: Contains business logic and data manipulation.
Presenter: Prepares data from Interactor for View; acts as mediator.
Entity: Data models or business objects.
Router: Handles navigation and routing between screens.

Why Use VIPER?
* Enforces strong separation of concerns.
* Makes code highly modular and organized.
* Suitable for complex or large apps requiring scalability and testability.

Pros
* Clear single responsibility for each component.
* Easy to write unit tests for Interactor and Presenter.
* Modular and scalable for teams working on large codebases.

Cons
* Steeper learning curve. (For beginners or developers new to VIPER, understanding the responsibilities and interactions between all these components takes time.)
* More boilerplate code compared to MVC/MVVM. (For one simple screen, you might write five or more files and several protocols, whereas MVC might need just one or two files.)
* Initial setup time is higher. (Getting started with VIPER for a new feature or screen takes more effort at the beginning.)

4. Clean Architecture (on iOS)
Domain Layer: Core business logic and entities, completely independent of frameworks.
Application Layer: Use cases that orchestrate domain entities to perform tasks.
Infrastructure Layer: Implementation of external services like networking, databases.
Presentation Layer: UI layer — displays data and sends user input downstream.

Core Principle
* Rules of dependency inversion: Dependencies point inward, i.e., outer layers depend on inner layers but not vice versa.

Why Use Clean Architecture?
* Creates a highly modular, scalable, and testable app.
* Separates concerns strictly and isolates business logic from UI or framework changes.
* Suited for enterprise-level or large-scale projects.

Pros
* Very maintainable and testable.
* Business logic unaffected by UI or platform changes.
* Easy swapping of external layers without affecting core logic.
    
Cons
* Complex to set up initially.
* Might be overkill for small/simple apps.
* Requires more discipline and experience to implement.

5. MVP (Model-View-Presenter)

Model:
Responsible for the app’s data and business logic. It retrieves, stores, and processes data but does not contain UI logic. This can involve network/API services or local databases.
Example: Data structures, network managers, repositories.
View
Displays the UI and interacts with the user. In iOS, this is typically the UIViewController (or SwiftUI View). The View is passive—it only forwards user events and renders what the Presenter tells it. It exposes a protocol defining its interface (i.e., methods for updating the UI or forwarding events).
Example: A ViewController that implements a protocol ViewInterface and sends user actions to the Presenter.

Presenter
Acts as a mediator between the View and the Model. It listens to user actions coming from the View, requests data and operations from the Model, transforms or formats data as needed, and instructs the View to display it. The Presenter contains most of the presentation logic and state, but no UI code.
Example: A Presenter class initialized with references to a View protocol and Model services.

How MVP Works in iOS

* The ViewController (View) captures user interactions (e.g., button taps) and calls corresponding methods on the Presenter.
* The Presenter invokes Model services to fetch or modify data.
* The Model processes data and returns results.
* The Presenter formats the data and calls update methods on the View to refresh UI.

Why Use MVP?

* Separation of Concerns: Clear division between UI (View), app logic (Presenter), and data (Model).
* Testability: Presenter and Model contain no UI dependencies, so they can be unit tested easily without UI.
* Maintainability: Presentation logic is centralized, minimizing massive view controllers.
* Reusability: Presenter can be reused for different Views or platforms if designed properly.


| Pros                              | Cons                            |
|-----------------------------------|---------------------------------|
| Improves testability              | More boilerplate code           |
| by isolating presentation logic   | and complexity compared to MVC  |
|                                   |                                 |
| Presenter centralizes event flow  | Presenter can become large      |
| simplifying debugging             | if not carefully managed        |
|                                   |                                 |
| Decouples UI from business logic  | Requires explicit communication |
| and data sources                  | protocols/interfaces            |
|                                   |                                 |
| Easier to add or change UI        | Some learning curve             |
| without touching logic            | to understand communication flow|



#**39) App Store uploads process?( explain briefly and inside certificate what is present)**
Ans.

#App Store Upload Process

##1. Prepare Your App:

Ensure your app is complete, tested, and free of bugs.
Follow Apple's Human Interface Guidelines to ensure your app meets design standards.

##2. Create an App Store Connect Account:

Sign up for an Apple Developer Program account if you haven't already.
Access App Store Connect, which is the platform used to manage your apps.

##3. Set Up Your App in App Store Connect:

Create a new app record in App Store Connect.
Fill in the required metadata, including app name, description, keywords, screenshots, and app icon.

##4. Code Signing and Certificates:

Generate a distribution certificate and provisioning profile in Xcode.
The distribution certificate is used to sign your app, ensuring that it comes from a verified developer.

##5. Archive Your App:

In Xcode, select your project and choose "Product" > "Archive" to create an archive of your app.
This archive is what you will upload to the App Store.

##6. Upload Your App:

Use Xcode or the Transporter app to upload your archived app to App Store Connect.
Xcode provides a built-in option to upload directly after archiving.

##7. Submit for Review:

Once the upload is complete, go back to App Store Connect.
Select your app and submit it for review. You may need to answer questions about your app's content and functionality.

##8. App Review Process:

Apple reviews your app to ensure it meets their guidelines and policies.
You may receive feedback or requests for changes during this process.

##9. Release Your App:

Once approved, you can choose to release your app immediately or set a specific release date.


##41) design pattern vs architecture pattern?
Ans.

Design patterns are reusable solutions to common problems that occur within a specific context in software design. They provide a template for how to solve a particular design issue.

Architectural patterns are high-level strategies that define the overall structure and organization of a software system. They provide a blueprint for how different components of a system interact and are organized.

##43) what is difference between library vs framework?
Ans.

Libraries and frameworks are both collections of reusable code, but they differ in their scope, how they are used, and most importantly, the flow of control within an application.

library
A library is a collection of reusable code (functions, classes, etc.) that you can call in your app.
Example:

* Alamofire (networking library)
* CryptoKit
* libz.dylib (zlib compression)

Framework
A framework is a complete packaged module that contains:

* A library
* Resources (like images, storyboards)
* Metadata


##46) what is difference in APP ID vs Team ID vs Bundle ID?
Ans.

1. Bundle ID (bundle identifier):

Definition: A unique identifier that identifies a single app. It is like a unique fingerprint that no other app can have.
Structure: It's typically a string in reverse domain name notation, for example: com.companyname.appname.

2. Team ID:

Definition: A Team ID is a unique identifier assigned to your Apple Developer account or team. It is used to identify your development team within the Apple ecosystem.
Format: The Team ID is a 10-character alphanumeric string (e.g., ABCDE12345).

3. App ID:

Definition: An App ID is a unique identifier for your app that is used by Apple to distinguish it from other apps in the App Store and on devices. It is a combination of Team ID + Bundle ID

Example: ABCDE12345.com.companyname.appname


##48) what is cocoa and cocoa touch?
Ans.

🔹 Cocoa (macOS)
Cocoa is a macOS framework used to build apps for Mac desktops.

* Built using Objective-C / Swift
* Uses AppKit for UI
* Supports Mouse & Keyboard interactions

Cocoa Touch (iOS)
Cocoa Touch is a framework for building iOS, iPadOS, watchOS, and tvOS apps.

* Built on top of Cocoa
* Uses UIKit, Foundation, CoreAnimation, etc.
* Supports touch, gestures, motion, multitouch

##55) URL session all concept?
Ans.

A URL session is a mechanism that allows an application to send and receive data over the internet using URLs. It manages the transfer of data between the client (your application) and the server.

Components of a URL:-
A URL (Uniform Resource Locator) consists of several components:

Scheme: Indicates the protocol (e.g., http, https, ftp).
Host: The domain name or IP address of the server (e.g., www.example.com).
Port: The port number (optional, default is 80 for HTTP and 443 for HTTPS).
Path: The specific resource on the server (e.g., /api/data).
Query: A set of key-value pairs for parameters (e.g., ?id=123&sort=asc).
Fragment: A reference to a specific part of the resource (e.g., #section1).

Making Requests:-
You can make various types of HTTP requests using URL sessions:

GET: Retrieve data from a server.
POST: Send data to a server.
PUT: Update existing data on a server.
DELETE: Remove data from a server.

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    // Handle response
}
task.resume()
##68) deep linking and universal linking in ios?
Ans.

•   Deep Linking: Opening an app to specific content via a special link—traditionally using a custom URL scheme (e.g.,  myapp://item/1 ).
•   Universal Links: Apple’s secure deep linking: a standard HTTPS URL (e.g.,  https://example.com/item/1 ) that opens the app if installed, or the relevant web page if not.

Why the Distinction Matters

•  Custom URL schemes are quick to set up but lack security and fallback. Any app can hijack the scheme, and there’s no seamless user experience if the app isn’t installed.
•  Universal Links provide a seamless, secure, and standardized experience. They’re verified through the AASA file on your server, work across web and app, and never show the “Open in App?” dialog. If the app isn’t installed, users just land on your website.


## 69) class vs structure?
Ans.

In Swift, classes are reference types stored on the heap, where multiple variables can point to the same instance, and changes reflect everywhere.
Structures (structs) are value types stored on the stack (or optimized storage), meaning each assignment creates a new copy and mutations don’t affect the original.
Classes support features like inheritance, deinitializers, and identity checks, while structs are lightweight, thread-safe, and preferred for modeling simple, immutable data.

struct UserStruct {
    var name: String
}

class UserClass {
    var name: String
    init(name: String) { self.name = name }
}

var s1 = UserStruct(name: "Alice")
var s2 = s1
s2.name = "Bob"
print(s1.name) // "Alice" -> independent copy

var c1 = UserClass(name: "Alice")
var c2 = c1
c2.name = "Bob"
print(c1.name) // "Bob" -> shared reference

Interview Q&A

Q1. What are the key differences between class and struct in Swift?
👉 Structs are value types, copied on assignment, don’t support inheritance, and are generally faster.
👉 Classes are reference types, use ARC, support inheritance, identity checks (===), and deinitializers.

Q2. When would you prefer struct over class?
👉 Use structs when modeling small, immutable, and independent data (like CGSize, Date, or DTOs).
👉 Use classes when you need inheritance, polymorphism, or shared mutable state.

Q3. How does memory management differ?
👉 Structs: allocated on the stack (or inline), no ARC overhead, copied on mutation.
👉 Classes: allocated on the heap, managed by ARC, may cause retain cycles if not handled.

Q4. Can structs conform to protocols like classes?
👉 Yes, both can conform to Swift protocols. But only classes can adopt @objc protocols, support identity (===), and have deinitializers.


## Q. 71) what is difference between in Self(uppercase) vs self(lowercase)?
Ans.


self (lowercase) is a reference to the current instance of a class, struct, or enum. You use it to access properties, methods, or to distinguish between parameter names and property names.

Self (uppercase) refers to the type itself, not an instance. It’s commonly used in protocols, generic constraints, and for returning the current type in methods (like factory patterns or static methods).


class Person {
    var name: String
    
    init(name: String) {
        self.name = name   // 'self' differentiates property from parameter
    }
    
    func clone() -> Self {   // 'Self' returns the type of the current instance
        return Self(name: self.name)
    }
}

let p1 = Person(name: "Alice")
let p2 = p1.clone()
print(p2.name) // Alice

Interview Q&A

Q1. When do you need to use self explicitly?
👉 When a parameter or local variable has the same name as a property, or to clarify you’re referring to the instance.

Q2. Where is Self used?
👉 In protocols and class/struct methods that need to refer to the type itself, especially for factory methods or returning the same type.

Q3. Can Self be used in structs or enums?
👉 Yes, Self always refers to the type itself, regardless of whether it’s a struct, enum, or class.

Q4. Difference in protocols:
protocol Clonable {
    func clone() -> Self
}


## Q. 72) what is generic in Swift?
Ans.

Generics allow you to write flexible, reusable functions, types, and methods that work with any data type, while maintaining type safety.
Instead of duplicating code for each type, generics let you parameterize types, making your code cleaner, safer, and more maintainable.

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 5
var y = 10
swapValues(&x, &y)
print(x, y) // 10 5

var a = "Hello"
var b = "World"
swapValues(&a, &b)
print(a, b) // World Hello

Interview Q&A

Q1. Why use generics instead of Any?
👉 Generics are type-safe at compile time, while Any requires casting and is error-prone.

Q2. Can protocols be used with generics?
👉 Yes, using protocol constraints:

func printValue<T: CustomStringConvertible>(_ value: T) {
    print(value.description)
}


Q3. What’s the difference between generic functions and generic types?
👉 Generic functions allow any type in a function call.
👉 Generic types (struct/class/enum) allow any type in their definition.

Q4. How are generics used in Swift standard library?
👉 Collections (Array<T>, Dictionary<Key, Value>, Set<T>) and algorithms (map, filter, reduce) are heavily generic-based.


##Q. 73) what is associated type in Swift?
Ans.

An associated type in Swift is a placeholder type used in a protocol. It allows a protocol to define a type without specifying exactly what it is, letting conforming types decide the concrete type.
Associated types are particularly useful for generic-like behavior in protocols, enabling flexibility while preserving type safety.

protocol Container {
    associatedtype Item
    var items: [Item] { get set }
    mutating func append(_ item: Item)
}

struct IntStack: Container {
    typealias Item = Int   // Concrete type defined
    var items: [Int] = []
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
}

var stack = IntStack()
stack.append(10)
stack.append(20)
print(stack.items) // [10, 20]

Interview Q&A

Q1. How is associated type different from generics?
👉 Generics are defined on functions or types and used at call/initialization time.
👉 Associated types are defined inside protocols; conforming types decide the concrete type.

Q2. Can protocols with associated types be used as a type directly?
👉 No. They are “PATs” (Protocol with Associated Type). You can’t write let x: Container directly. You need generics or type erasure.

Q3. Example of standard library usage?
👉 Sequence protocol has associatedtype Element. Arrays, Sets, and Dictionaries conform by defining Element automatically.

Q4. What is type erasure in this context?
👉 Type erasure wraps a PAT so it can be used as a concrete type. For example, AnySequence<Element> wraps a Sequence to hide its concrete type.


## Q. 75) what is delegate?
Ans

// 1. The Protocol (Delegate)
protocol MyCustomViewDelegate: AnyObject {
    func didTapButton()
}

// 2. The Delegating Object
class MyCustomView: UIView {
    weak var delegate: MyCustomViewDelegate?

    @objc func buttonTapped() {
        // 5. The delegating object notifies its delegate
        delegate?.didTapButton()
    }
}

// 3. The Delegate Object (conforms to the protocol)
class MyViewController: UIViewController, MyCustomViewDelegate {

    let customView = MyCustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 4. Assign the delegate
        customView.delegate = self
    }

    // 3. Implements the delegate method
    func didTapButton() {
        print("Button was tapped inside the custom view!")
        // Handle the event from the custom view
    }
}

Interview Questions and Answers:

1. What problem does the delegate pattern solve?
It decouples code, allowing one object to delegate responsibilities to another without needing explicit knowledge of that object's implementation.

2. Why should delegate properties be declared weak?
To avoid strong reference cycles (retain cycles) and prevent memory leaks, especially when delegates are typically view controllers.

3. Where is the delegate pattern used in iOS frameworks?
Common examples include UITableViewDelegate, UITextFieldDelegate, and UICollectionViewDelegate for handling user interactions.

4. How does the delegate pattern differ from observers or closures?
Delegates create a strict one-to-one relationship and define a clear contract through protocols, while observers enable one-to-many communication and closures are inline, single-use callback blocks.


## Q. 77) difference between Swift 4 , Swift 5 and Swift 6?
Ans

Here is a concise, point-wise comparison highlighting key differences between Swift 4, Swift 5, and Swift 6:

Swift 4
* Introduced significant stability improvements over Swift 3.

* Added Codable protocol for easy JSON encoding and decoding.

* Improved string handling with enhanced Unicode and extended grapheme cluster support.

* Improved dictionary & set algorithms for better performance.

* Enhanced keypaths for strongly typed, key-path expressions.

* Focused on source compatibility without breaking existing Swift 3 code.

Swift 5
* Introduced ABI (Application Binary Interface) stability, enabling smaller app sizes and better compatibility.

* Added Result type for standardized error handling.

* Introduced new string interpolation API for customizable string interpolation.

* Improved Compiler diagnostics and performance.

* Added raw strings syntax, dynamic callable types, and @dynamicCallable.

* Introduced property wrappers to simplify state management (Swift 5.1+).

* Added concurrency features like async/await (in Swift 5.5).

* Binary framework stability allowing Swift libraries to be embedded and reused without recompilation.

Swift 6 (Major Milestone)
* Focuses heavily on strict concurrency enforcement and eliminating data races.

* Requires explicit await keyword for calling actor methods to prevent race conditions.

* Introduces typed throws allowing functions to declare specific error types they throw.

* Added support for regex literals simplifying pattern matching without verbose API calls.

* Introduced noncopyable types to control data copying and transfer ownership, enhancing safety especially for sensitive data.

* Stricter compiler rules for concurrency and actor isolation leading to safer, more predictable asynchronous code.

* Swift 6 brings the culmination of incremental improvements from Swift 5.x series, turning them into enforced language rules.

* Migration to Swift 6 can generate many warnings/errors due to stricter rules, requiring codebase adjustments.



## Q. 78) why Swift is protocol oriented and objective c is not?
Ans

Swift is called a Protocol-Oriented Programming (POP) language because protocols are the primary way to define behavioral blueprints, and Swift allows default implementations, extensions, protocol composition, and generics with associated types.
Objective-C, on the other hand, is primarily Object-Oriented, where classes and inheritance are the main abstraction tools, and protocols are only used as optional “contracts” without default implementations.

In Objective-C (protocols are limited):

* Protocols can only declare method signatures.

* No default implementation → every conforming class must implement all methods.

* Multiple inheritance is not supported, and protocols don’t help with code reuse.


In Swift (protocol-oriented features):

* Protocols can define properties + methods.

* Protocol extensions allow default implementations.

* Supports protocol composition (A & B), associated types, and works seamlessly with generics.

* Promotes composition over inheritance, avoiding class hierarchies.

Q1. Why is Swift called Protocol-Oriented Programming language?
👉 Because it emphasizes protocols as the primary abstraction instead of class inheritance. Protocols define what a type should do, and extensions can provide how. This enables flexible code reuse, avoids deep hierarchies, and encourages composition.

Q2. Why isn’t Objective-C protocol-oriented?
👉 Objective-C protocols cannot provide default implementations. They only declare methods, leaving implementations entirely to conforming classes. This makes protocols weaker compared to Swift, where protocols are first-class citizens with extensions, generics, and associated types.

Q3. What’s the advantage of protocol-oriented over class inheritance?
👉 Protocols allow multiple conformance (a struct can conform to many protocols), promote composition over inheritance, reduce tight coupling, and work with value types (structs/enums) — which classes/inheritance cannot do efficiently.

Q4. Give a real iOS framework example of protocol-oriented design.
👉 UITableViewDataSource and UITableViewDelegate are protocol-based. In Swift, they can even have default implementations via extensions, reducing boilerplate code.



## Q. 80) what is hierarchy of uibutton in ios?
Ans.

In UIKit, every UI component is part of the UIView hierarchy. UIButton is a subclass of UIControl, which itself is a subclass of UIView. This hierarchy gives UIButton all the behaviors of a view (layout, drawing) and control (handling touch events).

NSObject  
   ↳ UIResponder  
        ↳ UIView  
             ↳ UIControl  
                  ↳ UIButton
                  

* NSObject → Base class for most Objective-C classes.

* UIResponder → Adds event-handling (touches, gestures, motion).

* UIView → Provides drawing, layout, animations.

* UIControl → Adds target–action mechanism for user interactions.

* UIButton → A concrete subclass for tap-able buttons with title, image, and state.


## Q. 90) How many ways can you store data locally in iOS (Swift)?
Ans.

In iOS, data can be stored locally in several ways depending on:
* the type of data (small user settings vs. structured records),
* security requirements, and
* persistence needs (temporary vs. permanent).
There are five primary ways to store data locally in Swift:

1️⃣ UserDefaults
Use Case: Store small, lightweight user preferences (like theme, flags, login state).
Storage Type: Key–Value pair storage.
Persists: Across app launches.

Example:
UserDefaults.standard.set(true, forKey: "isLoggedIn")
let loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

Pros: Simple, persistent, easy to use.
Cons: Not secure, not for sensitive or large data.

2️⃣ Keychain
Use Case: Securely store sensitive information (tokens, passwords, certificates).
Storage Type: Encrypted system-managed storage.

Example:
import Security

let password = "MySecret123"
let key = "userPassword"

let data = password.data(using: .utf8)!
let query: [String: Any] = [
    kSecClass as String: kSecClassGenericPassword,
    kSecAttrAccount as String: key,
    kSecValueData as String: data
]
SecItemAdd(query as CFDictionary, nil)

Pros: Secure, encrypted by iOS, survives app reinstalls (if same keychain access group).
Cons: Complex API, slower than UserDefaults.

3️⃣ File System (Documents / Caches Directory)
Use Case: Store custom files like JSON, images, PDFs, or logs.
Storage Type: File-based.

Example:
let fileManager = FileManager.default
let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = url.appendingPathComponent("data.txt")

try? "Hello iOS".write(to: fileURL, atomically: true, encoding: .utf8)

Pros: Flexible for structured or unstructured data.
Cons: Must handle security, data consistency, and size limits manually.

4️⃣ Core Data
Use Case: Store relational or structured data (like user profiles, transactions).
Storage Type: Object graph + SQLite database under the hood.

Example (Simple Insert):
let entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
entity.setValue("Akhilesh", forKey: "name")
try? context.save()

Pros: Fast, supports relationships, queries, and migrations.
Cons: Learning curve, not ideal for lightweight or simple key–value storage.

5️⃣ SQLite / Realm / Third-party Databases
Use Case: Custom database handling with manual SQL or simpler ORMs.
Storage Type: Disk-based database.

Example (SQLite using FMDB or raw C APIs):
import SQLite3
// Open DB, create table, insert rows manually using SQL queries

Pros: Fine-grained control, performant for large datasets.
Cons: Manual management, higher complexity.

Realm Example:
class User: Object {
    @Persisted var name: String
}

let realm = try! Realm()
let user = User()
user.name = "Akhilesh"
try! realm.write {
    realm.add(user)
}


## Q. 93) What are inout parameters in Swift?
Ans.

inout parameters allow a function in Swift to modify the original variable passed into it, not just a local copy.
They provide pass-by-reference behavior instead of Swift’s normal pass-by-value.

❌ Without inout (won’t modify original)

    func increment(_ number: Int) {
    var number = number
    number += 1
    }

    var value = 10
    increment(value)
    print(value) // 10 (unchanged)

✅ With inout (modifies original)
    
    func increment(_ number: inout Int) {
    number += 1
    }

    var value = 10
    increment(&value)
    print(value) // 11


## 94) what is defer in Swift and how it’s work?
Ans.

The defer statement in Swift schedules a block of code to execute automatically just before exiting the current scope (function, loop, or block), regardless of how the exit occurs—via return, break, continue, throw, or natural end.

Example:

    func test() {
    defer {
        print("Outer defer start")

        defer {
            print("Inner defer")
        }

        print("Outer defer end")
    }

    print("Function body")
    }

Output:

    Function body
    Outer defer start
    Outer defer end
    Inner defer


## Q. 95) what is copy on write in Swift?
Ans.

Copy-On-Write (COW) is an optimization technique used in Swift where a copy of a value type (like Array, Dictionary, Set, String) is only created when you attempt to modify it, and only if it is shared with another variable.
    
Meaning:
    
    Swift does NOT immediately duplicate memory when you assign a value type. It delays the copy until a write (mutation) happens.This saves memory and improves performance.
    
Swift value types (like Arrays/Structs) behave like they copy on assignment:
    
    var a = [1, 2, 3]
    var b = a   // looks like a copy

But Swift does NOT copy the array here.
Both a and b share the same underlying storage until one of them is changed.
    
4. Example of COW Behavior

    var a = [1, 2, 3]
    var b = a   // No real copy yet (shared storage)

    // Mutate 'b'
    b.append(4)    // Real copy happens here (write operation)

    print(a)  // [1, 2, 3]
    print(b)  // [1, 2, 3, 4]
    

## Q. 96) what is access controler?
Ans.

Access Control in Swift is a mechanism that restricts how properties, methods, classes, structs, enums, and other entities can be accessed from different parts of your code.

It helps you:
    
    * Encapsulate implementation details
    * Hide internal logic
    * Prevent unwanted usage
    * Maintain clean module boundaries
    
Access Levels in Swift:

1. open (Most permissive)
    
    * Allows access and subclassing/overriding outside the module.
    * Used mainly in frameworks (like UIKit, SwiftUI).

2. public
    
    * Accessible outside the module
    * ❌ Cannot be subclassed or overridden outside the module
    * Framework APIs usually use this
    
3. internal (Default)

    * Accessible anywhere within the same module
    * Not visible outside
    * Most app code uses this level
    
4. fileprivate

    * Accessible only inside the same file
    
5. private (Most Restrictive)

    * Accessible only within the same declaration
    
Example Showing All Levels

    open class A {}         // Accessible + subclassable anywhere
    public class B {}       // Accessible anywhere, but no subclass outside module
    internal class C {}     // Default, only inside module
    fileprivate class D {}  // Only within this file
    private class E {}      // Only inside this scope


## Q. 97) what is code signing?
Ans.

Code Signing is a security mechanism used by Apple to verify that an iOS app is created by a trusted developer and has not been modified after being built.

In simple words:

    Code Signing proves your identity to Apple and ensures your app’s integrity and authenticity.It guarantees the app comes from you and the code hasn’t been tampered with.
    
iOS is a secure platform. Apple does NOT allow apps to run unless:

    1. They are signed with a valid Apple-issued certificate
    2. They have a matching Provisioning Profile
    3. The device trusts that certificate

Code signing ensures:

    ✔ Only trusted developers can install apps
    ✔ Code cannot be altered (prevents hacking/injection)
    ✔ App belongs to a specific Team/Developer ID
    ✔ App works only on authorized devices (in development)
    ✔ Apps can access entitlements securely (Push, Apple Pay, App Groups, Keychain Sharing, etc.)
    
    
## Q. 98) What are the types of Provisioning Profiles in iOS and what are the differences?
Ans.

 Apple provides four types of provisioning profiles. They determine where and how your app can be installed and run.
 
 ✅ 1. Development Provisioning Profile
    Purpose:
        Used for development, debugging, and running apps directly from Xcode on specific registered devices.
    
    Key Features:
    
       * Allows debugging via Xcode
       * Requires Developer Certificate
       * Contains the UDIDs of allowed devices
       * Grants development entitlements, such as:
            * Access to Keychain Sharing
            * Push Notifications (development)
            * App Groups
            * Background Modes
       * Used for writing logs, attaching debugger, breakpoints
    
    Used in:
        
        Local development
        Testing on physical devices

✅ 2. Ad Hoc Provisioning Profile
Purpose:
    Used to distribute apps outside App Store for testing on a limited set of devices.

Key Features:

    No debugging allowed
    Uses Distribution Certificate
    Requires UDIDs of target devices
    Allows distribution outside App Store (but limited supply)
    Max 100 devices per device type (iPhone/iPad etc.)

Used in:
    
    External client testing
    QA team testing
    Beta distributions without TestFlight

✅ 3. App Store Provisioning Profile (Distribution)
Purpose:
    Used for submitting apps to the App Store.

Key Features:
    
    Uses Distribution Certificate
    No device UDIDs required
    No debugging or logging allowed
    Strict entitlements matching
    Code signing prepares app for App Store review & distribution

Used in:
    
    Building release version for App Store
    Creating an archive for App Store Connect upload

✅ 4. Enterprise Provisioning Profile (In-House)
(Available only for Apple Enterprise Program accounts)
Purpose:
    Used to distribute internal apps within a company without App Store or UDIDs.

Key Features:

    No device limits
    No UDIDs required
    Uses In-House Distribution Certificate
    Cannot be publicly distributed
    For internal employees only

Used in:
    
    Private internal apps
    Corporate apps for employees
    Internal SDK test apps


## Q. 99) App state in ios?
Ans.

App states represent the lifecycle stages an iOS app goes through as the system manages it. They describe whether an app is running, active, inactive, suspended, or not running.

In simple words:

    App State = what the app is doing right now and how much the system allows it to execute.
    
    
The five states are:
    
 1. Not Running: 
    
        The app is not running and has either not been launched yet or was terminated by the system or user. It uses no resources in this state.
    
 2. Inactive: 
        
        The app is running in the foreground but is not currently receiving events or user input. This is often a brief transitional state (e.g., when an incoming phone call or SMS message appears, or when the user pulls down the Notification Center).
    
 3. Active: 
    
        This is the main operational state. The app is in the foreground, visible on screen, and actively receiving events and user interactions.
    
 4. Background: 
    
        The app is running in the background and is still executing code, although its UI is no longer visible. Apps typically enter this state when the user taps the Home button or switches to another app. They are given a short amount of time to finish tasks (like saving data) before potentially moving to the next state. Specific apps (like music players or navigation apps) can request permission to run in the background for longer periods.
    
 5. Suspended: 
    
        The app is in the background but is no longer executing any code. The system moves the app to this state automatically to conserve battery life and system resources. The app remains in memory so it can launch quickly, but the OS can terminate it at any time without notification if memory is needed for a foreground app.
        

    class AppDelegate: UIResponder, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            print("→ Not Running → Active")
            return true
        }
    
        func applicationWillResignActive(_ application: UIApplication) {
            print("Active → Inactive")  // Call/Swipe up
        }
    
        func applicationDidEnterBackground(_ application: UIApplication) {
            print("Inactive → Background")  // Save state here
        }
    
        func applicationWillEnterForeground(_ application: UIApplication) {
            print("Background → Inactive")
        }
    
        func applicationDidBecomeActive(_ application: UIApplication) {
            print("Inactive → Active")  // Refresh data
        }
    }

## Q. 101) What are strong, copy, and readonly in iOS (Objective-C & Swift)?
Ans.

    These are property attributes used to control memory management, mutability, and access behavior for properties in Objective-C (and conceptually similar in Swift).
    
1. strong (Default for NSObject)

    strong means the property holds a strong reference to the object.As long as this reference exists, the object cannot be deallocated.

Used for:
    
    Most object properties
    Owning relationships
    Retaining objects

Example
    
    @property (nonatomic, strong) NSString *name;

This means:

    Increment retain count
    Property owns the object
    Object stays alive as long as this property points to it

2. copy
    
    copy creates a new, immutable copy of the object when assigning.Used mainly to protect your property from being changed externally.
    
Example with mutable collections:

    NSMutableString *str = [NSMutableString stringWithString:@"Hello"];
    self.name = str;
    [str appendString:@" World"];

If property was strong, your name would become "Hello World" — unintended mutation.
Using copy:
    
    @property (nonatomic, copy) NSString *name;

Now self.name = str creates a copy → immutable NSString.
Changes to the external mutable string do NOT affect your property.

3. readonly
    Allows reading the property but prevents writing outside the class.

Example
    
    @property (nonatomic, readonly) NSString *token;

You can read:

    NSLog(@"%@", self.token);

But you cannot set:
    
    self.token = @"123";  // ❌ Error

But inside .m implementation, you can redeclare it as readwrite:
    
    @interface MyClass()
    @property (nonatomic, readwrite) NSString *token;
    @end


## Q. 103) static dispatch vs dynamic dispatch?
Ans.

Static dispatch resolves method calls at compile-time (faster, direct calls), while dynamic dispatch resolves them at runtime (flexible, supports polymorphism via vtables). In Swift, static uses structs/enums/functions/generics; dynamic uses classes/protocols.

Examples:
✔ Static Dispatch Example (Struct)

    struct Person {
        func greet() {
            print("Hello")
        }
    }

    let p = Person()
    p.greet()    // Static dispatch

Because structs have no inheritance → compiler picks method at compile time.

✔ Dynamic Dispatch Example (Class Inheritance)

    class Animal {
        func sound() { print("Generic Animal") }
    }

    class Dog: Animal {
        override func sound() { print("Bark") }
    }

    let a: Animal = Dog()
    a.sound()    // Dynamic dispatch (via v-table)

Compiler waits until runtime to find correct method.

Special Cases in Swift

🟦 final → Static Dispatch

    class A {
        final func display() { }
    }
Cannot be overridden → compiler uses static dispatch.

🟦 Private Methods → Static Dispatch
Because private methods cannot be overridden.

🟦 @objc dynamic → Dynamic Dispatch via Objective-C runtime
    
    @objc dynamic func update() { }
Forces runtime method lookup (KVO, method swizzling).

🟦 Protocol Requirements
Depends on conformance:
Protocol witness table (dynamic dispatch but faster than Objective-C)

    protocol Runnable { func run() }

        struct Car: Runnable {
            func run() { print("Car running") }
        }
Dispatch via witness table, not compile-time static, not Obj-C dynamic — somewhere in between.

/* A V-Table (Virtual Method Table) is a runtime data structure used by Swift (and many OOP languages) to support dynamic dispatch.
    It stores function pointers for all methods that can be overridden in a class hierarchy.

    In simple words:
    A V-Table tells Swift which method implementation to call at runtime when using inheritance and overriding. */
    

