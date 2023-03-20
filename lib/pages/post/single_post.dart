import 'package:api_practice/pages/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/post_provider.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var x = Provider.of<PostProvider>(context, listen: false);
      x.getPostById(x.selectedPostId);
    });
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    final post = postProvider.selectedPost;
    debugPrint(post.toString());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text("Single Post Page")),
      body: Container(
        child: postCard(context, title: post!.title, desc: post.body),
      ),
    );
  }
}
