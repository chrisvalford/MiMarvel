//
//  DiscoverCollectionView.swift
//  MiMarvel
//
//  Created by Christopher Alford on 4/8/21.
//

import SwiftUI

struct DiscoverCollectionView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Comics", destination: ComicsCollectionView())
                NavigationLink("Characters", destination: CharactersCollectionView())
                NavigationLink("Series", destination: SeriesCollectionView())
                NavigationLink("Graphic Novels", destination: NovelsCollectionView())
                NavigationLink("Contributors", destination: ContributorsCollectionView())
            }
            .navigationTitle("Discover")
        }
    }
}

struct DiscoverCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCollectionView()
    }
}
