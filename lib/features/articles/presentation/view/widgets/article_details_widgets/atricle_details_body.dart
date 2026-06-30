import 'package:flutter/material.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/article_block.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/atricle_details_image_widget.dart';
import 'package:medicore_app/features/articles/presentation/view/widgets/article_details_widgets/atricle_details_text_widget.dart';

class AtricleDetailsBody extends StatelessWidget {
  final String body;

  const AtricleDetailsBody({required this.body});

  @override
  Widget build(BuildContext context) {
    final blocks = _parseBody(body);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(blocks.length, (index) {
        final block = blocks[index];

        if (block is TextBlock) {
          return AtricleDetailsTextWidget(text: block.text, index: index);
        } else if (block is ImageBlock) {
          return AtricleDetailsImageWidget(url: block.url, index: index);
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  List<ArticleBlock> _parseBody(String body) {
    final result = <ArticleBlock>[];
    final regex = RegExp(r'\[(.*?)\]');
    final matches = regex.allMatches(body);

    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        final text = body.substring(lastIndex, match.start).trim();
        if (text.isNotEmpty) result.add(TextBlock(text));
      }

      final raw = match.group(1)?.trim() ?? '';
      final url = raw.replaceAll('[', '').replaceAll(']', '').trim();

      if (_isImage(url)) {
        result.add(ImageBlock(url));
      } else {
        result.add(TextBlock(raw));
      }

      lastIndex = match.end;
    }

    if (lastIndex < body.length) {
      final text = body.substring(lastIndex).trim();
      if (text.isNotEmpty) result.add(TextBlock(text));
    }

    return result;
  }

  bool _isImage(String url) {
    return url.startsWith('http');
  }
}

