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
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.body.bold())
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
        .onDisappear {
            viewModel.onDisappear()
        }
        .navigationTitle(viewModel.mealDetail?.meal ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func instructions(instructions: String) -> some View {
        Text(viewModel.instructionsTitle)
            .font(.body.bold())
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
        Text(viewModel.ingredientsTitle)
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

#Preview {
    NavigationStack {
        DessertDetailView(dessertId: "52856")
    }
}
