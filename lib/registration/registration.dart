import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waqareazadi/global.dart';
import 'package:waqareazadi/helpers/regex-helpers.dart';
import 'package:waqareazadi/widgets/dots_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:waqareazadi/widgets/full_screen_loader.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() {
    return new RegistrationPageState();
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  PageController controller = PageController();
  final GlobalKey<FormState> _mobileNumberFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _studentProfessionalFormKey =
      new GlobalKey<FormState>();
  final GlobalKey<FormState> _designationFormKey = new GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  int pageViewItemCount = 3;
  bool _isStudent = false;
  bool _isSinger = false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileNumberController.text = userCache.user.mobileNumber == null
        ? '+92'
        : userCache.user.mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Registration',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(width: 48),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: <Widget>[
                      _buildSpeechSongSelectionView(),
                      _buildNumberSetupView(
                        context,
                        GlobalConstants.addNumberDisplayText,
                      ),
//                      _buildStudentProfessionalView(),
                      _buildWorkInstituteEntryView(),
                      _buildDesignationEntryView()
                    ],
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                DotsIndicator(
                  controller: controller,
                  itemCount: pageViewItemCount,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        _isLoading ? FullScreenLoader() : Container()
      ],
    );
  }

  Center _buildSpeechSongSelectionView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
//              child: SizedBox(
//                height: 100.0,
//                child: Image(
//                  image: AssetImage('assets/logoWithShadow.jpg'),
//                ),
//              ),
//              IconTheme(
//                data: IconThemeData(color: Colors.blueGrey),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      Icons.music_note,
//                      size: 48.0,
//                    ),
//                    SizedBox(width: 8),
//                    Icon(
//                      Icons.laptop_mac,
//                      size: 80.0,
//                    ),
//                    SizedBox(width: 8),
//                    Icon(
//                      Icons.mic,
//                      size: 48.0,
//                    ),
//                  ],
//                ),
//              ),
                ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                'Which one do you want to participate in?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.music_note,
                      size: 48.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        'Singing\nCompletition',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSinger = true;
                        });
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.mic,
                      size: 48.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        'Speech\nCompetition',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSinger = false;
                        });
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      },
                    ),
                  ],
                ),
              ],
            ),
