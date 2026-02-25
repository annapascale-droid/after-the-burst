import SwiftUI

struct ReflectionFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: RegisterReleaseViewModel
    
    // MARK: - Init
    
    init(viewModel: RegisterReleaseViewModel = RegisterReleaseViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Form State
    
    @State private var bodyNotice: String = ""
    @State private var connectedThoughts: String = ""
    @State private var trigger: String = ""
    
    enum ControlState: String, CaseIterable {
        case inControl = "In Control"
        case outOfControl = "Out Of Control"
    }
    
    @State private var controlState: ControlState? = nil
    @State private var underlyingFeelings: String = ""
    @State private var navigateToBurstAnalysis: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    NavigationLink(destination: BurstAnalysisView(), isActive: $navigateToBurstAnalysis) { EmptyView() }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Spacer()
                            
                            formSection(
                                title: "Where did I notice the anger in my body?",
                                text: $bodyNotice
                            )
                            
                            formSection(
                                title: "What thoughts were connected to my anger?",
                                text: $connectedThoughts
                            )
                            
                            formSection(
                                title: "What triggered my episode of anger?",
                                text: $trigger
                            )
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("Did it make me feel out of control or in control?")
                                    .font(.headline)
                                
                                VStack(spacing: 12) {
                                    
                                    radioRow(
                                        title: ControlState.inControl.rawValue,
                                        isSelected: controlState == .inControl
                                    ) {
                                        controlState = .inControl
                                    }
                                    
                                    radioRow(
                                        title: ControlState.outOfControl.rawValue,
                                        isSelected: controlState == .outOfControl
                                    ) {
                                        controlState = .outOfControl
                                    }
                                }
                            }
                            
                            formSection(
                                title: "What underlying feelings might have fueled my anger?",
                                text: $underlyingFeelings
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    
                    // MARK: - Bottom Button
                    
                    Button {
                        viewModel.release()
                    } label: {
                        Text(viewModel.isLoading ? "Saving..." : "Done")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .background(Color(red: 0.29, green: 0.13, blue: 0.23))
                    .clipShape(Capsule())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
            .presentationDetents([.fraction(0.9), .large])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
            .fullScreenCover(isPresented: $viewModel.isReleased) {
                NavigationStack {
                    CompletionView {
                        viewModel.reset()
                        dismiss()
                        navigateToBurstAnalysis = true
                    }
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func formSection(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            RoundedTextArea(text: text)
        }
    }
    
    @ViewBuilder
    private func radioRow(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .frame(width: 22, height: 22)
                    if isSelected {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.systemBackground))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Rounded Text Area

private struct RoundedTextArea: View {
    
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.90, green: 0.96, blue: 0.98))
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(10)
                .frame(minHeight: 110)
                .background(Color.clear)
            
            if text.isEmpty {
                Text("Write here...")
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
            }
        }
    }
}

#Preview {
    ReflectionFormView()
}
