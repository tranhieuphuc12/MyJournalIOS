# 📱 MyJournal - iOS App (SwiftUI)  

MyJournal is a **SwiftUI-based iOS application** that allows users to create, view, and manage posts. It connects to a **Node.js (Express.js) backend** with JWT authentication and MongoDB for data storage.  

---

## 🛠 Tech Stack  
- **SwiftUI** for UI  
- **Combine** for data binding  
- **MVVM Architecture**  
- **URLSession** for API calls  
- **JWT Authentication** for secure login  
- **AsyncImage** for image loading  

---

## 📂 Features  
✅ User authentication (Sign up, Login, Logout)  
✅ Secure API requests with JWT tokens  
✅ Fetch and display posts  
✅ Create, edit, and delete posts  
✅ Image upload support  
✅ Adaptive UI for different screen sizes  

---

## 📸 Desgin
https://www.figma.com/design/ama1L7EtojKaM3kUyCUUTc/Fullstack-Node-IOS?node-id=0-1&t=IMehCmF6GqTetFtq-1

---

## 🚀 Installation  

### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/yourusername/MyJournal-iOS.git
cd MyJournal-iOS
```
### **2️⃣ Open in Xcode
Open MyJournal.xcodeproj
Select a simulator or physical device
Run the project (Cmd + R)

---

## 📌 API Integration

The app communicates with a Node.js (Express.js) backend.

### **Authentication (Login & Sign Up)
The app stores the JWT token securely in UserDefaults.
Every API request includes an Authorization header:
```sh
 func fetchPosts(
         completion: @escaping (Result<[Post], Error>) -> Void
    ) {
        guard let token = token else {
            print("No token")
            return
        }
        guard let url = URL(string: "http://localhost:3000/api/posts") else {
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error fetching posts: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(
                        .failure(
                            NSError(
                                domain: "", code: -1,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "No data received"
                                ])))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(
                    self.customISO8601Formatter)
                let posts = try decoder.decode([Post].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            } catch {
                print("Decoding Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()

    }

```

---

## 🛠 Dependencies

This project does not require any external dependencies—it uses only Swift's built-in frameworks.


