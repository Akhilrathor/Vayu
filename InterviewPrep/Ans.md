1) what is difference between subclass & extension?

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


2)  what is difference between subclass SOAP and REST?(API)

| Category            | SOAP                                                                 | REST                                                                       |
|---------------------|----------------------------------------------------------------------|----------------------------------------------------------------------------|
| **Stands for**      | Simple Object Access Protocol                                        | Representational State Transfer                                            |
| **What is it?**     | SOAP is a protocol for communication <br> between applications       | REST is an architecture style <br> for designing communication             |
| **Design**          | SOAP API exposes the operation.                                      | REST API exposes the data.                                                 |
| **Transport Protocol** | SOAP is independent and can work <br> with any transport protocol. | REST works only with HTTPS.                                                |
| **Data format**     | SOAP supports only XML <br> data exchange.                           | REST supports XML, JSON, <br> plain text.                                  |
| **Performance**     | SOAP messages are larger, <br> which makes communication slower.     | REST has faster performance due to <br> smaller messages and caching.      |
| **Scalability**     | SOAP is difficult to scale. <br> The server maintains state by <br> storing all previous messages. | REST is easy to scale. <br> It’s stateless, so every message <br> is processed independently. |
| **Security**        | SOAP supports encryption <br> with additional overheads.             | REST supports encryption <br> without affecting performance.               |
| **Use case**        | SOAP is useful in legacy applications <br> and private APIs.         | REST is useful in modern applications <br> and public APIs.                |


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


