import 'package:api_practice/common/widgets/snack_bar.dart';
import 'package:api_practice/model/post_model.dart';
import 'package:api_practice/pages/post/single_post.dart';
import 'package:api_practice/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var x = Provider.of<PostProvider>(context, listen: false);
      x.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    Widget postCard(
        {required String title,
        required String desc,
        Function()? handleDelete}) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.05)),
            height: MediaQuery.of(context).size.height * 0.22,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        desc,
                        style: const TextStyle(
                            overflow: TextOverflow.clip, fontSize: 12),
                      )
                    ],
                  ),
                ),
                InkWell(onTap: handleDelete, child: const Icon(Icons.delete)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          )
        ],
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All Posts"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SingleChildScrollView(
            child: Container(
              child: postProvider.loadingPost
                  ? const Center(child: const CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.78,
                        child: ListView.builder(
                          itemCount: postProvider.posts?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final post = postProvider.posts?[index];
                            return GestureDetector(
                              onTap: () async {
                                await postProvider.getPostById(post.id);
                                // if (mounted) {
                                //   // Navigator.push(
                                //   //   context,
                                //   //   MaterialPageRoute(
                                //   //     builder: (context) => PostDetailPage(),
                                //   //   ),
                                //   // );
                                // }
                              },
                              child: postCard(
                                  handleDelete: () async {
                                    await postProvider.deletePost(post);
                                  },
                                  title: post!.title,
                                  desc: post.body),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