//            Divider(),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Icon(
//                          Icons.arrow_back,
//                          size: 24.0,
//                        ),
//                        Text('BACK'),
//                      ],
//                    ),
//                    textColor: Theme.of(context).primaryColor,
//                    onPressed: () {
//                      controller.animateToPage(0,
//                          duration: Duration(milliseconds: 500),
//                          curve: Curves.fastOutSlowIn);
//                    },
//                  ),
//                )
//              ],
//            )
          ],
        ),
      ),
    );
  }

  Widget _buildNumberSetupView(BuildContext context, String displayText) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 128.0, right: 128.0),
              child: Center(
                child: Image(
                  image: AssetImage('assets/ic_phone_setup.png'),
                  color: Theme.of(context).primaryColor,
                  width: 120,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Form(
              key: _mobileNumberFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: focusNode,
                  controller: mobileNumberController,
                  maxLength: GlobalConstants.phoneNumberMaxLength,
                  validator: (value) => _validatePhoneNumber(value),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: 'Enter mobile number',
                      labelText: 'Mobile number'),
                ),
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 24.0,
                        ),
                        Text('BACK'),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('NEXT'),
                        Icon(
                          Icons.arrow_forward,
                          size: 24.0,
                        )
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_mobileNumberFormKey.currentState.validate()) {
                        focusNode.unfocus();
                        controller.animateToPage(2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

//  Center _buildStudentProfessionalView() {
//    return Center(
//      child: SingleChildScrollView(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Center(
//              child: IconTheme(
//                data: IconThemeData(color: Colors.blueGrey),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(
//                      Icons.work,
//                      size: 48.0,
//                    ),
//                    SizedBox(width: 8),
//                    Icon(
//                      Icons.laptop_mac,
//                      size: 80.0,
//                    ),
//                    SizedBox(width: 8),
//                    Icon(
//                      Icons.school,
//                      size: 48.0,
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(
//                top: 16.0,
//                bottom: 16.0,
//                left: 32.0,
//                right: 32.0,
//              ),
//              child: Text(
//                'Which one of the following best describes you?',
//                textAlign: TextAlign.center,
//                style: Theme.of(context).textTheme.title,
//              ),
//            ),
//            ButtonBar(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text('STUDENT'),
//                  onPressed: () {
//                    setState(() {
//                      _isStudent = true;
//                      pageViewItemCount = 3;
//                    });
//                    controller.animateToPage(2,
//                        duration: Duration(milliseconds: 500),
//                        curve: Curves.fastOutSlowIn);
//                  },
//                ),
//                RaisedButton(
//                  child: Text('PROFESSIONAL'),
//                  onPressed: () {
//                    setState(() {
//                      _isStudent = false;
//                      pageViewItemCount = 4;
//                    });
//                    controller.animateToPage(2,
//                        duration: Duration(milliseconds: 500),
//                        curve: Curves.fastOutSlowIn);
//                  },
//                ),
//              ],
//            ),
//            Divider(),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Icon(
//                          Icons.arrow_back,
//                          size: 24.0,
//                        ),
//                        Text('BACK'),
//                      ],
//                    ),
//                    textColor: Theme.of(context).primaryColor,
//                    onPressed: () {
//                      controller.animateToPage(0,
//                          duration: Duration(milliseconds: 500),
//                          curve: Curves.fastOutSlowIn);
//                    },
//                  ),
//                )
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }

  Widget _buildWorkInstituteEntryView() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.perm_contact_calendar,
            size: 100.0,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            title: Text(
              'What is your name?',
              textAlign: TextAlign.center,
            ),
          ),
          Form(
            key: _studentProfessionalFormKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    focusNode: focusNode,
                    controller: fullNameController,
                    maxLength: GlobalConstants.entryMaxLength,
                    validator: (value) =>
                        _validateStudentProfessionalEntry(value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Enter full name',
                        labelText: 'Full name'),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'What is your gender?',
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  leading: Radio(
                    value: 0,
                    groupValue: 1,
                    onChanged: (int item) {},
                  ),
                  title: Text('Male'),
                ),
                ListTile(
                  leading: Radio(
                    value: 0,
                    groupValue: 1,
                    onChanged: (int item) {},
                  ),
                  title: Text('Female'),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'What is your date of birth',
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    'Tap the icon below to select date',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  iconSize: 40.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(
                        Duration(days: 1),
                      ),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 10),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Please enter your CNIC/B Form number.',
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    '(without dashes)',
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: fullNameController,
                    maxLength: GlobalConstants.cnicMaxLength,
                    validator: (value) =>
                        _validateStudentProfessionalEntry(value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: 'Enter CNIC/B Form',
                        labelText: 'CNIC/B Form'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        size: 24.0,
                      ),
                      Text('BACK'),
                    ],
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    controller.animateToPage(1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(_isStudent ? 'DONE' : 'NEXT'),
                      Icon(
                        _isStudent ? Icons.check_circle : Icons.arrow_forward,
                        size: 24.0,
                      ),
                    ],
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    focusNode.unfocus();
                    if (_studentProfessionalFormKey.currentState.validate()) {
                      if (_isStudent) {
                        await _submitDataToFirestore();
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Success!",
                          desc:
                              "Your are registered successfully!\nYou will receive a confirmation message soon!",
                          buttons: [
                            DialogButton(
                              child: Text("COOL!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        color: Colors.white,
                                      )),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ).show();
                      } else {
                        controller.animateToPage(3,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      }
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Center _buildDesignationEntryView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.account_box,
              size: 100.0,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                'Your designation at ${fullNameController.text}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Form(
              key: _designationFormKey,
              child: ListTile(
                title: TextFormField(
                  focusNode: focusNode,
                  controller: designationController,
                  maxLength: GlobalConstants.entryMaxLength,
                  validator: (value) => _validateDesignation(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Enter designation',
                    labelText: 'Designation',
                  ),
                ),
              ),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 24.0,
                        ),
                        Text('BACK'),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('DONE'),
                        Icon(
                          Icons.check_circle,
                          size: 24.0,
                        ),
                      ],
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () async {
                      focusNode.unfocus();
                      if (_designationFormKey.currentState.validate()) {
                        await _submitDataToFirestore();
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Success!",
                          desc:
                              "Your are registered successfully!\nYou will receive a confirmation message soon!",
                          buttons: [
                            DialogButton(
                              child: Text("COOL!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        color: Colors.white,
                                      )),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ).show();
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String _validatePhoneNumber(String number) {
    if (number.isEmpty) return 'Phone number required';
    if (number.length < GlobalConstants.phoneNumberMaxLength ||
        !RegexHelpers.phoneNumberRegex.hasMatch(number))
      return 'You wouldn\'t want to miss any important update! \nPlease enter a valid mobile number';
  }

  String _validateDesignation(String number) {
    if (number.isEmpty) return 'Designation required';
  }

  String _validateStudentProfessionalEntry(String number) {
    if (number.isEmpty)
      return 'Name required';
    return null;
  }

  Future _submitDataToFirestore() async {
    setState(() => _isLoading = true);
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(userCache.user.reference, {
          'registration': Registration(
            occupation: _isStudent ? 'Student' : 'Professional',
            workOrInstitute: fullNameController.text,
            designation: designationController.text,
          ).toJson(),
          'mobileNumber': mobileNumberController.text,
          'isRegistered': true
        });
      });

      await userCache.getUser(userCache.user.id, useCached: false);
    } catch (ex) {
      print(ex);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Oops!",
        desc: "An error has occurred",
        buttons: [
          DialogButton(
            child: Text("Dismiss",
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    )),
            color: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      ).show();
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

class Registration {
  final String occupation;
  final String workOrInstitute;
  final String designation;
  final DocumentReference reference;

  Registration({
    this.occupation,
    this.designation = 'not applicable',
    this.workOrInstitute,
    this.reference,
  });

  Registration.fromMap(Map<String, dynamic> map, {this.reference})
      : occupation = map['occupation'],
        designation = map['designation'],
        workOrInstitute = map['workOrInstitute'];

  Map<String, dynamic> toJson() => {
        "occupation": this.occupation,
        "workOrInstitute": this.workOrInstitute,
        "designation": this.designation,
      };

  Registration.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
