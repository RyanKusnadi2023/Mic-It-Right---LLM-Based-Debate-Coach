import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left") // You can customize this image
                Text("Go Back") // You can customize this text
            }
            .foregroundColor(.blue) // You can customize the color
        }
    }
}
