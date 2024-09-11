import SwiftUI

struct DessertListView: View {
    @StateObject var viewModel = DessertListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                dessertList
            }
        }
        .onAppear {
            viewModel.getData()
        }
        .refreshable {
            viewModel.getData()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var dessertList: some View {
        if !viewModel.meals.isEmpty {
            ForEach(viewModel.meals) { dessert in
                NavigationLink {
                    DessertDetailView(dessertId: dessert.id)
                } label: {
                    dessertCell(dessert: dessert)
                }
            }
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .font(.body.bold())
        }
    }
    
    @ViewBuilder
    private func dessertCell(dessert: Meal) -> some View {
        HStack {
            AsyncImageView(imageSize: viewModel.imageSize, imageUrl: dessert.imageUrl)
            Text(dessert.title)
                .font(.body.bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .border(.black)
    }
}

#Preview {
    NavigationStack {
        DessertListView()
    }
}
