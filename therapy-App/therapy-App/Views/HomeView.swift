//
//  HomeView.swift
//  a1-s4115492
//
//  Created by Johnson Chang on 2026/8/29.
//

import SwiftUI

struct HomeView: View {


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24){
                    // MARK: Recent section (cards side by side)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent")
                            .font(.title2)
                            .fontWeight(.semibold)

                        HStack(spacing: 16) {
                            ForEach(recentShelves) { shelf in
                                NavigationLink {
                                    DiaryDetailView(diary: shelf)
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(shelf.icon)
                                        Text(shelf.title)
                                            .font(.callout)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.primary)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
                                    .background(Color(.secondarySystemBackground))
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    // MARK: All section (tappable list rows)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("All")
                            .font(.title2)
                            .fontWeight(.semibold)

                        VStack(spacing: 0) {
                            ForEach(diaryShelves) { shelf in
                                NavigationLink {
                                    DiaryDetailView(diary: shelf)
                                } label: {
                                    HStack {
                                        Text(shelf.icon)
                                        Text(shelf.title)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding()
                                }
                                Divider()
                            }
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .toolbar {
                  ToolbarItemGroup(placement: .navigationBarTrailing) {
                      // Search
                      Button {
                      } label: {
                          Image(systemName: "magnifyingglass")
                      }
                      // More options
                      Button {
                      } label: {
                          Image(systemName: "ellipsis")
                      }
                  }
              }
            }
        }
    }
}

#Preview {
    HomeView()
}
