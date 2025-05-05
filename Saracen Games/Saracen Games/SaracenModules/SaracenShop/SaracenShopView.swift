import SwiftUI

struct SaracenShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = SGUser.shared
    @State var section: StoreSection? = nil
    @ObservedObject var viewModel: StoreViewModelSG
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            
            
            if let section = section {
                
                if section == .backgrounds {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.shopTeamItems.filter({ $0.section == .backgrounds }), id: \.self) { item in
                            achievementItem(item: item)
                        }
                    }
                    
                } else if section == .skin {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.shopTeamItems.filter({ $0.section == .skin }), id: \.self) { item in
                            achievementItem(item: item)
                        }
                    }
                }
                
                
                
                
            } else {
                VStack(spacing: 60) {
                    
                    Button {
                        withAnimation {
                            section = .backgrounds
                        }
                    } label: {
                        
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "BACKGROUND", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 56:28, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                            
                                .textCase(.uppercase)
                            
                            
                        }
                    }
                    
                    Button {
                        withAnimation {
                            section = .skin
                        }
                    } label: {
                        
                        ZStack {
                            Image(.btnBgSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 180:90)
                            
                            TextWithBorderSaracen(text: "BOAT", font: .system(size: SGDeviceManager.shared.deviceType == .pad ? 56:28, weight: .black), textColor: .white, borderColor: .main, borderWidth: 1)
                            
                                .textCase(.uppercase)
                            
                            
                        }
                    }
                    
                }
            }
            
            
            VStack {
                ZStack {
                    
                    HStack(alignment: .top) {
                        CoinBgSaracen()
                        Spacer()
                        Button {
                            if let section = section {
                                withAnimation {
                                    self.section = nil
                                }
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Image(.homeIconSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 150:75)
                        }
                        
                        
                    }.padding([.horizontal, .top])
                    
                }
                
                Spacer()
            }
        }.background(
            ZStack {
                Image(.menuBgSaracen)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
    
    @ViewBuilder func achievementItem(item: Item) -> some View {
        
        VStack {
            ZStack {
                Image(.shopItemBgSaracen)
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Image(item.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 230:115)
                        .padding(.top, SGDeviceManager.shared.deviceType == .pad ? 40:20)
                    
                    Spacer()
                    
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        Image(.availableTextSaracen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: SGDeviceManager.shared.deviceType == .pad ? 68:34)
                            .padding(.bottom,SGDeviceManager.shared.deviceType == .pad ? 32: 16)
                    } else {
                        ZStack {
                            Image(.priceBgSaracen)
                                .resizable()
                                .scaledToFit()
                            
                            Text("100")
                                .font(.system(size: SGDeviceManager.shared.deviceType == .pad ? 48:24, weight: .black))
                                .foregroundStyle(.white)
                                .offset(x: SGDeviceManager.shared.deviceType == .pad ? 40:20)
                        }
                        .frame(height: SGDeviceManager.shared.deviceType == .pad ? 80:40)
                        .padding(.bottom, SGDeviceManager.shared.deviceType == .pad ? 26:13)
                    }
                }
                
            }.frame(height: SGDeviceManager.shared.deviceType == .pad ? 416:208)
            
            Button {
                if item.section == .skin {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentPersonItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                } else {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        viewModel.currentBgItem = item
                    } else {
                        if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                            
                            if user.money >= item.price {
                                user.minusUserMoney(for: item.price)
                                viewModel.boughtItems.append(item)
                            }
                        }
                    }
                }
            } label: {
                if section == .backgrounds {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        
                        ZStack {
                            
                            if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                                Image(.selectedIconSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                            } else {
                                
                                Image(.lockedIconSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                
                                
                            }
                            
                        }
                        
                    } else {
                        
                        ZStack {
                            Image(.buyBtnSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                            
                        }
                        
                    }
                } else {
                    if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                        
                        ZStack {
                            
                            if let currentItem = viewModel.currentPersonItem, currentItem.name == item.name {
                                Image(.selectedIconSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                            } else {
                                
                                Image(.lockedIconSaracen)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                                
                                
                            }
                            
                        }
                        
                    } else {
                        
                        ZStack {
                            Image(.buyBtnSaracen)
                                .resizable()
                                .scaledToFit()
                                .frame(height: SGDeviceManager.shared.deviceType == .pad ? 100:50)
                            
                            
                        }
                        
                    }
                }
            }
        }
    }
    
}

#Preview {
    SaracenShopView(viewModel: StoreViewModelSG())
}
