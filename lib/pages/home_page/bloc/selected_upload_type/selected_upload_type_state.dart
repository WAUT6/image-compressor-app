part of 'selected_upload_type_bloc.dart';

sealed class SelectedUploadTypeState {
  final UploadType uploadType;

  SelectedUploadTypeState({required this.uploadType});
}

final class SelectedUploadTypeStateSingle extends SelectedUploadTypeState {
  SelectedUploadTypeStateSingle() : super(uploadType: UploadType.single);
}

final class SelectedUploadTypeStateBatch extends SelectedUploadTypeState {
  SelectedUploadTypeStateBatch() : super(uploadType: UploadType.batch);
}

final class SelectedUploadTypeStateCamera extends SelectedUploadTypeState {
  SelectedUploadTypeStateCamera() : super(uploadType: UploadType.camera);
}
