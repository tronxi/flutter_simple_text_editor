class FileModel {
  final String absolutePath;
  final String relativePath;
  final bool isDirectory;
  FileModel(
      {required this.absolutePath,
      required this.relativePath,
      required this.isDirectory});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileModel &&
        other.absolutePath == absolutePath &&
        other.relativePath == relativePath &&
        other.isDirectory == isDirectory;
  }

  @override
  int get hashCode {
    return absolutePath.hashCode ^ relativePath.hashCode ^ isDirectory.hashCode;
  }
}
