//this screen is needed to put register and login screen under the auth cubit bloc provider in the widget tree here both will be at same level.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/business_logic/blocs/user/bloc/user_bloc.dart';
import 'package:x/data/models/post.dart';
import 'package:x/presentation/screens/home_screen.dart';
import 'package:x/presentation/screens/login_screen.dart';
import 'package:x/presentation/screens/postscreen.dart';
import 'package:x/presentation/screens/register_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthCubit>().stream,
      initialData: context.read<AuthCubit>().state,
    
    
     builder: (context,snapshot){
      if(snapshot.data is AuthLoggedIn){
        UserBloc userbloc =  UserBloc(authToken: snapshot.data!.authToken!, dio: Dio());

        userbloc.add(GetInitialUserData());

        PostListBloc postListBloc = PostListBloc(authToken: snapshot.data!.authToken!, dio: Dio());


        
        

       return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: userbloc,),
            BlocProvider.value(value: postListBloc),
            
          ], 
          
          child: BlocBuilder<UserBloc,UserState>(builder: (context,state){
            if(state is InitialUserState)
            {
              return Center(child: CircularProgressIndicator());
            }
            else {
              print("home screen");
              return HomeScreen();
            }
          },),
          );
      
        
      } else

      if (snapshot.data is AuthLoginState) {
        return LoginScreen();
      } else {
        return RegisterScreen();
      }
     }
     
     );
  }
}