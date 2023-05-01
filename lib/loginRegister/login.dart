import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  /// default
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //GlobalKeys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final snack = GlobalKey<ScaffoldState>();
  final studentFormKey = GlobalKey<FormState>();
  final hodFormKey = GlobalKey<FormState>();
  final supervisorFormKey = GlobalKey<FormState>();
  

  //TextEditingController Objects and other controllers
  TextEditingController studentMailController = TextEditingController();
  TextEditingController studentPasswordController = TextEditingController();
  TextEditingController supervisorMailController = TextEditingController();
  TextEditingController supervisorPasswordController = TextEditingController();
  TextEditingController hodMailController = TextEditingController();
  TextEditingController hodPasswordController = TextEditingController();

  PageController? _pageController;
  // String? _key;

  //Variables
  bool _student = true;
  bool _hod = true;
  bool _supervisor = true;
  // bool? valid;
  Color left = Colors.black;
  Color right = Colors.black;
  Color middle=Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Expanded(
                child: Image(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/logo.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: _buildMenuBar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (i) {
                    // if (i == 0) {
                    //   setState(() {
                    //     right = Colors.white;
                    //     left = Colors.black;
                    //     middle=Colors.white;
                    //   });
                    // } else if (i == 1) {
                    //   setState(() {
                    //     right = Colors.white;
                    //     middle=Colors.black;
                    //     left = Colors.white;

                    //   });
                    // }else if (i == 2) {
                    //   setState(() {
                    //     right = Colors.black;
                    //     middle=Colors.white;
                    //     left = Colors.white;
                    //   });
                    // }
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildeStudent(context),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildSupervisor(context),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildHod(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  void invalidSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }

  void validSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: _studentPress,
                child: Text(
                  'Student',
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: _supervisorPress,
                child: Text(
                  'Guide',
                  style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: _hodPress,
                child: Text(
                  'HOD',
                  style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildeStudent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 220.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: studentFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: studentMailController,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                                validator: (String? input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Email Address';
                                  } else if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(input)) {
                                    return 'Valid Email Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: studentPasswordController,
                                obscureText: _student,
                                style: const TextStyle(fontSize: 16.0),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (input) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.lock,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleStudent,
                                    child: Icon(
                                      _hod
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 210.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFFfbab66),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Color(0xFFf7418c),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  //Button field
                  highlightColor: Colors.transparent,
                  splashColor: const Color(0xFFf7418c),
                  onPressed: () {
                    // getUser();
                    // adminAuth();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => userCheck()),
              // );
            },
            child: const Text(
              'Register',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHod(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 220.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: hodFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: hodMailController,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                                validator: (String? input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Email Address';
                                  } else if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(input)) {
                                    return 'Valid Email Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: hodPasswordController,
                                obscureText: _hod,
                                style: const TextStyle(fontSize: 16.0),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (input) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.lock,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _togglehod,
                                    child: Icon(
                                      _hod
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 210.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFFfbab66),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Color(0xFFf7418c),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  //Button field
                  highlightColor: Colors.transparent,
                  splashColor: const Color(0xFFf7418c),
                  onPressed: () {
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => userCheck()),
              // );
            },
            child: const Text(
              'Register',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupervisor(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 220.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: supervisorFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: supervisorMailController,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                                validator: (String? input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Email Address';
                                  } else if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(input)) {
                                    return 'Valid Email Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: supervisorPasswordController,
                                obscureText: _supervisor,
                                style: const TextStyle(fontSize: 16.0),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (input) {},
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.lock,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSupervisor,
                                    child: Icon(
                                      _hod
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 210.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFFfbab66),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Color(0xFFf7418c),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  //Button field
                  highlightColor: Colors.transparent,
                  splashColor: const Color(0xFFf7418c),
                  onPressed: () {
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => userCheck()),
              // );
            },
            child: const Text(
              'Register',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                  color: Color.fromARGB(255, 31, 212, 52), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void _studentPress() {
    _pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _supervisorPress() {
    _pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
  void _hodPress() {
    _pageController?.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _toggleStudent() {
    setState(() {
      _student = !_student;
    });
  }

  void _togglehod() {
    setState(() {
      _hod = !_hod;
    });
  }
  void _toggleSupervisor() {
    setState(() {
      _supervisor = !_supervisor;
    });
  }
}

class TabIndicationPainter extends CustomPainter {
  late Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController? pageController;

  TabIndicationPainter(
      {this.dxTarget = 77.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController!.position;
    var fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    var pageOffset = pos.extentBefore / fullExtent;

    var left2right = dxEntry < dxTarget;
    var entry = Offset(left2right ? dxEntry : dxTarget, dy);
    var target = Offset(left2right ? dxTarget : dxEntry, dy);

    var path = Path();
    path.addArc(
        Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
