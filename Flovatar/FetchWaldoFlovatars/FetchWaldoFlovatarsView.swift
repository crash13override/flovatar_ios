//
//  FetchWaldoFlovatarsView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 10.02.2022.
//

import SwiftUI

struct FetchWaldoFlovatarsView: View {
    
    @EnvironmentObject private var navigationUtil: NavigationUtil
    
    @ObservedObject private var viewModel: FetchWaldoFlovatarsViewModel = FetchWaldoFlovatarsViewModel()
    
    var body: some View {
        ZStack {
            Color.blue
            LoadingView()
            
            NavigationLink(
                destination: WhereIsWaldoView(viewModel: WhereIsWaldoViewModel(flovatars: viewModel.flovatars)),
                isActive: $viewModel.fetchWaldoFlovatarsDidEnd
            ) { EmptyView() }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    navigationUtil.backToRoot()
                    viewModel.flovatars.removeAll()
                } label: {
                    ZStack {
                        Image("home")
                            .resizable()
                            .frame(width: 22, height: 22.5)
                            .offset(y: -2)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.fuchsia)
                    .clipShape(Circle())
                }
                .padding(.leading)
        )
    }
}

#if DEBUG
struct FetchWaldoFlovatarsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FetchWaldoFlovatarsView()
        }
    }
}
#endif
