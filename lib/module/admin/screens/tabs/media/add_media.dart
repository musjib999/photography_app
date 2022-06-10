import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:u_arewa_studio/core/servie_injector/si.dart';
import 'package:u_arewa_studio/helper/form_helper.dart';
import 'package:u_arewa_studio/shared/model/media_model.dart';
import 'package:u_arewa_studio/shared/model/staff_model.dart';
import 'package:u_arewa_studio/shared/model/user_model.dart';
import 'package:u_arewa_studio/shared/themes/colors.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/primary_raised_button.dart';
import 'package:u_arewa_studio/shared/widgets/buttons/round_outline_icon_button.dart';

import '../../../../../shared/widgets/forms/type_ahead.dart';

class AddMedia extends StatefulWidget {
  const AddMedia({Key? key}) : super(key: key);

  @override
  _AddMediaState createState() => _AddMediaState();
}

class _AddMediaState extends State<AddMedia> {
  // TextEditingController staffId = TextEditingController();
  // TextEditingController clientId = TextEditingController();
  StaffModel? staff;
  UserModel? client;

  String clientId = '';
  String staffId = '';
  TextEditingController pictureType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController paid = TextEditingController();
  TextEditingController link = TextEditingController();

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [pictureType, price, paid, link];
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
                  'Add Media',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'RedHatMono',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TypeAheadForm(
                hintText: client == null ? 'Client' : client!.displayName,
                onSuggestionSelected: (clients) {
                  setState(() {
                    client = clients;
                  });
                },
                suggestionsCallback: si.userService.getAllClientSuggestion,
                itemBuilder: (context, item) {
                  return ListTile(
                    title: Text(item.displayName),
                    subtitle: Text(item.email),
                  );
                },
              ),
              const SizedBox(height: 15),
              TypeAheadForm(
                hintText: staff == null ? 'Staff' : staff!.displayName,
                onSuggestionSelected: (staffs) {
                  setState(() {
                    staff = staffs;
                  });
                },
                suggestionsCallback:
                    si.userService.getAllStaffPhotographersSuggestion,
                itemBuilder: (context, item) {
                  return ListTile(
                    title: Text(item.displayName),
                    subtitle: Text(item.email),
                  );
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: pictureType,
                decoration: const InputDecoration(
                  labelText: 'Event Type',
                  suffixIcon: Icon(Ionicons.home_outline),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(color: Colors.grey),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      children: [
                        RoundOutlinedIconButton(
                          icon: Icons.remove,
                          color: Colors.grey,
                          onPressed: quantity == 0
                              ? () {}
                              : () {
                                  setState(() {
                                    quantity--;
                                  });
                                },
                        ),
                        const SizedBox(width: 8.0),
                        Text('$quantity'),
                        const SizedBox(width: 8.0),
                        RoundOutlinedIconButton(
                          icon: Icons.add,
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: price,
                decoration: const InputDecoration(
                  labelText: 'Picture Price',
                  suffixIcon: Icon(Ionicons.cash_outline),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: paid,
                decoration: const InputDecoration(
                  labelText: 'Amount Paid',
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
                      .addMedia(
                    clientId: client!.uid,
                    staffId: staff!.uid,
                    picturetype: pictureType.text,
                    quantity: quantity,
                    price: int.parse(price.text),
                    amountPaid: int.parse(paid.text),
                    link: link.text,
                  )
                      .then((value) {
                    if (value.runtimeType == MediaModel) {
                      MediaModel media = value;
                      stopLoading();
                      si.dialogService
                          .showToast('${media.userId} has purchased a media');
                      clearFormFields(controllers);
                      setState(() {
                        quantity = 1;
                        client = null;
                        staff = null;
                      });
                    } else {
                      stopLoading();
                      si.dialogService.showToast(value);
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
