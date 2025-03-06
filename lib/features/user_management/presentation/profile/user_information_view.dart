import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isp_app/core/utils/file_galery.dart';
import 'package:isp_app/features/user_management/presentation/dashboard_view.dart';
import 'package:isp_app/features/user_management/presentation/user_controller.dart';

class UserInformationView extends ConsumerStatefulWidget {
  const UserInformationView({Key? key}) : super(key: key);

  static const routeName = '/user-information';

  @override
  ConsumerState<UserInformationView> createState() =>
      _UserInformationViewState();
}

class _UserInformationViewState extends ConsumerState<UserInformationView> {
  final _addressController = TextEditingController();
  final _noKtpController = TextEditingController();
  List<File?> _images = [];

  @override
  void dispose() {
    _addressController.dispose();
    _noKtpController.dispose();
    super.dispose();
  }

  bool get isValueNotEmpty =>
      _addressController.text != '' &&
      _noKtpController.text != '' &&
      _images != [];

  void _selectImage() async {
    _images = await pickImageFromGallery();
    setState(() {});
  }

  void _saveUserData() async {
    ref.read(userControllerProvider).saveUserInformationToDb(
          address: _addressController.text,
          noKtp: _noKtpController.text,
          photoRumah: _images,
        );

    Navigator.of(context).pushNamedAndRemoveUntil(
      DashboardView.routeName,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Lengkapi Data Diri Anda',
              style: TextStyle(
                color: Color(0xFF0F1A26),
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 52),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _noKtpController,
              decoration: InputDecoration(
                labelText: 'No KTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            FilledButton(
              onPressed: _selectImage,
              child: Text('  Photo Rumah'),
            ),
            SizedBox(height: 16),
            ..._images
                .map((image) => Image.file(
                      image!,
                      height: 80,
                      fit: BoxFit.contain,
                    ))
                .toList(),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: isValueNotEmpty ? _saveUserData : null,
              child: Text('Simpan Data Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
