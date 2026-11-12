import 'package:flutter/material.dart';
import 'package:weathery/view/widgets/weather_search_field.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const HomeHeader({
    super.key,
    required this.onRefresh,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) => SliverAppBar(
    expandedHeight: 220,
    collapsedHeight: 220,
    toolbarHeight: 0,
    pinned: false,
    floating: false,
    stretch: true,
    automaticallyImplyLeading: false,
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/cloud-in-blue-sky.jpg', fit: BoxFit.cover),
          Container(color: const Color(0xff087bab).withValues(alpha: .2)),
          const Positioned(
            left: 22,
            bottom: 100,
            child: Text(
              'WEATHERY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: WeatherSearchField(
              controller: searchController,
              onSearch: onSearch,
            ),
          ),
        ],
      ),
    ),
  );
}
