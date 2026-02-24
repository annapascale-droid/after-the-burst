import SwiftUI

struct ReflectionFormView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var bodyNotice: String = ""
    @State private var connectedThoughts: String = ""
    @State private var trigger: String = ""
    enum ControlState: String, CaseIterable { case inControl = "In Control", outOfControl = "Out Of Control" }
    @State private var controlState: ControlState? = nil
    @State private var underlyingFeelings: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                // Subtle side bands with light blue
                Color.white.ignoresSafeArea()
                HStack(spacing: 0) {
                    Color(red: 0.90, green: 0.96, blue: 0.98)
                    Color.white
                    Color(red: 0.90, green: 0.96, blue: 0.98)
                }
                .ignoresSafeArea()
                .opacity(0.5)

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            formSection(title: "Where did I notice the anger in my body?", text: $bodyNotice)
                            formSection(title: "What thoughts were connected to my anger?", text: $connectedThoughts)
                            formSection(title: "What triggered my episode of anger?", text: $trigger)

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Did it make me feel out of control or in control?")
                                    .font(.headline)
                                    .foregroundStyle(.primary)

                                VStack(spacing: 12) {
                                    radioRow(title: ControlState.inControl.rawValue, isSelected: controlState == .inControl) {
                                        controlState = .inControl
                                    }
                                    radioRow(title: ControlState.outOfControl.rawValue, isSelected: controlState == .outOfControl) {
                                        controlState = .outOfControl
                                    }
                                }
                            }

                            formSection(title: "What underlying feelings might have fueled my anger?", text: $underlyingFeelings)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.clear)
                    }

                    // Bottom bar button
                    VStack(spacing: 0) {
                        Divider().opacity(0)
                        Button(action: { dismiss() }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .background(Color(red: 0.29, green: 0.13, blue: 0.23)) // deep purple
                        .clipShape(Capsule())
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            // Background to lift the button from bottom
                            Color.white.opacity(0.001)
                                .ignoresSafeArea(edges: .bottom)
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .tint(.secondary)
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
                .foregroundStyle(.primary)
            RoundedTextArea(text: text)
        }
    }

    @ViewBuilder
    private func radioRow(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(.primary)
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

private struct RoundedTextArea: View {
    @Binding var text: String
    @State private var isEditing: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.90, green: 0.96, blue: 0.98))
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(10)
                .frame(minHeight: 110)
                .background(Color.clear)
                .onTapGesture { isEditing = true }
                .onDisappear { isEditing = false }
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
