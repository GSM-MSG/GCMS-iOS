import ProjectDescription

extension SettingsDictionary{
    static let codeSign = SettingsDictionary()
        .codeSignIdentityAppleDevelopment()
        .automaticCodeSigning(devTeam: "A2XNRK33B9")
}
