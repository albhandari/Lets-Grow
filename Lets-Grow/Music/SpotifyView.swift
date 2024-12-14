//
//  SpotifyView.swift
//  Lets-Grow
//
//  Created by Alex Bhandari on 12/13/24.
//

import SwiftUI

struct SpotifyView: View {
    @StateObject private var viewModel = SpotifyViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Spotify Logo and Header
            HStack(spacing: 10) {
                Image(systemName: "music.note") // Replace with Spotify logo if available
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)

                Text("Your Study Playlists")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding(.top, 20)

            // TextField and Add Button
            HStack(spacing: 10) {
                TextField("Enter Spotify Playlist URL", text: $viewModel.inputURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 10)
                    .frame(height: 50)

                Button(action: {
                    viewModel.addPlaylist()
                }) {
                    Text("Add Playlist")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }

            // Display List of Playlists
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(viewModel.playlistURLs.enumerated()), id: \ .element) { index, url in
                        HStack {
                            Image("spotify")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text("Your Playlist \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Link("Go to your playlist >", destination: URL(string: url)!)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview {
    SpotifyView()
}
