import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userData;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is ShopAppLoadingUpdateUserDataState)
                      const LinearProgressIndicator(
                        color: Colors.brown,
                      ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    formField(
                      controller: nameController,
                      label: 'Name',
                      prefix: Icons.person,
                      type: TextInputType.name,
                      function: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    formField(
                      controller: emailController,
                      label: 'Email Address',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      function: (String? value) {
                        if (value!.isEmpty) {
                          return 'email address must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    formField(
                      controller: phoneController,
                      label: 'Phone',
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      function: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultButton(
                      text: 'UPDATE',
                      color: Colors.brown,
                      function: () {
                        if (keyForm.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                      text: 'LOGOUT',
                      color: Colors.brown,
                      function: () {
                        logOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
