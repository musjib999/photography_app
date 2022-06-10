import 'package:flutter/material.dart';
import '../../../../../../shared/themes/colors.dart';
import '../../../../../shared/widgets/cards/user_info_card.dart';
import '../../../../../helper/form_helper.dart';
import '../../../../../shared/model/connection_model.dart';

class SingleConnection extends StatefulWidget {
  final ConnectionModel connection;
  const SingleConnection({Key? key, required this.connection})
      : super(key: key);

  @override
  _SingleConnectionState createState() => _SingleConnectionState();
}

class _SingleConnectionState extends State<SingleConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Connection',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            width: 4.0),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/profile.png'),
                        backgroundColor:
                            const Color(0xFF446DBF).withOpacity(0.7),
                        radius: 45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.connection.displayName,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(3)),
                        child: Text(
                          widget.connection.status,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              UserInfoCard(
                title: 'Connection Information',
                fName: widget.connection.firstName,
                lName: widget.connection.lastName,
                status: widget.connection.status,
                email: widget.connection.email,
                phone: widget.connection.phone,
                category: '',
                connection: widget.connection.connection,
                period: widget.connection.contractPeriod,
                amount: formatMoney(widget.connection.amountPaid),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
