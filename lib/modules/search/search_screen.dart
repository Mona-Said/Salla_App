import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchController = TextEditingController();
  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: keyForm,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    formField(
                        controller: searchController,
                        label: 'Search',
                        prefix: Icons.search,
                        type: TextInputType.text,
                        function: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        submit: (String? text) {
                          SearchCubit.get(context).search(text!);
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(
                        color: Colors.brown,
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildProductList(
                              SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data?[index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
