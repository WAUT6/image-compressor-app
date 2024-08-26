part of 'file_bloc.dart';

sealed class FileState {
  final Exception? error;

  FileState({this.error});
}

final class FileStateNoFilesUploaded extends FileState {
  FileStateNoFilesUploaded({super.error});
}

// Uploaded States
abstract final class FileStateUploaded extends FileState {
  FileStateUploaded({super.error});
}

final class FileStateFilesUploaded extends FileStateUploaded {
  final List<XFile> files;

  FileStateFilesUploaded({required this.files, super.error});
}

final class FileStateFileUploaded extends FileStateUploaded {
  final XFile file;

  FileStateFileUploaded({required this.file, super.error});
}
