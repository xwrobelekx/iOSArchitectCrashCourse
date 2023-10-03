# The purpose of this iOS Architect Crash Course is to learn how to:
 - Identify, fix and avoid common anit patterns in code.
 - How do deliver high-quality apps on time following good principles.

# Exploring and applying SOLID principles:
- Single Responsibility Principle (SRP) - A class should have only one reason to change. This means a class should have only one responsibility or job. By ensuring that a class addresses only one concern, you can avoid entangling multiple functionalities together, which can lead to better separation of concerns and easier maintenance.
- Open/Closed Principle (OCP) - Software entities (classes, modules, functions, etc.) should be open for extension but closed for modification. This means that the behavior of a module can be extended without modifying its source code. One common way to achieve this is by using interfaces or abstract classes.
- Liskov Substitution Principle (LSP) - Subtypes must be substitutable for their base types without altering the correctness of the program. In other words, if a class is a subtype of another class, it should be able to be used in place of its parent class without causing unexpected behavior.
- Interface Segregation principle (ISP) - Clients should not be forced to depend on interfaces they do not use. This means that instead of having one large, all-encompassing interface, it's often better to break it down into smaller, more specific interfaces so that a client class only needs to know about the methods that are of interest to it.
- Dependency Inversion Principle (DIP) - High-level modules should not depend on low-level modules. Both should depend on abstractions. Also, abstractions should not depend on details. Details should depend on abstractions. This principle often is realized through the use of interfaces or abstract classes, ensuring that higher-level components depend on an abstraction and not on the concrete implementation of lower-level components.


- Implicit vs Expilicit Dependencies
- Global dependencies (Singletons) vs Depenedency Injection
- Converting procedural code (if else) to be more Polimorfic 


## Spotting principal violations:
- "Open Closed Principle" - We should be able to add or change behavior without changing the exisiting code, especially if we want to reuse it in other context. (if else statments is a good inidcation of this violaiton)
- "Liskov Substitution Principle" - If you have an interface that accepts a specific input or implements a specific interfece, and you call a method, and it crashes it violates this priniciple. Usually when you see fatalErrors or that it accepts "Any" type is a good indication of this prinicple vioilation.






# iOS Architect Crash Course • September 25th to October 1st 2023 • EssentialDeveloper.com

https://iosacademy.essentialdeveloper.com/ios-architect-crash-course/september-2023-d7cd/

It's time to put your skills to the test!

This is the project used in the iOS Architect Crash Course lectures.

Watch the lectures and implement what you learned into this project to practice applying architectural patterns while refactoring legacy code into clean code with clean architecture.

---

## Instructions

1) Open the `iACC.xcodeproj` project on Xcode 14.3.1 or 15.0.

	- Older Xcode versions are not supported.
	- Beta Xcode versions are not supported.

2) The project already comes with a comprehensive suite of automated tests. Throughout the refactoring, run all tests with CMD+U after changing the code.

3) Commit every time you make a change, and the tests pass. This way, you have a working state to revert to if needed.

	- If a test fails, a behavior of the system is broken. Revert your changes to the previous commit with all tests passing and try again.

4) The project should build without warnings.

5) The code should be carefully organized and easy to read (e.g., indentation must be consistent).

Happy coding!
