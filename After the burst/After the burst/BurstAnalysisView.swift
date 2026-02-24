import SwiftUI

struct BurstAnalysisView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Title
                    Text("Burst Analysis")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.primary)
                        .padding(.top, 8)
                    
                    // Section 1
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Register & Release")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        FeatureCard(
                            systemImage: "pencil.and.outline",
                            text: "This section contains structured prompts to help you analyze and log your anger episodes.",
                            buttonTitle: "Write",
                            action: {
                                // TODO: Navigate to writing flow
                            }
                        )
                    }
                    
                    // Section 2
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Review & Reflect")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        FeatureCard(
                            systemImage: "text.book.closed",
                            text: "Review episodes for your next session and track triggers to build awareness. Handle with care: visit only when grounded.",
                            buttonTitle: "Open",
                            action: {
                                // TODO: Navigate to review flow
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background {
                // Soft, desaturated blue background similar to the screenshot
                Color(red: 0.90, green: 0.96, blue: 0.98)
                    .ignoresSafeArea()
            }
        }
    }
}

private struct FeatureCard: View {
    let systemImage: String
    let text: String
    let buttonTitle: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.background)
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
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button(action: action) {
                    Text(buttonTitle)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.accentColor)
                .controlSize(.large)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview {
    BurstAnalysisView()
        .environment(\.colorScheme, .light)
}
