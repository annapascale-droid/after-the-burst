import Foundation
import Combine

final class RegisterReleaseViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false
    @Published var isReleased: Bool = false
    
    // MARK: - Initialization
    
    init() { }
    
    // MARK: - Intents
    
    func register() {
        isLoading = true
        errorMessage = nil
        
        // Simulate registration process
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.isRegistered = true
        }
    }
    
    func release() {
        isLoading = true
        errorMessage = nil
        
        // Simulate release process
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.isReleased = true
        }
    }
    
    func reset() {
        isLoading = false
        errorMessage = nil
        isRegistered = false
        isReleased = false
    }
}
