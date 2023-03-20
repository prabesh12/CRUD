import 'package:api_practice/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../api/dio_service.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel>? _posts;
  PostModel? _selectedPost;
  int? _selectedPostId;
  final DioService dioService = DioService();
  bool loadingPost = false;

  List<PostModel>? get posts => _posts;
  get selectedPost => _selectedPost;
  get selectedPostId => _selectedPostId;

  void setSelectedPostId(int id) {
    _selectedPostId = id;
  }

  void addPost(PostModel post) {
    _posts ??= [];
    _posts?.add(post);
    notifyListeners();
  }

//This function will be called when user wishes to update/add an expense
  Future<void> createPost(
      {required String title,
      required String desc,
      required int userId}) async {
    try {
      PostModel postModel =
          await dioService.createPost(userId: userId, title: title, desc: desc);
      addPost(postModel);
    } catch (e) {
      print(e);
    }
  }

//This function will be called when user wishes to fetch an all expenses.
  Future<void> getPosts() async {
    try {
      setLoading(true);
      _posts = await dioService.getPosts();
      setLoading(false);
      notifyListeners();
    } catch (error) {
      _posts = [];
      setLoading(false);
      throw error;
    }
  }

// This function will be called when user wishes to fetch an individual post.
  Future<void> getPostById(int id) async {
    try {
      setLoading(true);
      setSelectedPostId(id);
      final post = await dioService.getPost(id);
      debugPrint(post.toString());
      _selectedPost = post;
      setLoading(false);
      notifyListeners();
    } catch (error) {
      setLoading(false);
      throw error;
    }
  }

  setLoading(bool loading) {
    loadingPost = loading;
    notifyListeners();
  }
}
