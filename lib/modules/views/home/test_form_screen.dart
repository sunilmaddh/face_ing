import 'package:flutter/material.dart';

class FormValidationScreen extends StatefulWidget {
  const FormValidationScreen({super.key});

  @override
  _FormValidationScreenState createState() => _FormValidationScreenState();
}

class _FormValidationScreenState extends State<FormValidationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Focus Nodes
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  // Auto validation mode for Email
  AutovalidateMode emailAutoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        setState(() {
          emailAutoValidate = AutovalidateMode.onUserInteraction;
        });
      }
    });
  }

  // Name Validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  // Email Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AutoValidate Specific Field")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name Field (NO AutoValidation)
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                decoration: InputDecoration(labelText: "Name"),
                validator: validateName,
              ),
              SizedBox(height: 10),

              // Email Field (AutoValidation Enabled When Focused)
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: emailAutoValidate, // Only email has auto-validation
                validator: validateEmail,
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Form is Valid!")),
                    );
                  }
                },
                child: Text("Submit Form"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
