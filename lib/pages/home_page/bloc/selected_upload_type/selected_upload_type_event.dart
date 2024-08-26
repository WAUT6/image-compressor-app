part of 'selected_upload_type_bloc.dart';

sealed class SelectedUploadTypeEvent {}

final class SelectedUploadTypeEventSingle extends SelectedUploadTypeEvent {}

final class SelectedUploadTypeEventBatch extends SelectedUploadTypeEvent {}

final class SelectedUploadTypeEventCamera extends SelectedUploadTypeEvent {}
