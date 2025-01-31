import 'package:flutter/material.dart';
import 'dart:html' as html;

class ImageLoadView extends StatefulWidget {
  const ImageLoadView({super.key});

  @override
  State<ImageLoadView> createState() => _ImageLoadViewState();
}

class _ImageLoadViewState extends State<ImageLoadView> {
  final TextEditingController _urlController = TextEditingController();
  bool isMenuOpen = false;

  void _loadImage() {
    String imageUrl = _urlController.text;
    if (imageUrl.isNotEmpty) {
      html.ImageElement img = html.ImageElement()
        ..id = 'custom-image'
        ..src = imageUrl
        ..style.maxWidth = '100%'
        ..style.height = '100%'
        ..onDoubleClick.listen((event) => _toggleFullscreen());

      // Remove previous image and add new one
      html.document.getElementById('image-container')?.children.clear();
      html.document.getElementById('image-container')?.append(img);
    }
  }

  void _toggleFullscreen() {
    html.document.fullscreenElement == null ? html.document.documentElement?.requestFullscreen() : null;
  }

  void _exitFullScreen() {
    html.document.exitFullscreen();
  }

  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void _closeMenu() {
    setState(() {
      isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isMenuOpen ? _closeMenu : null,
      child: Scaffold(
        backgroundColor: isMenuOpen ? Colors.black.withOpacity(0.5) : null,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Displaying the HTML image inside a registered view
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: HtmlElementView(viewType: 'image-container'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _urlController,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Image URL",
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _loadImage,
                        style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isMenuOpen) ...[
                      _buildMenuItem("Enter Fullscreen", _toggleFullscreen),
                      _buildMenuItem("Exit Fullscreen", _exitFullScreen),
                      const SizedBox(height: 10),
                    ],
                    FloatingActionButton(
                      onPressed: _toggleMenu,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
        _closeMenu();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)],
        ),
        child: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
