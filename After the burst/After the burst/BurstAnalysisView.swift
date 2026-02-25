import SwiftUI

struct BurstAnalysisView: View {
    @State private var showRegisterRelease = false
    @State private var path: SwiftUI.NavigationPath = .init()
    
    var body: some View {
        SwiftUI.NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Title
                    Text("Burst Analysis")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                    
                    // Section 1
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Register & Release")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        FeatureCard(
                            systemImage: "square.and.pencil",
                            text: "This section contains structured prompts to help you analyze and log your anger episodes.",
                            buttonTitle: "Write",
                            accessibilityIdentifier: "writeButton",
                            action: {
                                showRegisterRelease = true
                        
                            }
                        )
                    }
                    
                    // Section 2
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Review & Reflect")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        FeatureCard(
                            systemImage: "folder",
                            text: "This section contains the logs of your anger episodes. Open it only when youb feel ready to understand more about your triggers and review your episodes only with your therapist.",
                            buttonTitle: "Open",
                            action: {
                                path.append("triggers_episodes")
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .sheet(isPresented: $showRegisterRelease) {
                RegisterReleaseView()
            }
            .background {
                // Soft, desaturated blue background similar to the screenshot
                Color(red: 0.90, green: 0.96, blue: 0.98)
                    .ignoresSafeArea()
            }
            .navigationDestination(for: String.self) { value in
                if value == "triggers_episodes" {
                    TriggersEpisodesView()
                }
            }
        }
    }
}

private struct AccessibilityIdentifierModifier: ViewModifier {
    let id: String
    func body(content: Content) -> some View {
        if id.isEmpty {
            content
        } else {
            content.accessibilityIdentifier(id)
        }
    }
}

private struct FeatureCard: View {
    let systemImage: String
    let text: String
    let buttonTitle: String
    var accessibilityIdentifier: String = ""
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
                    )
                Image(systemName: systemImage)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.primary)
            }
            .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button(action: action) {
                    Text(buttonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 51.0/255.0, green: 30.0/255.0, blue: 54.0/255.0))
                .controlSize(.large)
                .modifier(AccessibilityIdentifierModifier(id: accessibilityIdentifier))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview {
    BurstAnalysisView()
        .environment(\.colorScheme, .light)
}

