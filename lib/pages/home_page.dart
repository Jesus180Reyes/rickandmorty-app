import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty_app/models/rickmorty_response.dart';
import 'package:rickmorty_app/services/rickmorty_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rickProvider = Provider.of<RickMortyService>(context).rickMortyList;
    final isLoading = Provider.of<RickMortyService>(context).isLoading;
    if (rickProvider.isEmpty) {
      return const Material(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    }
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: const Text("Home Page"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _CharacterImages(list: rickProvider),
              isLoading
                  ? Positioned(
                      bottom: 10,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: size.width,
                        child: const CircularProgressIndicator(
                          backgroundColor: Color(0xfff1f1f1),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterImages extends StatefulWidget {
  final List<Result> list;
  const _CharacterImages({Key? key, required this.list}) : super(key: key);

  @override
  State<_CharacterImages> createState() => _CharacterImagesState();
}

class _CharacterImagesState extends State<_CharacterImages> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    final mortyProvider = Provider.of<RickMortyService>(context, listen: false);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        mortyProvider.addPage();
        mortyProvider.getCharacters();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView.builder(
        controller: scrollController,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return _CustomImage(list: widget.list[index]);
        },
      ),
    );
  }
}

class _CustomImage extends StatelessWidget {
  final Result list;
  const _CustomImage({
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, "details", arguments: list),
      title: Text(list.name),
      subtitle: Text(list.location.name),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
      leading: Hero(
        tag: list.id,
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(list.image),
            ),
          ),
        ),
      ),
    );
  }
}
