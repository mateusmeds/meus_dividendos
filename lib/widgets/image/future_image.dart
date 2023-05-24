import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class FutureImage extends StatefulWidget {
  const FutureImage({Key? key, this.urlImage}) : super(key: key);
  final String? urlImage;

  @override
  State<FutureImage> createState() => _FutureImageState();
}

class _FutureImageState extends State<FutureImage> {
  String image =
      "<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'><svg xmlns='http://www.w3.org/2000/svg' width='50' height='50'><rect width='50' height='50' fill='grey' /></svg>";
  double height = 50;
  double width = 50;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SvgPicture?>(
        future: loadSvg(widget.urlImage),
        builder: (context, state) {
          if (state.hasData) {
            return state.data!;
          } else if (state.hasError) {
            print('Erro ao carregar SVG');
            return SizedBox.shrink();
          } else {
            return Container(
              color: Colors.grey,
              width: width,
              height: height,
            );
          }
        });
  }

  Future<SvgPicture?> loadSvg(String? url) async {
    if (url == null || url.isEmpty) {
      return SvgPicture.string(image, width: width, height: height);
    }
    final response = await http.get(Uri.parse(url));

    if (response.body.contains('<defs>')) {
      return SvgPicture.string(image, width: width, height: height);
    }

    // Carrega todas as referências externas encontradas no arquivo SVG
    final RegExp regExp = RegExp(r'href="([^"]*)"');
    final matches = regExp.allMatches(response.body);
    for (Match match in matches) {
      final String href = match.group(1)!;
      if (href.startsWith('http') || href.startsWith('https')) {
        await http.get(Uri.parse(href));
      }
    }

    return SvgPicture.network(
      url,
      allowDrawingOutsideViewBox: true,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}
