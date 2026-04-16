import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.events.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.state.dart';
import 'package:oasis/app/categories/presentation/ui/widgets/category_card_skeleton.dart';
import 'package:oasis/app/categories/presentation/ui/widgets/category_screen.widget.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/components/widgets/primary_button.dart';
import 'package:oasis/locator.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CategoriesBloc>()..add(const FetchAllCategoriesEvent()),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(
                title: 'Categories',
                textStyle: textStyle,
                onTap: () => GoRouter.of(context).pop(),
              ),
              const SizedBox(height: 24),
              Text(
                'Explore our collections and find the perfect furniture for your home',
                style: textStyle.headlineSmall,
              ),
              const SizedBox(height: 24),

              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  return switch (state.categoriesStatus) {
                    FetchStatus.initial || FetchStatus.loading => Column(
                      children: List.generate(
                        3,
                        (_) => const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: CategoryCardSkeleton(),
                        ),
                      ),
                    ),
                    FetchStatus.success => Column(
                      children: state.categories
                          .map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CategoryCard(category: category),
                            ),
                          )
                          .toList(),
                    ),
                    FetchStatus.failure => Center(
                      child: Column(
                        children: [
                          Text(
                            state.errorMessage ?? 'Something went wrong',
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: buildSecondaryButton(
                              'Retry',
                              onPressed: () {
                                context.read<CategoriesBloc>().add(
                                  const FetchAllCategoriesEvent(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  };
                },
              ),
              const SizedBox(height: 24),
              const BottomCTA(),
            ],
          ),
        ),
      ),
    );
  }
}
