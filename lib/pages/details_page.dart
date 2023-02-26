import 'package:flutter/material.dart';
import 'package:rickmorty_app/models/rickmorty_response.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listArgument = ModalRoute.of(context)!.settings.arguments as Result;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomImageRounded(listArgument: listArgument),
            const SizedBox(height: 15),
            Text(
              listArgument.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              listArgument.gender!.name[0].toUpperCase() +
                  listArgument.gender!.name.substring(1).toLowerCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(15),
              child: Text(
                "Description",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Status: ${listArgument.status.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Origin: ${listArgument.origin.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                listArgument.species?.name == null
                    ? "Specie: Desconocido"
                    : "Specie: ${listArgument.species?.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Status: ${listArgument.status.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Created At: ${listArgument.created.day}/${listArgument.created.month}/${listArgument.created.year}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomImageRounded extends StatelessWidget {
  const _CustomImageRounded({
    required this.listArgument,
  });

  final Result listArgument;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: listArgument.id,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.3,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width),
          child: Image(
            image: NetworkImage(listArgument.image),
          ),
        ),
      ),
    );
  }
}
