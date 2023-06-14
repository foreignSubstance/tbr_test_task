import 'dart:convert';

import 'package:flutter/material.dart';

import '../api_call.dart';
import '../models/launch_images_model.dart';
import '../models/rocket_model.dart';
import '../models/update_view_model.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.7,
  );

  int _currentPage = 0;
  List<ImageModel> allImageLinks = [];
  final List<Widget> _pages = [];
  static final Future _imagesFuture = getLaunchImages();

  @override
  void initState() {
    super.initState();
    responseToLaunchesImages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 180,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                UpdateViewProvider.of(context)?.provideCurrentPage(page);
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              var banner = _pages[index];
              var scale = _currentPage == index ? 1.0 : 0.9;
              return TweenAnimationBuilder(
                  tween: Tween(begin: scale, end: scale),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: banner,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  });
            },
          ),
        ),
        indicatorWidget(
            pagesNumber: _pages.length,
            currentPageIndex: _currentPage,
            controller: _controller),
      ],
    );
  }

  void responseToLaunchesImages() async {
    _imagesFuture.then((value) {
      setState(() {
        Iterable list = json.decode(value.body);
        allImageLinks =
            list.map((model) => ImageModel.fromJson(model)).toList();
        for (ImageModel item in allImageLinks) {
          if (item.imageLinks.length == 4) {
            for (String singleImage in item.imageLinks) {
              _pages.add(carouselBanner(imageUrl: singleImage));
            }
            break;
          }
        }
      });
    });
  }
}

Widget carouselBanner({required String imageUrl}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(
      imageUrl,
      fit: BoxFit.fill,
    ),
  );
}

Widget indicatorWidget(
    {required int pagesNumber,
    required int currentPageIndex,
    required PageController controller}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List<Widget>.generate(
      pagesNumber,
      (index) => InkWell(
        onTap: () {
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: currentPageIndex == index ? Colors.white : Colors.black,
              shape: BoxShape.circle),
        ),
      ),
    ),
  );
}
