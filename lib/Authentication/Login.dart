import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:sooqall/Authentication/signUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool rememberMe = false;
  String countryCode = "+963"; // الرمز الافتراضي
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
      height: isMobile ? size.height * 0.6 : 500;

    return Scaffold(
     
  resizeToAvoidBottomInset: false,
  

      backgroundColor: Color(0xFF1e1e1e),
      // Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // الصورة الدائرية بالمنتصف
       Image.asset("assets/images/Logo.png"
       ,width: 130,
       height: 150,
       fit: BoxFit.contain,
       ),
            const SizedBox(height: 16),

            // البورد الخارجي
            Container(
  width: isMobile ? size.width * 0.9 : 400,
  height: isMobile ? size.height * 0.6 : 450,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Column(
    
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tabs
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Colors.blue,
                    tabs: const [
                      Tab(text: "تسجيل الدخول"),
                      Tab(text: "تسجيل"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // محتوى التبويبات
                Expanded(
                    
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // شاشة تسجيل الدخول
                        _buildLoginForm(),
                        // شاشة التسجيل (فارغة مؤقتاً)
                        SignUp(),
                        // const Center(child: Text("صفحة التسجيل")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          // الهاتف + رمز الدولة
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              
              labelText: "الهاتف",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(Icons.phone),
              suffixIcon: CountryCodePicker(
                onChanged: (code) {
                  setState(() {
                    countryCode = code.dialCode ?? "+963";
                  });
                },
                initialSelection: 'SY',
                favorite: ['+963', 'SY'],
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
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // الانتقال الى صفحة نسيت كلمة المرور
                },
                child: const Text(
                  "نسيت كلمة المرور؟",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              // checkbox + text مع بعض
              Row(
                children: [
                  Checkbox(
                    // checkColor: Colors.blue,
                    activeColor: Colors.blue,
                    value: rememberMe,
                    onChanged: (val) {
                      setState(() {
                        rememberMe = val ?? false;
                      });
                    },
                  ),
                  const Text("تذكرني"),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // زر تسجيل الدخول
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                String fullPhone = "$countryCode${phoneController.text.trim()}";
                String password = passwordController.text.trim();
                debugPrint("📱 رقم الهاتف: $fullPhone");
                debugPrint("🔑 كلمة المرور: $password");
              },
              child: const Text(
                "تسجيل الدخول",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
