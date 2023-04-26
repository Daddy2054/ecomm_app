import 'package:ecomm_app/base/base_consumer_state.dart';
import 'package:ecomm_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends BaseConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(dashboardControllerProvider.select(
      (value) => value.pageIndex,
    ));
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (value) => _onItemTapped(value, context),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: Colors.green,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: [
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home_filled,
          ),
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.shopify,
          ),
          icon: Icon(
            Icons.shopping_bag,
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.settings,
          ),
          icon: Icon(
            Icons.settings_applications,
          ),
          label: 'Settings',
        ),
      ],
    );
  }




  void _onItemTapped(int index, BuildContext context) {
    ref.read(dashboardControllerProvider.notifier).setPageIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');

        break;
      case 1:
        GoRouter.of(context).go('/cart');

        break;
      case 2:
        GoRouter.of(context).go('/setting ');

        break;

      default:
    }
  }
}
