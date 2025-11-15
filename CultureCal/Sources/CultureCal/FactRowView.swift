import SwiftUI

struct FactRowView: View {
    let fact: Fact
    let onFavorite: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(fact.title)
                .font(.headline)
            
            Text(fact.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                if let source = fact.source {
                    Link("Source", destination: URL(string: source)!)
                        .font(.caption)
                }
                
                Spacer()
                
                Button(action: onFavorite) {
                    Image(systemName: fact.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}