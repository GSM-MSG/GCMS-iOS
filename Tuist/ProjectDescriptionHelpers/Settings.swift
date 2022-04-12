import ProjectDescription

extension SettingsDictionary{
    static let codeSign = SettingsDictionary()
        .codeSignIdentityAppleDevelopment()
        .automaticCodeSigning(devTeam: "235C2RVZ7L")
}
