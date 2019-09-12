import 'package:flutter/material.dart';

class ProfilePageBody extends StatelessWidget {
  ProfilePageBody(this.profile);
  final Profile profile;

  Widget _buildLocationInfo(TextTheme textTheme) {
    return Row(
      children: <Widget>[

        Icon(
          Icons.place,
          color: Colors.white,
          size: 16,
        ),

        Padding(
          padding: 
          const EdgeInsets.only(
            left: 8
          ),
          child: 
          Text(
            profile.location,
            style: textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }

  Widget _createCircleBadge(IconData iconData, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: CircleAvatar(
        backgroundColor: color,
        child:
        Icon(
          iconData,
          color: Colors.white,
          size: 16,
        ),
        radius: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Text(
          profile.name,
          style: textTheme.headline.copyWith(color: Colors.white),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _buildLocationInfo(textTheme),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            '|| Dummy Text && || Dummy Text && || Dummy Text && || Dummy Text &&'
            '|| Dummy Text && || Dummy Text && || Dummy Text && || Dummy Text &&'
            '|| Dummy Text &&',
            style: 
              textTheme.body1.copyWith(color: Colors.white70, fontSize: 16),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: <Widget>[
              _createCircleBadge(Icons.beach_access, theme.accentColor),
              _createCircleBadge(Icons. cloud, Colors.white12),
              _createCircleBadge(Icons.shop, Colors.white12),
            ],
          )
        )
      ],
    );
  }
}