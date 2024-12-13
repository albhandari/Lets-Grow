import SwiftUI

struct ItemDetailView: View {
    let item: ShopItem
    var onBuy: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.name)
                .font(.title)
                .padding(.top)
            
            Text(item.description)
                .font(.body)
                .padding(.horizontal)
            
            Text("Cost: \(item.cost)")
                .font(.headline)
            
            Button("Buy") {
                onBuy()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ItemDetailView(item: ShopItem(id: "default_pet", name: "Default Pet", description: "It is a default pet", cost: 100, category: "default", imageURL: "default_pet")) {
        print("Hello")
    }
}
