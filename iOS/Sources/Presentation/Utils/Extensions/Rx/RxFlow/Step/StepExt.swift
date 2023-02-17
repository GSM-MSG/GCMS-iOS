import RxFlow

extension Step {
    var asGCMSStep: GCMSStep? {
        return self as? GCMSStep
    }
}
