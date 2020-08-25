import AWSPolly

extension AWSPollyVoiceId {
    /**
        Return an AWSPollyVoiceId for the given string
    
        - Parameter voiceIdString: The Voice Id name (e.g. ivy) as a string
    
        - Returns: A new AWSPollyVoiceId for the given string, Unknown if no voice id was found.
    */
    static func voiceIdForString(voiceIdString: String) -> AWSPollyVoiceId {
        switch voiceIdString {
            case "ivy": return .ivy
            case "joanna": return .joanna
            case "joey": return .joey
            case "justin": return .justin
            case "kendra": return .kendra
            case "kimberly": return .kimberly
            case "matthew": return .matthew
            case "salli": return .salli
            case "nicole": return .nicole
            case "russell": return .russell
            case "amy": return .amy
            case "brian": return .brian
            case "emma": return .emma
            default: return .unknown
        }
    }
}
