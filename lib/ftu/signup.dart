import 'package:flutter/material.dart';

// Changing from stateless to stateful
class LoginSignupPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();

}

class _LoginSignupPageState extends State<LoginSignupPage>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome!"),
      ),
      body: new Container(
        child: new Text("Hello World"),
      ),
    );
  }
}

// class FirstRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: RaisedButton(
//           child: Text('Sign-Up', style: TextStyle(color: Colors.black) ),
//           onPressed: () {
//             Navigator.pushNamed(context, '/second');
//           },
//         ),
//       ),
//     );
//   }
// }


// class SecondRoute extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/UserProfile');
//           },
//           child: Text('Done. To the profile!'),
//         ),
//       ),
//     );
//   }
// }
