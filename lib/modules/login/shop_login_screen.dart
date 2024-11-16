import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (BuildContext context, state)
        {
          if(state is ShopAppSuccessState)
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
        builder: (BuildContext context, state){
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
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
                          submit: (value)
                          {
                            if(keyForm.currentState!.validate())
                            {
                              ShopAppCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            return null;
                          },
                          suffix: ShopAppCubit.get(context).suffix,
                          isPassword:ShopAppCubit.get(context).isPassword ,
                          pressed: ()
                          {
                            ShopAppCubit.get(context).changePasswordVisibility();

                          }
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopAppLoadingState,
                          builder: (BuildContext context) =>  defaultButton(
                            text: 'LOGIN',
                            function: ()
                            {
                              if(keyForm.currentState!.validate())
                              {
                                ShopAppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,);
                              }

                            },
                            color: Colors.brown,
                          ),
                          fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            textButton(
                              text: 'REGISTER NOW',
                              function:()
                              {
                                navigateTo(context,  ShopRegisterScreen());
                              },
                            ),
                          ],
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
