import 'package:api_practice/common/widgets/custom_button.dart';
import 'package:api_practice/common/widgets/snack_bar.dart';
import 'package:api_practice/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../provider/post_provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String id = const Uuid().v4().replaceAll('-', '');
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Create Post")),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text("Enter title"),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (value) {
                    return Validator.validateEmpty(value.toString());
                  },
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Text("Enter description"),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.disabled,
                  autofocus: false,
                  controller: descController,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    return Validator.validateEmpty(value.toString());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: CustomButton(
                    handlePress: () {
                      if (_formKey.currentState!.validate()) {
                        postProvider.createPost(
                          userId: id.hashCode,
                          title: titleController.text,
                          desc: descController.text,
                        );
                        titleController.clear();
                        descController.clear();
                        showSnackBar(context, "Post Created Successfully");
                      }
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
