import 'package:flutter/material.dart';
import '../models/banner_item.dart';

class BannerCarousel extends StatefulWidget {
  final List<BannerItem> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    // Filter active banners that are within date range
    final activeBanners = widget.banners.where((banner) {
      final now = DateTime.now();
      return banner.isActive &&
          now.isAfter(banner.startDate) &&
          now.isBefore(banner.endDate);
    }).toList();

    if (activeBanners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: activeBanners.length,
            itemBuilder: (context, index) {
              final banner = activeBanners[index];
              return _BannerCard(banner: banner);
            },
          ),
        ),
        if (activeBanners.length > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              activeBanners.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final BannerItem banner;

  const _BannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () {
            // Handle banner tap
            print('Banner tapped: ${banner.title}');
            if (banner.actionUrl != null) {
              // Navigate to action URL
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // Background Image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.8),
                        Theme.of(context).primaryColor.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        banner.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        banner.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
