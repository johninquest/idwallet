import 'package:flutter/material.dart';
import '../../style/colors.dart';

class UserCreatePage extends StatelessWidget {
  const UserCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New user'),
        centerTitle: true,
      ),
      body: const Center(
        child: NewUserForm(),
      ),
    );
  }
}

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final userFormKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController countryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: userFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.89,
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: firstName,
                  enabled: true,
                  decoration: const InputDecoration(labelText: 'First name'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.89,
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: lastName,
                  enabled: true,
                  decoration: const InputDecoration(labelText: 'Last name'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.89,
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: dateOfBirth,
                  enabled: true,
                  decoration: const InputDecoration(labelText: 'Date of birth'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.89,
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: countryName,
                  enabled: true,
                  decoration: const InputDecoration(labelText: 'Country'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(),
                    child: const Text(
                      'cancel',
                      style: TextStyle(color: txtBlackColor),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => debugPrint('Tapped save button'),
                    child: const Text('save'),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
