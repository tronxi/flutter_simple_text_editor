class FileModel {
  final String absolutePath;
  final String relativePath;
  final bool isDirectory;
  FileModel(
      {required this.absolutePath,
      required this.relativePath,
      required this.isDirectory});
}
