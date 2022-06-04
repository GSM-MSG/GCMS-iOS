import Foundation

extension String {
    func clubTitleRegex() -> String {
        let strArr = Array(self)
        
        let pattern = "^[가-힣a-zA-Z0-9-]$"
        
        var resultString = ""
        if strArr.count > 0 {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
                var index = 0
                while index < strArr.count {
                    let checkString = regex.matches(in: String(strArr[index]), options: [], range: NSRange(location: 0, length: 1))
                    if checkString.count == 0 {
                        index += 1
                    }
                    else {
                        resultString += String(strArr[index])
                        index += 1
                    }
                }
            }
            return resultString
        }
        else {
            return self
        }
    }
}
