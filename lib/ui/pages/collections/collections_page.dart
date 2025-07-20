import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsPage extends ConsumerStatefulWidget {
  const CollectionsPage({super.key});

  @override
  ConsumerState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends ConsumerState<CollectionsPage> {
  late TreeNode<String> root;

  @override
  void initState() {
    super.initState();
    root = generateMockFileSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TreeView.simple(
        expansionBehavior: ExpansionBehavior.scrollToLastChild,
        tree: root,
        builder: (context, node) {
          final isFolder = node.children.isNotEmpty;
          return ListTile(
            leading: Icon(isFolder ? Icons.folder : Icons.insert_drive_file),
            title: Text(node.data.toString()),
          );
        },
      ),
    );
  }
}

TreeNode<String> generateMockFileSystem() {
  return TreeNode.root(data: 'Collection')
    ..addAll([
      TreeNode(key: 'auth', data: 'Auth')
        ..addAll([
          TreeNode(key: 'resume', data: 'Resume.docx'),
          TreeNode(key: 'project', data: 'Project')
            ..addAll([
              TreeNode(key: 'design_pdf', data: 'design.pdf'),
              TreeNode(key: 'presentation', data: 'presentation.pptx'),
            ]),
        ]),
      TreeNode(key: 'data', data: 'Data')
        ..addAll([
          TreeNode(key: 'rock', data: 'Rock')
            ..addAll([
              TreeNode(key: 'song1', data: 'song1.mp3'),
              TreeNode(key: 'song2', data: 'song2.mp3'),
            ]),
          TreeNode(key: 'pop', data: 'Pop')
            ..add(
              TreeNode(key: 'hit', data: 'hit.mp3'),
            ),
        ]),
      TreeNode(key: 'pictures', data: 'Pictures')
        ..addAll([
          TreeNode(key: 'vacation', data: 'Vacation')
            ..addAll([
              TreeNode(key: 'beach', data: 'beach.png'),
              TreeNode(key: 'mountains', data: 'mountains.jpg'),
            ]),
          TreeNode(key: 'family', data: 'Family.jpg'),
        ]),
    ]);
}
