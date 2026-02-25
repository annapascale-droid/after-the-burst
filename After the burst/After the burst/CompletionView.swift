import SwiftUI

struct CompletionView: View {
    @Environment(\.dismiss) private var dismiss
    
    var onFinish: () -> Void
    
    var body: some View {
        
        ZStack {
            
            // Background soft blue
            Color(red: 0.90, green: 0.96, blue: 0.98)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 24) {
                
//                Spacer()
                
                Image(systemName: "hands.sparkles")
                    .font(.system(size: 64))
                    .foregroundColor(Color(red: 0.29, green: 0.13, blue: 0.23))
                
                Text("Registration completed. Every detail you've added is a piece of the puzzle we're putting together.")
                .font(.title3)
                .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 50)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onFinish()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    struct PreviewHost: View {
        @State private var show = true
        var body: some View {
            Color.clear
                .sheet(isPresented: $show) {
                    CompletionView(onFinish: {})
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
        }
    }
    return PreviewHost()
}
