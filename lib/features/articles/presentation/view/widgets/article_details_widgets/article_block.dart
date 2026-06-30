abstract class ArticleBlock {}

class TextBlock extends ArticleBlock {
  final String text;
  TextBlock(this.text);
}

class ImageBlock extends ArticleBlock {
  final String url;
  ImageBlock(this.url);
}
