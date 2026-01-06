import 'dart:developer';
import 'dart:io'; // આ ઉમેરવું જરૂરી છે
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart'; // image_picker import કરો
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class SelectDocumentScreen extends StatefulWidget {
  final dynamic argument;
  const SelectDocumentScreen({super.key, this.argument});

  @override
  State<SelectDocumentScreen> createState() => _SelectDocumentScreenState();
}

class _SelectDocumentScreenState extends State<SelectDocumentScreen> {
  Map<int, File> selectedImages = {};
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImages[index] = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.argument as Map? ?? {};
    int schemaId = args['schemaId'] ?? 0;
    int memberId = args['memberId'] ?? 0;
    List<int> selectedVillagePresidentIds =
        args['selectedVillagePresidentIds'] ?? [];
    List<Document> documents = args['documents'] ?? [];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Document',
        notificationOnTap: () {},
        actions: const [],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: documents.length,
        separatorBuilder: (BuildContext context, int index) => const Gap(15),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: documents[index].name,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),

              const Gap(5),
              Stack(
                children: [
                  InkWell(
                    onTap: () => _pickImage(index),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.themePrimaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.fillColor,
                      ),
                      child:
                          selectedImages.containsKey(index)
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: Image.file(
                                  selectedImages[index]!,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImage.uploadImage),
                                    Gap(10),
                                    const CustomText(
                                      text: 'Tap to upload image',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  ),

                  if (selectedImages.containsKey(index))
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImages.remove(index); // ઈમેજ દૂર કરવા માટે
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red, // લાલ રંગનું બટન
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(
          text: 'Submit',
          onTap: () async {
            if (selectedImages.length < documents.length) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please upload all required documents"),
                ),
              );
              return;
            }

            Map<String, dynamic> params = {
              "schema_id": schemaId,
              "member_id": memberId,
              "village_president_ids[]": selectedVillagePresidentIds,
            };

            for (var entry in selectedImages.entries) {
              int index = entry.key;
              File file = entry.value;
              String docKey = documents[index].key;

              params[docKey] = await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              );
            }

            log('Final Params with FormData :: $params');

            BlocProvider.of<SchemasCubit>(
              context,
            ).schemasRegistration(context, params: params);
          },
        ),
      ),
    );
  }
}
