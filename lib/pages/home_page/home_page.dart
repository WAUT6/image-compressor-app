import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_compressor/pages/home_page/bloc/selected_upload_type/selected_upload_type_bloc.dart';
import 'package:image_compressor/pages/home_page/widgets/file_upload.dart';
import 'package:image_compressor/pages/home_page/widgets/start_compression_button.dart';
import 'package:image_compressor/pages/home_page/widgets/upload_options_row.dart';
import 'package:image_compressor/themes/constants/theme_constants.dart';

import 'bloc/file_bloc/file_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FileBloc(),
        ),
        BlocProvider(
          create: (context) => SelectedUploadTypeBloc(),
        ),
      ],
      child: BlocListener<FileBloc, FileState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Compress",
                style: TextStyle(
                  color: ThemeConstants.primaryColor,
                  fontSize: width / 17,
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: ThemeConstants.backgroundColorVariantThree,
          body: Stack(
            children: [
              Align(
                alignment: const Alignment(5, 2.6),
                child: Container(
                  width: width / 1.2,
                  height: height / 1.4,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeConstants.backgroundColorVariantOne,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(15, 0.7),
                child: Container(
                  width: width / 1.05,
                  height: height / 1.1,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeConstants.backgroundColorVariantTwo,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 100,
                  sigmaY: 100,
                ),
                child: Container(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Compressions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width / 20,
                          color: ThemeConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width,
                        height: height / 4,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ThemeConstants.primaryColor
                                      .withOpacity(0.8),
                                  width: 1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: height / 35,
                      ),
                      BlocBuilder<FileBloc, FileState>(
                        builder: (context, state) {
                          return FileUpload(
                            width: width,
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      BlocBuilder<FileBloc, FileState>(
                          builder: (context, state) {
                        return UploadOptionsRow(
                          height: height,
                          width: width,
                          singleFileOnPressed: () {
                            context
                                .read<FileBloc>()
                                .add(FileEventResetSelectedFiles());

                            context.read<SelectedUploadTypeBloc>().add(
                                  SelectedUploadTypeEventSingle(),
                                );
                          },
                          multipleFilesOnPressed: () => {
                            context
                                .read<FileBloc>()
                                .add(FileEventResetSelectedFiles()),
                            context.read<SelectedUploadTypeBloc>().add(
                                  SelectedUploadTypeEventBatch(),
                                ),
                          },
                          cameraOnPressed: () {
                            context
                                .read<FileBloc>()
                                .add(FileEventResetSelectedFiles());

                            context.read<SelectedUploadTypeBloc>().add(
                                  SelectedUploadTypeEventCamera(),
                                );
                          },
                        );
                      }),
                      SizedBox(
                        height: height / 18,
                      ),
                      BlocBuilder<FileBloc, FileState>(
                        builder: (context, state) {
                          if (state is FileStateUploaded) {
                            return StartCompressionButton(
                              height: height,
                              width: width,
                              onPressed: () {},
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
