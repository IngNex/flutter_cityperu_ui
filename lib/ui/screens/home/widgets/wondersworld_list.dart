import 'package:flutter/material.dart';
import 'package:flutter_cityperu_ui/data/memory_cityperu.dart';
import 'package:flutter_cityperu_ui/domain/models/cityperu_models.dart';
import 'package:vector_math/vector_math.dart' as vector;

class WondersWorldList extends StatefulWidget {
  const WondersWorldList({
    Key? key,
    this.onSelected,
  }) : super(key: key);
  final ValueChanged<CityPeru>? onSelected;
  @override
  State<WondersWorldList> createState() => _WondersWorldListState();
}

class _WondersWorldListState extends State<WondersWorldList> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  final _pageController = PageController();

  double page = 0.0;

  void _listenScroll() {
    setState(() {
      page = _pageController.page ?? 0;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      controller: _pageController,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      initialItemCount: cityPeru.length,
      itemBuilder: (context, index, animation) {
        final images = cityPeru[index];
        final percent = page - page.floor();
        final factor = percent > 0.5 ? (1 - percent) : percent;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              cityPeru.insert(cityPeru.length, images);
              _animatedListKey.currentState!.insertItem(cityPeru.length - 1);
              final itemToDelete = images;
              widget.onSelected!(images);

              cityPeru.removeAt(index);

              // Animation List
              _animatedListKey.currentState!.removeItem(
                index,
                (context, animation) => FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: ImageItem(images: itemToDelete),
                  ),
                ),
              );
            },
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(vector.radians(90 * factor)),
              child: ImageItem(images: images),
            ),
          ),
        );
      },
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.images,
  });

  final CityPeru images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 150,
      child: Stack(
        children: [
          Image(
            width: 140,
            height: 150,
            image: AssetImage(images.imageBack),
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.grey.withOpacity(0.4)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 25,
            child: Text(
              images.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 5,
            child: Text(
              images.city,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
