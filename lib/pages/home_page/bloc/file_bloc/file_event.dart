part of 'file_bloc.dart';

sealed class FileEvent {}

final class FileEventUploadFiles extends FileEvent {}

final class FileEventUploadFile extends FileEvent {}

final class FileEventTakePicture extends FileEvent {}

final class FileEventTakePictures extends FileEvent {}

final class FileEventResetSelectedFiles extends FileEvent {}
