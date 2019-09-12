import 'package:flutter/material.dart';
import 'package:flutter_parking_app/profile_sections/profile_header_image_section.dart';
import 'package:flutter_parking_app/contacts_page.dart';

class ProfilePageHeader extends StatelessWidget{
  static const BACKGROUND_IMAGE = 'image/profile_header_background.png';

  ProfilePageHeader (
    this.profile, {
    @required this.avatarTag,
    }
  );

  final Profile profile;
  final Object avatarTag;

  Widget _buildBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return CutColoredImage(
      Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280,
        fit: BoxFit.cover,
      ),
      color: const Color(0xBB8338f4),
    );
  }

  Widget _buildAvatar() {
    return Hero(
      tag: avatarTag,
      child: CircleAvatar(
        backgroundImage: NetworkImage(profile.avatar),
        radius: 50,
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16, left: 16, right: 16,
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _createPillButton('CALL',
          backgroundColor: theme.accentColor,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              borderRadius: BorderRadius.circular(30),
            ),
            child: _createPillButton(
              'MESSAGE',
              textColor: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createPillButton(String text, {
      Color backgroundColor = Colors.transparent,
      Color textColor = Colors.white70,
    }
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: 140,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: Text(text),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    /*var textTheme = theme.textTheme;*/

    return Stack(
      children: <Widget>[
        _buildBackground(context),
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: Column(
            children: <Widget>[
              _buildAvatar(),
              _buildActionButtons(theme)
            ],
          ),
        ),
        Positioned(
          top: 26,
          left: 4,
          child: BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
