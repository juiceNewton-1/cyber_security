import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cyber_security/generated/assets.gen.dart';
import 'package:cyber_security/widgets/modules/home/articles/views/articles_view.dart';
import 'package:cyber_security/widgets/modules/home/cards/views/cards_view.dart';
import 'package:cyber_security/widgets/modules/home/complexity/view/complexity_view.dart';
import 'package:cyber_security/widgets/modules/home/passwords/views/passwords_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _currentIndex = 0;

  final _bottomNavItems = [
    _BottomNavItem(
      inactive: Assets.icons.cards,
      active: Assets.icons.cardsActive,
    ),
    _BottomNavItem(
      inactive: Assets.icons.passwords,
      active: Assets.icons.passwordsActive,
    ),
    _BottomNavItem(
      inactive: Assets.icons.complexity,
      active: Assets.icons.complexityActive,
    ),
    _BottomNavItem(
      inactive: Assets.icons.articles,
      active: Assets.icons.articlesActive,
    ),
  ];

  void _selectModule(int index) => setState(() => _currentIndex = index);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _bottomNavItems.length,
            (index) => _BottomNavItemWidget(
              bottomNavItem: _bottomNavItems[index],
              isActive: _currentIndex == index,
              onPressed: () => _selectModule(index),
            ),
          ),
        ),
      ),
      body: [
        CardsView(),
        PasswordsView(),
        ComplexityView(),
        ArticlesView(),
      ][_currentIndex],
    );
  }
}

class _BottomNavItemWidget extends StatelessWidget {
  final _BottomNavItem bottomNavItem;
  final bool isActive;
  final VoidCallback? onPressed;
  const _BottomNavItemWidget({
    required this.bottomNavItem,
    required this.isActive,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child:
          isActive ? bottomNavItem.active.svg() : bottomNavItem.inactive.svg(),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
    );
  }
}

class _BottomNavItem {
  final SvgGenImage inactive;
  final SvgGenImage active;

  _BottomNavItem({
    required this.inactive,
    required this.active,
  });
}
