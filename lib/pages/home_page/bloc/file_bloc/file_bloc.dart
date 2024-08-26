import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final ImagePicker _imagePicker = ImagePicker();
  FileBloc() : super(FileStateNoFilesUploaded()) {
    on<FileEventUploadFile>((event, emit) async {
      final XFile? file =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(FileStateFileUploaded(file: file));
      }
    });

    on<FileEventUploadFiles>((event, emit) async {
      final List<XFile> files = await _imagePicker.pickMultiImage();
      if (files.isNotEmpty) {
        emit(FileStateFilesUploaded(files: files));
      }
    });

    on<FileEventResetSelectedFiles>((event, emit) {
      emit(FileStateNoFilesUploaded());
    });
  }
}
