import 'package:flutter/material.dart';
import 'package:idwallet/utils/db/sp_helper.dart';
import 'dart:convert';
import '../../shared/lists/countries.dart';
import '../../style/colors.dart';
import '../../utils/date_time_helper.dart';

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
  // final TextEditingController countryName = TextEditingController();
  String? countryName;
  bool isEnabled = false;

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        // selectedDate = picked;
        dateOfBirth.text = DateTimeHelper().toDeDateFormat('$picked');
        // _pickedDate.text = DateTimeFormatter().toDateString(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final sp = SpHelper();
    sp.retrieveFromSharedPrefs('user_data').then((val) => setState(() {
          if (val != null) {
            Map<String, dynamic> data = jsonDecode(val);
            debugPrint('Retrieved data: $data');
            firstName.text = data['_firstName'] ?? '';
            lastName.text = data['_lastName'] ?? '';
            dateOfBirth.text = data['_dateOfBirth'] ?? '';
            countryName = data['_countryName'] ?? '';
          }
        }));
  }

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
                  enabled: isEnabled,
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
                  enabled: isEnabled,
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
                  enabled: isEnabled,
                  decoration: const InputDecoration(labelText: 'Date of birth'),
                  onTap: () => _selectDateOfBirth(context),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.89,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Country'),
                  items: countryList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: primaryColor),
                      ),
                    );
                  }).toList(),
                  validator: (val) => val == null ? 'Country ?' : null,
                  onChanged: (val) => setState(() {
                    countryName = val as String;
                  }),
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
                      'CANCEL',
                      style: TextStyle(color: txtBlackColor),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Tapped edit button');
                      setState(() {
                        isEnabled = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: txtBlackColor),
                    child: const Text(
                      'EDIT',
                      style: TextStyle(color: txtWhiteColor),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Tapped save button');
                      Map<String, dynamic> userData = {
                        '_firstName': firstName.text,
                        '_lastName': lastName.text,
                        '_dateOfBirth': dateOfBirth.text,
                        '_countryName': countryName
                      };
                      debugPrint('User data: $userData');
                      String userDataStr = jsonEncode(userData);
                      final sharedPrefs = SpHelper();
                      sharedPrefs
                          .storeInSharedPrefs('user_data', userDataStr)
                          .then((value) => setState(() {
                                isEnabled = false;
                              }));
                    },
                    child: const Text('SAVE'),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
