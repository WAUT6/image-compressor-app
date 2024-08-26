import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_compressor/pages/home_page/constants/upload_types.dart';

part 'selected_upload_type_event.dart';
part 'selected_upload_type_state.dart';

class SelectedUploadTypeBloc
    extends Bloc<SelectedUploadTypeEvent, SelectedUploadTypeState> {
  SelectedUploadTypeBloc() : super(SelectedUploadTypeStateSingle()) {
    on<SelectedUploadTypeEventSingle>((event, emit) {
      emit(SelectedUploadTypeStateSingle());
    });

    on<SelectedUploadTypeEventBatch>((event, emit) {
      emit(SelectedUploadTypeStateBatch());
    });

    on<SelectedUploadTypeEventCamera>((event, emit) {
      emit(SelectedUploadTypeStateCamera());
    });
  }
}
