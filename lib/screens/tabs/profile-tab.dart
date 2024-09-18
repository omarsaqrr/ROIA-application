import 'package:flutter/material.dart';
import 'package:frontend/DTO/user_response.dart';
import 'package:frontend/constants/colors.dart';
import 'package:frontend/widgets/profile_widget.dart';
import '../../requests/profile_request.dart';

class ProfilePage extends StatefulWidget {
  final String id;

  const ProfilePage({super.key, required this.id});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String mobileNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    ProfileRequest profileRequest = ProfileRequest();
    UserResponse? userResponse = await profileRequest.getUserRequest(widget.id);

    if (userResponse != null) {
      setState(() {
        email = userResponse.email;
        username = userResponse.username;
        firstName = userResponse.firstName;
        lastName = userResponse.lastName;
        mobileNumber = userResponse.mobileNumber;
      });
    } else {
      print('Failed to fetch user profile');
    }
  }

  void _editProfile(String field) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController fieldController;

        switch (field) {
          case 'Email':
            fieldController = TextEditingController(text: email);
            break;
          case 'Username':
            fieldController = TextEditingController(text: username);
            break;
          case 'First Name':
            fieldController = TextEditingController(text: firstName);
            break;
          case 'Last Name':
            fieldController = TextEditingController(text: lastName);
            break;
          case 'Mobile Number':
            fieldController = TextEditingController(text: mobileNumber);
            break;
          default:
            return Container();
        }

        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: fieldController,
            decoration: InputDecoration(labelText: field),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                final ProfileRequest profileRequest = ProfileRequest();
                bool success = false;

                switch (field) {
                  case 'First Name':
                    final updatedUser = await profileRequest.editFirstName(widget.id, fieldController.text);
                    if (updatedUser != null) {
                      setState(() {
                        firstName = updatedUser.firstName;
                      });
                      success = true;
                    }
                    break;
                  case 'Last Name':
                    final updatedUser = await profileRequest.editLastName(widget.id, fieldController.text);
                    if (updatedUser != null) {
                      setState(() {
                        lastName = updatedUser.lastName;
                      });
                      success = true;
                    }
                    break;
                  case 'Mobile Number':
                    final updatedUser = await profileRequest.editMobileNumber(widget.id, fieldController.text);
                    if (updatedUser != null) {
                      setState(() {
                        mobileNumber = updatedUser.mobileNumber;
                      });
                      success = true;
                    }
                    break;
                }

                if (!success) {
                  print('Error updating $field');
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: paletteBlue,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Welcome, $username!",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    const Text(
                      "Your E-mail",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    ProfileWidget(
                      icon: Icons.email,
                      title: 'Email',
                      subtitle: email,
                      onEdit: () => _editProfile('Email'),
                    ),
                    const Text(
                      "Your Username",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'Username',
                      subtitle: username,
                      onEdit: () => _editProfile('Username'),
                    ),
                    const Text(
                      "Your First Name",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'First Name',
                      subtitle: firstName,
                      onEdit: () => _editProfile('First Name'),
                    ),
                    const Text(
                      "Your Last Name",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'Last Name',
                      subtitle: lastName,
                      onEdit: () => _editProfile('Last Name'),
                    ),
                    const Text(
                      "Your Mobile Number",
                      style: TextStyle(
                        color: paletteBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    ProfileWidget(
                      icon: Icons.phone,
                      title: 'Mobile Number',
                      subtitle: mobileNumber,
                      onEdit: () => _editProfile('Mobile Number'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
