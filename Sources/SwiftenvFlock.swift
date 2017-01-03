import Flock

public extension Flock {
    static let Swiftenv: [Task] = [
        SwiftenvInstallationTask(),
        SwiftTask()
    ]
}

public extension Config {
    static var swiftVersion: String? = nil
}

private let swiftenv = "swiftenv"
private let location = "$HOME/.swiftenv"

class SwiftenvInstallationTask: Task {
    let name = "install-swiftenv"
    let namespace = swiftenv

    func run(on server: Server) throws {
        try server.execute("git clone https://github.com/kylef/swiftenv.git \(location)")

        let bashrc = "~/.bashrc"

        let swiftenvLoad = [
            "export SWIFTENV_ROOT=\"\(location)\"",
            "export PATH=\"\\$SWIFTENV_ROOT/bin:\\$PATH\"",
            "eval \"\\$(swiftenv init -)\""
        ].joined(separator: "; ")

        try server.execute("sed -i '1i \(swiftenvLoad)' \(bashrc)")
    }
}

class SwiftTask: Task {

    let name = "swift"
    let namespace = swiftenv
    let hookTimes: [HookTime] = [.before("deploy:build")]

    func run(on server: Server) throws {
        if !server.directoryExists(location) {
           try invoke("swiftenv:install-swiftenv")
       }

        guard let swiftVersion = Config.swiftVersion else {
            throw TaskError.error("You must specify in your configuration file which Swift version to install.")
        }

        if let existingSwifts = try server.capture("swiftenv versions"), !existingSwifts.contains(swiftVersion) {
            try server.execute("swiftenv install \(swiftVersion)")
        }

        try server.execute("swiftenv global \(swiftVersion)")
    }

}
