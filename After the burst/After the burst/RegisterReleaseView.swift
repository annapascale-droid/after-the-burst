import SwiftUI

final class RegisterReleaseViewModel: ObservableObject {
    // ViewModel logic can be added here if needed
}

struct RegisterReleaseView: View {
    @StateObject var viewModel = RegisterReleaseViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 0.85, green: 0.92, blue: 0.98)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 150, height: 150)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color.blue)
                    }
                    
                    Text("Register & Release")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Please ensure all details are correct before proceeding. This action cannot be undone.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: {
                    // Start button action here
                }) {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Register & Release")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RegisterReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterReleaseView()
        }
    }
}

