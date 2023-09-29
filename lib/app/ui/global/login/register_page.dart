import 'package:dictionary/app/controllers/authentication_controller.dart';
import 'package:dictionary/app/controllers/regsiter_controller.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/widgets/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_functions/zezis_functions.dart';
import 'package:zezis_widget/zezis_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _ = Get.put(RegisterController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final AuthenticationController _auth = Get.put(AuthenticationController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent),

      body: Obx(() =>  _.loading.value ? const Center(child: ZLoadingCustom(radius: 30)) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Form(
            key: _key,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
          
                Text(
                  'Welcome \n Sign Up', 
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 24, 
                    fontWeight: FontWeight.w600,
                  ),
                ),
          
                const SizedBox(height: 10),
          
                Text(
                  'Hello, I guess you are new around here. You can start using the application after sign up.', 
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.roboto(color: Colors.grey),
                ),
          
                const SizedBox(height: 30),
                
                TextFormCustom(
                  padding: const EdgeInsets.all(0),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _.textName.value,
                  hintText: 'Name',
                  autofocus: false,
                  
                  prefixIcon: Icon(Icons.person_rounded, color: Get.theme.primaryColor),
          
                  validator: (value) {
                    if (_.textEmail.value.text.isNullOrEmpty()) { return "Name invalid."; }
                    else { return null; }
                  },
                ),
                
                const SizedBox(height: 20),
           
                TextFormCustom(
                  padding: const EdgeInsets.all(0),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _.textEmail.value,
                  hintText: 'E-mail',
                  autofocus: false,
                  
                  prefixIcon: Icon(Icons.email_rounded, color: Get.theme.primaryColor),
          
                  validator: (value) {
                    if (_.textEmail.value.text.isNullOrEmpty()) { return "E-mail invalid."; }
                    else { return null; }
                  },
                ),
                
                const SizedBox(height: 20),
          
                TextFormCustom(
                  padding: const EdgeInsets.all(0),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: _.textPassword.value,
                  hintText: 'Password',
                  obscureText: true,
                  autofocus: false,
                  
                  prefixIcon: Icon(Icons.vpn_key_rounded, color: Get.theme.primaryColor),
          
                  validator: (value) {
                    if (_.textPassword.value.text.isNullOrEmpty()) { return "Password invalid."; }
                    else { return null; }
                  },
                ),
          
                GestureDetector(
                  onTap: () => setState(() => _auth.changeToRemeber = !_auth.toRemember),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            value: _auth.toRemember,
                            onChanged: (v) => setState(() => _auth.changeToRemeber = !_auth.toRemember),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => _auth.changeToRemeber = !_auth.toRemember),
                          child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "to Remember",
                              style: GoogleFonts.roboto(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                const SizedBox(height: 30),
          
                GestureDetector(
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Get.theme.primaryColor,
                    ),
                    
                    child: Center(
                      child: Text(
                        'Sign Up', 
                        style: GoogleFonts.roboto(
                          fontSize: 18, 
                          color: Colors.white, 
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ),
                  ),
          
                  onTap: () async {
                    var f = _key.currentState?.validate() ?? false;
                    if (f) { await _.register(); }
                  },
                ),
          
                const SizedBox(height: 50),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 17, 
                        color: const Color(0xff757999),
                      )
                    ),
          
                    const SizedBox(width: 5),
          
                    GestureDetector(
                      onTap: () => Get.offAndToNamed(Routes.login),
                      child: Text(
                        'Sign In', 
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 17, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                )
              ],
            ),
          ),
        ),
      ))
    );
  }
}