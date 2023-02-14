//
//  StorageManager.swift
//  untitledtvproject
//
//  Created by Emil Åkerman on 2023-02-14.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseStorage
import Foundation

public class StorageManager: ObservableObject {
    let storage = Storage.storage()
    @Published var profileImage = UIImage()

    func upload(image: UIImage) {
        // Create a storage reference
        let storageRef = storage.reference().child("images/image.jpg")

        // Resize the image to 200px with a custom extension
        let resizedImage = image.aspectFittedToHeight(200)

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.2)

        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }

                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
/*
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // List all items in the images folder
        storageRef.listAll { (result, error) in
          if let error = error {
            print("Error while listing all files: ", error)
          }

          for item in result.items {
            print("Item in images folder: ", item)
          }
        }
    }*/
    /*
    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images/image.jpg")

        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }

            let item = result.items
            print("item: ", item)
        }

        // List the items
        //storageRef.downloadURL()
        //storageRef.list(maxResults: 1, completion: handler)
    }*/
    func downloadItem() {
        let profileView = ProfileView(selectedUserName: "")
        let storageRef = storage.reference().child("images/image.jpg")

        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
            print("error downloading image from storage")
          } else {
              print("trying to download image")
              self.profileImage = UIImage(data: data!)!
          }
        }
      }
        // You can use the listItem() function above to get the StorageReference of the item you want to delete
    func deleteItem(item: StorageReference) {
        item.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }
}
extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
