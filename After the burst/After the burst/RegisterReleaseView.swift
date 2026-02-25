import SwiftUI

struct RegisterReleaseView: View {
    @StateObject var viewModel: RegisterReleaseViewModel
    @State private var showReflection = false
    
    init(viewModel: RegisterReleaseViewModel = RegisterReleaseViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            if showReflection {
                ReflectionFormView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        ZStack {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .foregroundColor(Color.blue)
                        }
                        
                        Text("Register & Release")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("Only open this space when you feel ready. If you still feel tension, breathe and come back later: your serenity matters more. ")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding()
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showReflection = true
                        }
                    }) {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.29, green: 0.13, blue: 0.23))
                            .cornerRadius(15)
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationTitle("Register & Release")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RegisterReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterReleaseView(viewModel: RegisterReleaseViewModel())
        }
    }
}

