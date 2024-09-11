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
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var dessertList: some View {
        ForEach(viewModel.desserts) { dessert in
            NavigationLink {
                DessertDetailView(dessertId: dessert.id)
            } label: {
                dessertCell(dessert: dessert)
            }
        }
    }
    
    @ViewBuilder
    private func dessertCell(dessert: Dessert) -> some View {
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

struct Dessert: Identifiable {
    let id: String
    let title: String
    let imageUrl: String
}

#Preview {
    NavigationStack {
        DessertListView()
    }
}
