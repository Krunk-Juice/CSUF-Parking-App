import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'profile_sections/profile_body_section.dart';
import 'profile_sections/profile_header_section.dart';

class ProfilePage extends StatefulWidget {
  static const String id ="profile_page";

  ProfilePage (
    this.profile, {
      @required this.avatarTag,
    }
  );

  final Profile profile;
  final Object avatarTag;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF0043d4),
          const Color(0xFF0088f0),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            children: <Widget>[
              new ProfilePageHeader(
                widget.profile,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24),
                child: new ProfilePageBody(widget.profile),
              )
            ],
          ),
        ),
      ),
    );
  }
}