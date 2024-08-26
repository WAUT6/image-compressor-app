import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_compressor/pages/home_page/bloc/file_bloc/file_bloc.dart';
import 'package:image_compressor/pages/home_page/bloc/selected_upload_type/selected_upload_type_bloc.dart';
import 'package:image_compressor/pages/home_page/constants/upload_types.dart';
import 'package:image_compressor/themes/constants/theme_constants.dart';

class UploadOptionsRow extends StatefulWidget {
  final double height;
  final double width;
  final VoidCallback singleFileOnPressed;
  final VoidCallback multipleFilesOnPressed;
  final VoidCallback cameraOnPressed;
  const UploadOptionsRow({
    super.key,
    required this.height,
    required this.width,
    required this.singleFileOnPressed,
    required this.multipleFilesOnPressed,
    required this.cameraOnPressed,
  });

  @override
  State<UploadOptionsRow> createState() => _UploadOptionsRowState();
}

class _UploadOptionsRowState extends State<UploadOptionsRow> {
  UploadType currentUploadType = UploadType.single;

  final bool isSingleSelected = true;
  final bool isMultipleSelected = false;
  final bool isCameraSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UploadOptionsTab(
          uploadType: UploadType.single,
          height: widget.height,
          onPressed: () {
            widget.singleFileOnPressed();
            setState(() {
              currentUploadType = UploadType.single;
            });
          },
          width: widget.width,
          imagePath: "assets/svg/file.svg",
          tabTitle: "Single",
        ),
        const SizedBox(width: 10),
        UploadOptionsTab(
          height: widget.height,
          uploadType: UploadType.batch,
          onPressed: () {
            widget.multipleFilesOnPressed();
            setState(() {
              currentUploadType = UploadType.batch;
            });
          },
          width: widget.width,
          imagePath: "assets/svg/files.svg",
          tabTitle: "Batch",
        ),
        const SizedBox(width: 10),
        UploadOptionsTab(
          height: widget.height,
          uploadType: UploadType.camera,
          onPressed: () {
            widget.cameraOnPressed();
            setState(() {
              currentUploadType = UploadType.camera;
            });
          },
          width: widget.width,
          imagePath: "assets/svg/camera.svg",
          tabTitle: "Camera",
        ),
      ],
    );
  }
}

class UploadOptionsTab extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String imagePath;
  final String tabTitle;
  final UploadType uploadType;
  const UploadOptionsTab({
    super.key,
    required this.height,
    required this.uploadType,
    required this.onPressed,
    required this.width,
    required this.imagePath,
    required this.tabTitle,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => context.read<FileBloc>(),
        ),
        BlocProvider(
          create: (context) => context.read<SelectedUploadTypeBloc>(),
        ),
      ],
      child: Expanded(
        child: BlocBuilder<SelectedUploadTypeBloc, SelectedUploadTypeState>(
          builder: (context, uploadTypeState) {
            return Container(
              height: height / 17,
              decoration: BoxDecoration(
                color: uploadType == uploadTypeState.uploadType
                    ? ThemeConstants.accentColor
                    : null,
                borderRadius: BorderRadius.circular(20),
                border: !(uploadType == uploadTypeState.uploadType)
                    ? Border.all(
                        color: ThemeConstants.primaryColor.withOpacity(0.8),
                        width: 1,
                      )
                    : null,
              ),
              child: BlocBuilder<FileBloc, FileState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    splashColor: ThemeConstants.accentColor,
                    highlightColor: ThemeConstants.accentColor,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          imagePath,
                          width: width / 17,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tabTitle,
                          style: TextStyle(
                            color: ThemeConstants.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: width / 29,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
