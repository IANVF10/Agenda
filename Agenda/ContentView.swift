import SwiftUI

struct ContentView: View {
    @State var maxCircleHeight: CGFloat = 0
    @State var showRegister = false // Segun su estado se muestra el Registro o el Login
    
    var body: some View {
        VStack{
            GeometryReader{proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                DispatchQueue.main.async {
                    if maxCircleHeight == 0{
                        maxCircleHeight = height
                    }
                }
                return AnyView(
                    ZStack{
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: getRect().width/2, y: -height/1.3)
                        Circle()
                            .fill(Color("dark"))
                            .offset(x: -getRect().width/2, y: -height/1.5)
                        Circle()
                            .fill(Color("lightPink"))
                            .offset(y: -height/1.3)
                            .rotationEffect(.init(degrees: -7))
                    }
                )
            }
            .frame(maxHeight: getRect().height)
            ZStack{
                if showRegister{
                    RegisterPage()
                }else{
                    LoginPage()
                }
            }
            .padding(.top, -maxCircleHeight/1.6)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Button(action: {
                    withAnimation{
                        showRegister.toggle()
                    }
                }, label: {
                    Text(showRegister ? "Estoy Registrado" : "Quiero registrarme")
                        .fontWeight(.bold)
                        .foregroundColor(Color("lightPink"))
                })
            }, alignment: .bottom
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View{

    func getRect() ->CGRect{
        return UIScreen.main.bounds
    }

    func getSafeArea() ->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets
        ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
    }
}
