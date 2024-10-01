import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/app/presentation/bloc/category/category_bloc.dart';
import 'package:inventory/app/presentation/bloc/category/page/widgets/add_category_button.dart';
import 'package:inventory/app/presentation/bloc/category/page/widgets/search_category_card.dart';
import 'package:inventory/app/presentation/constants/app_color.dart';
import '../category_event.dart';
import '../category_state.dart';
import 'category_list_item.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCategoryButton(
        categoryController: categoryController,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .1),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColor.white,
                    ),
                  ),
                  Expanded(
                    child: SearchCategoryCard(
                      searchController: searchController,
                      onSearch: (String? query) {
                        if (query == null) {
                          context.read<CategoryBloc>().add(FetchCategory());
                        } else {
                          context
                              .read<CategoryBloc>()
                              .add(SearchCategory(query));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocListener<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state is CategoryError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CategoryLoaded) {
                      final categories = state.categories;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryListItem(
                            category: categories[index],
                            onEdit: (updatedCategory) {
                              context
                                  .read<CategoryBloc>()
                                  .add(EditCategory(updatedCategory));
                            },
                            onDelete: (categoryId) {
                              context
                                  .read<CategoryBloc>()
                                  .add(DeleteCategory(categoryId));
                            },
                          );
                        },
                      );
                    } else if (state is CategoryError) {
                      return const Center(child: Text('Tidak Ada Data'));
                    }
                    return const Center(child: Text('Tidak Ada Data'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
