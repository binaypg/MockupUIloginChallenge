//
//  LoginView.swift
//  login
//
//  Created by Binay Kumar Sharma on 22/12/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var vm:LoginVM = LoginVM()
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 16) {
                Image("logo")
                    .padding(.top,40)
                    .padding(.bottom,100)
                
                CustomTextField(icon: "person.fill", title: "Username", hint: "Login Name", value: $vm.username, showPassword: .constant(false))
                
                    .onChange(of: vm.username) { nVal in
                        vm.checkUsernameError()
                    }
                
                Text(vm.usernameError)
                    .foregroundColor(Color.red).frame(maxWidth: .infinity, alignment: .leading)
                
                CustomTextField(icon: "key.fill", title: "Password", hint: "Login Credentials", value: $vm.password, showPassword: $vm.showPassword).padding(.vertical)
                    .onChange(of: vm.password) { newValue in
                        vm.checkPasswordError()
                    }
                Text(vm.passwordError)
                    .foregroundColor(Color.red).frame(maxWidth: .infinity, alignment: .leading)
                
                
                CustomTextField(icon: "at", title: "Email address", hint: "Email", value: $vm.email, showPassword: .constant(false))
                    .onChange(of: vm.email) { newValue in
                        vm.checkEmailError()
                    }
                Text(vm.emailError)
                    .foregroundColor(Color.red).frame(maxWidth: .infinity, alignment: .leading)
                
                
                
                HStack{
                    Spacer()
                    Text("Forgotten password?")
                        .foregroundColor(Color.theme.primary200)
                        .font(.custom(CustomFont.InterMedium500, size: CustomFont.Size.size15))
                }.padding(.bottom,40)
                
                Button {
                    vm.isFormValid()
                } label: {
                    Text("LOGIN")
                        .font(.custom(CustomFont.InterSemiBold600, size: CustomFont.Size.size20))
                        .foregroundColor(Color.theme.textPrimary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                .background(
                    Color.theme.primary
                )
                .cornerRadius(12.9)
                
                HStack(alignment: .center, spacing: 8, content: {
                    Text("Don't have an account?")
                        .foregroundColor(Color.theme.textFooter)
                    Button{
                        
                    }label: {
                        Text("Sign up")
                            .foregroundColor(Color.theme.primary200)
                        
                    }
                })
                    .font(.custom(CustomFont.InterRegular, size: CustomFont.Size.size15))
                    .padding()
                
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.theme.background
            )
        }
        .alert(vm.showingAlertMsg, isPresented: $vm.showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    
    
    @ViewBuilder
    func CustomTextField(icon:String,title:String,hint:String,value:Binding<String>,showPassword:Binding<Bool>)->some View{
        VStack{
            HStack{
                if title.contains("Password"){
                    Image(systemName:icon).foregroundColor(Color.theme.inputIcon)
                        .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                        .rotationEffect(.degrees( 120))
                }
                else{
                    Image(systemName:icon).foregroundColor(Color.theme.inputIcon)
                }
                
                if title.contains("Password") && !showPassword.wrappedValue{
                    SecureField(hint,text: value)
                        .foregroundColor(Color.theme.inputText)
                    
                }else{
                    TextField(hint, text: value)
                        .foregroundColor(Color.theme.inputText)
                }
                
            }
            .padding()
            .background(
                Color.theme.border
            )
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(value.wrappedValue.isEmpty ? Color.theme.inputFloat : Color.theme.primary, lineWidth: 0.5))
            .overlay(alignment: .leading){
                VStack(alignment: .leading, spacing: 0, content: {
                    Text(title)
                        .font(.custom(CustomFont.InterMedium500, size: CustomFont.Size.size12))
                        .foregroundColor(Color.theme.inputFloat)
                        .padding(.horizontal,6)
                        .background(
                            Rectangle()
                                .fill(Color.theme.background)
                                .frame(maxWidth: .infinity)
                                .frame(height: 3)
                            
                            
                        )
                        .cornerRadius(20)
                        .padding(.top,-35)
                        .padding(.leading,16)
                })
            }
        }
        .overlay(
            VStack{
                if title.contains("Password"){
                    HStack{
                        Spacer()
                        Button(action: {
                            showPassword.wrappedValue.toggle()
                        }, label: {
                            Image(systemName: showPassword.wrappedValue ? "eye.fill" : "eye.slash.fill"   )
                                .foregroundColor(Color.theme.primary200)
                        }).padding(.trailing,8)
                    }
                }
            }
        )
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 8")
    }
}
