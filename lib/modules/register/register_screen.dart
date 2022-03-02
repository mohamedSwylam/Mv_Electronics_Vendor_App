import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer< RegisterCubit , RegisterStates>(
       listener: (context,state){},
       builder: (context,state){
         return Scaffold(
             appBar: AppBar(),
             body: Center(
               child: Text('Register'),
             ),
         );
       },
    );
  }
}
