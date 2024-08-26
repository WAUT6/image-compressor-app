import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_compressor/pages/home_page/bloc/file_bloc/file_bloc.dart';
import 'package:image_compressor/pages/home_page/bloc/selected_upload_type/selected_upload_type_bloc.dart';
import 'package:image_compressor/themes/constants/theme_constants.dart';

class FileUpload extends StatelessWidget {
  final double width;
  const FileUpload({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedUploadTypeBloc, SelectedUploadTypeState>(
      builder: (context, uploadTypeState) {
        return GestureDetector(
          onTap: () {
            if (uploadTypeState is SelectedUploadTypeStateSingle) {
              context.read<FileBloc>().add(
                    FileEventUploadFile(),
                  );
            } else if (uploadTypeState is SelectedUploadTypeStateBatch) {
              context.read<FileBloc>().add(
                    FileEventUploadFiles(),
                  );
            } else {
              context.read<FileBloc>().add(
                    FileEventUploadFile(),
                  );
            }
          },
          child: Container(
            width: width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ThemeConstants.primaryColor.withOpacity(0.8),
                width: 1,
              ),
            ),
            child: BlocBuilder<FileBloc, FileState>(
              builder: (context, state) {
                if (state is FileStateUploaded) {
                  return FutureBuilder(
                    future: state is FileStateFileUploaded
                        ? state.file.readAsBytes()
                        : state is FileStateFilesUploaded
                            ? state.files.first.readAsBytes()
                            : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: Image.memory(snapshot.data as Uint8List)
                                  .image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/file-upload.svg",
                          width: width / 10,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _generateUploadText(uploadTypeState),
                          style: TextStyle(
                            color: ThemeConstants.primaryColor,
                            fontSize: width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  String _generateUploadText(SelectedUploadTypeState state) {
    if (state is SelectedUploadTypeStateSingle) {
      return "Upload File";
    } else if (state is SelectedUploadTypeStateBatch) {
      return "Upload Files";
    } else {
      return "Take Picture";
    }
  }
}
