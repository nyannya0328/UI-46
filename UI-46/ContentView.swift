//
//  ContentView.swift
//  UI-46
//
//  Created by にゃんにゃん丸 on 2020/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    
    @State var text = ""
    @State var height : CGFloat = 0
    @State var keybordheight : CGFloat = 0
    var body: some View{
        
        VStack{
            
            HStack{
                
                Text("Chat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    Spacer()
                
            }
            .padding()
            .background(Color.white)
            ScrollView(.vertical, showsIndicators: false){
                
                Text("")
                
            }
            
            
            HStack(spacing:15){
                
                textFiled(text: self.$text, height: self.$height)
                    .frame(height:self.height < 150 ? height : 150)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(15)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    
                    Image("p1")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding(10)
                    
                }
                .background(Color.white)
                .clipShape(Circle())
                
                
                
                
            }
            .padding(.horizontal)
            
        }
        .padding(.bottom,keybordheight)
        .background(Color.black.opacity(0.03).edgesIgnoringSafeArea(.bottom))
        
        .onTapGesture {
            UIApplication.shared.windows.first?.rootViewController?.view.endEditing(true)
        }
        
        .onAppear{
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (data) in
                
                let height1 = data.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                
                self.keybordheight = height1.cgRectValue.height - 20
                
            }
            
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
                self.keybordheight = 0
            }
            
        }
        
        
        
        
    }
}


struct textFiled : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return textFiled.Coordinator(parcent1: self)
    }
    
    
    @Binding var text : String
    @Binding var height : CGFloat
    func makeUIView(context: Context) -> UITextView {
        
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Enter"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .green
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
        
        
       
    }
    
    class Coordinator : NSObject,UITextViewDelegate{
        var pacent : textFiled
        
        init(parcent1 : textFiled) {
            pacent = parcent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.pacent.text == ""{
                
                textView.text = ""
                textView.textColor = .gray
                
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if self.pacent.text == ""{
                
                textView.text = "Enter Your Text"
                textView.textColor = .gray
                
            }
        }
        
        
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.pacent.height = textView.contentSize.height
                self.pacent.text = textView.text
            }
        }
        
        
    }
}
