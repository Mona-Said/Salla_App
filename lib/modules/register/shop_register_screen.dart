import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/shop_layout_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state)  {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.putData(
                key: 'token',
                value:state.loginModel.data?.token,).then((value)
              {
                token = state.loginModel.data?.token;
                navigateAndFinish(context, const ShopLayoutScreen());
              });
            }else{
              print(state.loginModel.message);
              itemToast(
                text: state.loginModel.message!,
                state: ToastStates.error,
              );

            }
          }
        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        formField(
                          controller: nameController,
                          label: 'User Name',
                          prefix: Icons.person,
                          type: TextInputType.name,
                          function: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        formField(
                          controller: emailController,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          function: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        formField(
                            controller: passwordController,
                            label: 'Password',
                            prefix: Icons.lock_outline_rounded,
                            type: TextInputType.visiblePassword,
                            function: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword:ShopRegisterCubit.get(context).isPassword ,
                            pressed: ()
                            {
                              ShopRegisterCubit.get(context).changePasswordVisibility();

                            }
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        formField(
                          controller: phoneController,
                          label: 'Phone',
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                          function: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) =>  defaultButton(
                            text: 'REGISTER',
                            function: ()
                            {
                              if(keyForm.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name:nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            color: Colors.brown,
                          ),
                          fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
