import PackageDescription

let package = Package(
    name: "SwiftenvFlock",
    dependencies: [
        .Package(url: "/Users/jakeheiser/Desktop/Projects/Swift/Flock", majorVersion: 0, minor: 1)
    ]
)
