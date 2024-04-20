import 'dart:io' ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/presentation/widgets/custom_button.dart';
import 'package:x/presentation/widgets/custom_textfield.dart';
import 'package:x/presentation/widgets/custom_passwordfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  File? _image;  
  
  Future<void> _getImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedFile!= null)
      {
        setState(){
          _image = File(pickedFile.path);
        }
      }

  }




  @override
  Widget build(BuildContext context) {
     var dimensions = MediaQuery.of(context).size;
     print("here");
    return Scaffold(
     
      body: BlocListener<AuthCubit,AuthState> (
        listener: (context,state ) 
        {
          print(state);
            if(state is AuthFailedRegister)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                )
              );
            }
        
        
        },// tried using consumer here but didnt used cause then the whole UI will be in builder as no child widget in consumer.
        // child: Container(
        //   color: Colors.blue,
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child:Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      const SizedBox(height: 50),
                  Text('Create new account',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Please fill in the form to continue'),
                  const SizedBox(height: 70),
                  CustomTextFormField(
                    label: 'Email',
                    iconData: Icons.person,
                    textEditingController: emailController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Email cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),   CustomPasswordFormField(
                    label: 'Password',
                    iconData: Icons.person,
                    textEditingController: passwordController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Password cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    label: 'Full Name',
                    iconData: Icons.person,
                    textEditingController: fullNameController,
                    validator: (p0) =>
                        p0!.isEmpty ? 'Name cannot be empty' : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   if (_image != null)
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                   TextButton(
                    onPressed: _getImage,
                    child: Text(
                      'Upload Profile Picture',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 70,
                  ),
                  BlocBuilder<AuthCubit,AuthState>(builder:
                  (context,state){
                    return CustomButton(
                      dimensions: dimensions,
                      action: state is AuthLoadingResgister? null: (){
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState!.validate())
                        {
                          context.read<AuthCubit>().register(
                            email: emailController.text,
                            password: passwordController.text,
                            name: fullNameController.text,
                            profilePic: _image
                          );
                        }
                      },
                      child: state is AuthLoadingResgister? const CircularProgressIndicator():
                      Text('Create Account',
                      style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                  ),
                      )
                      ,
                    );
                  }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an Account?",
                        style: TextStyle(),
                      )
                      ,
                      TextButton(onPressed: (){
                        context.read<AuthCubit>().navigateToLogin();
                      }, child:  Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                        ),)
                    ]
                  )
                ],
              )
            )
          )
        ) 
        
      )
    );
  }
}