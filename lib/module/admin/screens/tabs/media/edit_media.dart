import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';

class EditMedia extends StatefulWidget {
  final String id;
  final MediaModel media;
  const EditMedia({Key? key, required this.media, required this.id})
      : super(key: key);

  @override
  _EditMediaState createState() => _EditMediaState();
}

class _EditMediaState extends State<EditMedia> {
  List<String> status = ['Processing', 'Done'];
  String selectedStatus = 'Processing';

  TextEditingController amountPaid = TextEditingController();
  TextEditingController link = TextEditingController();

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [link, amountPaid];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Media',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Edit Media',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'RedHatMono',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: widget.media.pictureType,
                  suffixIcon: const Icon(Ionicons.image_outline),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<dynamic>(
                items: getDropdownItems(status),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: amountPaid,
                decoration: const InputDecoration(
                  labelText: 'New Amount Paid',
                  suffixIcon: Icon(Ionicons.cash_outline),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: link,
                decoration: const InputDecoration(
                  labelText: 'Picture Link',
                  suffixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: (startLoading, stopLoading, btnState) async {
                  startLoading();
                  await si.mediaService
                      .updateMedia(
                    id: widget.id,
                    amountPaid: amountPaid.text == '' ? null : amountPaid.text,
                    status: selectedStatus,
                    link: link.text,
                  )
                      .then((value) {
                    if (value.runtimeType == UpdateMediaModel) {
                      clearFormFields(controllers);
                      stopLoading();
                      si.dialogService.showToast('Status has been updated');
                    } else {
                      si.dialogService.showToast(value);
                      stopLoading();
                    }
                  });
                },
                buttonTitle: 'Save',
                borderRadius: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
