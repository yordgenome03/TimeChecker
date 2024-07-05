//
//  ClosableNumberField.swift
//  TimeChecker
//
//  Created by yotahara on 2024/07/04.
//

import SwiftUI
import UIKit

struct ClosableNumberField: UIViewRepresentable {
    @Binding var value: Int
    var placeholder: String
    var font: UIFont
    var textAlignment: NSTextAlignment
    var horizontalPadding: CGFloat
    var maxWidth: CGFloat
    let formatter = NumberFormatter()
    
    init(value: Binding<Int>,
         placeholder: String,
         font: UIFont = UIFont.preferredFont(forTextStyle: .title2),
         textAlignment: NSTextAlignment = .center,
         horizontalPadding: CGFloat = 8,
         maxWidth: CGFloat = 64) {
        
        self._value = value
        self.placeholder = placeholder
        self.font = font
        self.textAlignment = textAlignment
        self.horizontalPadding = horizontalPadding
        self.maxWidth = maxWidth
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.keyboardType = .numberPad
        
        textField.font = font
        textField.textAlignment = textAlignment
        
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: horizontalPadding,
                                               height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "閉じる", style: .plain, target: context.coordinator, action: #selector(Coordinator.doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        
        context.coordinator.textField = textField
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = formatter.string(from: NSNumber(value: value))
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: ClosableNumberField
        var textField: UITextField?
        
        init(_ parent: ClosableNumberField) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let currentText = textField.text else { return true }
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            let intValue = Int(prospectiveText) ?? 0
            
            let font = textField.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
            let size = (prospectiveText as NSString).size(withAttributes: [.font: font])
            
            if size.width <= parent.maxWidth {
                parent.value = intValue
                return true
            } else {
                return false
            }        }
        
        @objc func doneButtonTapped() {
            textField?.resignFirstResponder()
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var num: Int = 0
        
        var body: some View {
            ClosableNumberField(value: $num, placeholder: "整数を入力してください")
                .fixedSize()
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
                .padding()
        }
    }
    
    return Preview()
}
