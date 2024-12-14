import SwiftUI

class SpotifyViewModel: ObservableObject {
    @Published var playlistURLs: [String] = []
    @Published var inputURL: String = ""

    func addPlaylist() {
        guard isValidSpotifyURL(inputURL) else {
            print(inputURL)
            print("Invalid URL")
            return
        }
        playlistURLs.append(inputURL)
        inputURL = "" // Clear the input field
    }

    private func isValidSpotifyURL(_ url: String) -> Bool {
        // Simple validation for a Spotify playlist URL
        if url.starts(with: "https://open.spotify.com/playlist/") || url.starts(with: "https://open.spotify.com/album/"){
            return true
        }else{
            return false
        }
    }
}
