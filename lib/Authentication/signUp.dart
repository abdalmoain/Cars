import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers لكل حقل
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // الحالة
  bool rememberMe = false;
  String countryCode = "+963";
  bool isPerson = true; // true = شخص، false = شركة

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الاسم الأول
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: "الاسم الأول",
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // الاسم الثاني
          TextFormField(
             textAlign: TextAlign.right,
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: "الاسم الثاني",
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // الهاتف + رمز الدولة
          TextFormField(
           
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: "الهاتف",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon:Icon(Icons.phone), 
              suffixIcon: CountryCodePicker(
                onChanged: (code) {
                  setState(() {
                    countryCode = code.dialCode ?? "+963";
                  });
                },
                
                favorite: ['+963', 'SY'],
                initialSelection: 'SY',
                showFlag: true,
                showDropDownButton: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // كلمة المرور
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "كلمة المرور",
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 16),
      
          // اختيار نوع الحساب: شخص أو شركة
          Row(
            children: [
              Radio<bool>(
                activeColor: Colors.blue,
                value: true,
                groupValue: isPerson,
                onChanged: (val) {
                  setState(() {
                    isPerson = val!;
                  });
                },
              ),
              const Text("فرد"),
              const SizedBox(width: 16),
              Radio<bool>(
                 activeColor: Colors.blue,
                 
                value: false,
                groupValue: isPerson,
                onChanged: (val) {
                  setState(() {
                    isPerson = val!;
                  });
                },
              ),
              const Text("شركة"),
            ],
          ),
        
      
          
          
      
          // زر التسجيل
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                String fullPhone = "$countryCode${phoneController.text.trim()}";
                debugPrint("👤 الاسم الأول: ${firstNameController.text.trim()}");
                debugPrint("👤 الاسم الثاني: ${lastNameController.text.trim()}");
                debugPrint("📱 رقم الهاتف: $fullPhone");
                debugPrint("🔑 كلمة المرور: ${passwordController.text.trim()}");
                debugPrint("💼 نوع الحساب: ${isPerson ? "شخص" : "شركة"}");
                debugPrint("✅ تذكرني: $rememberMe");
              },
              child: const Text(
                "تسجيل",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
