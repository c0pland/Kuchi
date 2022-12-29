struct Profile: Codable {
  /// (Selected) name of the learner.
  var name: String
  
  /// Initialises a new `Profile` with an empty `name`.
  init() {
    self.name = ""
  }
  
  /// Initialises a new `Profile` with a specified name.
  ///  - Parameters:
  ///     - name Name of the user profile.
  init(named name: String) {
    self.name = name
  }
}
