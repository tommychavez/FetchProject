import SwiftUI

struct DessertDetailView: View {
    @StateObject var viewModel: DessertDetailViewModel
    
    init(dessertId: String) {
        self._viewModel = .init(
            wrappedValue: .init(
                dessertId: dessertId
            )
        )
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                if let mealDetail = viewModel.mealDetail {
                    AsyncImageView(imageSize: viewModel.imageSize, imageUrl: mealDetail.mealThumb)
                    instructions(instructions: mealDetail.instructions)
                    ingredients(mealDetail.ingredients)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.getData()
        }
        .refreshable {
            viewModel.getData()
        }
        .navigationTitle(viewModel.mealDetail?.meal ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func instructions(instructions: String) -> some View {
        HStack(alignment: .top) {
            viewModel.collapsableImage
                .foregroundColor(.red)
                .font(.body.bold())
                .onTapGesture {
                    viewModel.collapsablePressed()
                }
            if viewModel.expand {
                Text(instructions)
            } else {
                Text(instructions)
                    .lineLimit(5)
            }
        }
    }
    
    @ViewBuilder
    private func ingredients(_ ingredients: [Ingredient]) -> some View {
        Text("Ingredients")
            .font(.body.bold())
        ForEach(ingredients) { ingredient in
            HStack {
                Text(ingredient.name)
                    .font(.body.bold())
                Text(ingredient.measure)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MealDetail {
    let id: String
    let meal: String
    let instructions: String
    let mealThumb: String
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable, Identifiable {
    let id: String
    let name: String
    let measure: String
    
    init(name: String?, measure: String?) {
        self.name = name ?? ""
        self.measure = measure ?? ""
        self.id = UUID().uuidString
    }
}

#Preview {
    NavigationStack {
        DessertDetailView(dessertId: "52856")
    }
}
