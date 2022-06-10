import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UserInfoCard extends StatelessWidget {
  final String fName,
      lName,
      email,
      phone,
      status,
      category,
      title,
      connection,
      period,
      amount;

  const UserInfoCard({
    Key? key,
    required this.title,
    required this.fName,
    required this.lName,
    required this.status,
    required this.email,
    required this.phone,
    required this.category,
    required this.connection,
    required this.period,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'RedHatMono',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            title: const Text(
              'First Name',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                fName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            title: const Text(
              'Last Name',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                lName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              color: Colors.grey,
            ),
            title: const Text(
              'Email',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                email,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.phone_outlined,
              color: Colors.grey,
            ),
            title: const Text(
              'Phone',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                phone,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          category == '' ? Container() : const Divider(),
          category == ''
              ? Container()
              : ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Category',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
          connection == '' ? Container() : const Divider(),
          connection == ''
              ? Container()
              : ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Connection',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      connection,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
          period == '' ? Container() : const Divider(),
          period == ''
              ? Container()
              : ListTile(
                  leading: const Icon(
                    Icons.schedule_outlined,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Period',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      period,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
          amount == '' ? Container() : const Divider(),
          amount == ''
              ? Container()
              : ListTile(
                  leading: const Icon(
                    Ionicons.cash_outline,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    'Amount',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      amount,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
