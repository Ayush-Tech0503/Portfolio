import 'package:flutter/material.dart';

import 'loading_indicator_widget.dart';

class ImageGrid extends StatelessWidget {
  final List<String> images;
  final bool loading;
  final VoidCallback loadMore;
  final void Function(String imageUrl) onImageTap;

  const ImageGrid({super.key,
    required this.images,
    required this.loading,
    required this.loadMore,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: images.length + 1,
      itemBuilder: (context, index) {
        if (index == images.length) {
          return loading
              ? loadingIndicator()
              : ElevatedButton(
            onPressed: loadMore,
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Load More', style: TextStyle(fontSize: 16.0, color: Colors.white)),
          );
        }

        final imageUrl = images[index];
        return GestureDetector(
          onTap: () => onImageTap(imageUrl),
          child: Hero(
            tag: imageUrl,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                    ),
                    Center(
                      child: Icon(Icons.search, color: Colors.white.withOpacity(0.6), size: 50),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
