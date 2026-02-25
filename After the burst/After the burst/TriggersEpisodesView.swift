import SwiftUI

struct TriggersEpisodesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selection = 0
    
    private let triggers = [
        "Stress",
        "Lack of Sleep",
        "Skipping Meals",
        "Weather Change",
        "Strong Odors"
    ]
    
    private let episodes = [
        "Episode 1 - Headache",
        "Episode 2 - Fatigue",
        "Episode 3 - Nausea",
        "Episode 4 - Dizziness",
        "Episode 5 - Irritability"
    ]
    
    var body: some View {
        VStack {
            Picker("", selection: $selection) {
                Text("My triggers").tag(0)
                Text("My episodes").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            if selection == 0 {
                List {
                    ForEach(triggers, id: \.self) { item in
                        Text(item)
                    }
                }
                .listStyle(.plain)
            } else {
                VStack() {
                    
                    Spacer()
                    
                    Image(systemName: "lock.icloud")
                        .font(.system(size: 120))
                        .foregroundColor(.primary)
                    
                    Text("""
                    This is not the ideal place
                    to retrace the episode. For
                    your peace of mind, the
                    details remain guarded
                    until your next therapy
                    session.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 36)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.headline)
                }
            }
        }
        .background(
            Color(red: 0.90, green: 0.96, blue: 0.98)
                .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    TriggersEpisodesView()
}
