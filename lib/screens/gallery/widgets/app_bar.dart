import 'package:cached_network_image/cached_network_image.dart';
import 'package:eh_redux/generated/l10n.dart';
import 'package:eh_redux/models/gallery.dart';
import 'package:eh_redux/repositories/ehentai_client.dart';
import 'package:eh_redux/utils/launch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

enum _GalleryAppBarAction {
  openInBrowser,
}

class GalleryAppBar extends StatelessWidget {
  const GalleryAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gallery = Provider.of<Gallery>(context);
    final client = Provider.of<EHentaiClient>(context);

    return SliverAppBar(
      pinned: true,
      flexibleSpace: _buildPlaceholder(context, gallery),
      expandedHeight: 200,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.share),
          tooltip: S.of(context).share,
          onPressed: () {
            Share.share(
              client.getGalleryUrl(gallery.id),
              subject: gallery.title,
            );
          },
        ),
        PopupMenuButton<_GalleryAppBarAction>(
          onSelected: (value) {
            switch (value) {
              case _GalleryAppBarAction.openInBrowser:
                tryLaunch(client.getGalleryUrl(gallery.id));
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: _GalleryAppBarAction.openInBrowser,
              child: Text(S.of(context).openInBrowser),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context, Gallery gallery) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: gallery.thumbnail,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).padding.top + 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
