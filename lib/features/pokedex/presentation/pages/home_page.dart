import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokedex/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/presentation/pages/favorites_page.dart';
import 'package:pokedex/features/pokedex/services/pokemon_service.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_card.dart';
import 'package:pokedex/features/provider/favorite_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PokemonService _pokemonService = PokemonService();
  List<PokemonModel> pokemons = [];
  List<PokemonModel> filteredPokemons = [];

  final ScrollController scrollController = ScrollController();

  bool isLoadingMore = false;
  int offset = 0;

  Future loadPokemons() async {
    if (pokemons.isEmpty) {
      setState(() {
        isLoading = true;
        errorApi = false;
      });
    }
    setState(() {
      isLoadingMore = true;
    });
    final result = await _pokemonService.getPokemons(offset);
    setState(() {
      isLoading = false;
      isLoadingMore = false;

      pokemons.addAll(result);
      filteredPokemons = [...pokemons];
      offset += 20;

      if (result.isEmpty) {
        errorApi = true;
      }
    });
  }

  void loadFavorites() async {
    ref.read(favoriteProvider.notifier).loadFavorites();
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
    loadPokemons();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (!isLoading && !isLoadingMore) {
          loadPokemons();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool errorApi = false;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteProvider);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pokédex',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Favoritespage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore os Pokémon...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        filteredPokemons = pokemons
                            .where(
                              (item) => item.name.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      hintText: 'Buscar Pokémon...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: errorApi
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Erro ao carregar Pokémons'),
                      ElevatedButton(
                        onPressed: () {
                          loadPokemons();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  )
                : isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: loadPokemons,
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      itemCount:
                          filteredPokemons.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == filteredPokemons.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ), // Loading pequeno discreto
                            ),
                          );
                        }
                        final pokemon = filteredPokemons[index];
                        final isFavorite = favorites.any(
                          (e) => e.id == pokemon.id,
                        );
                        return PokemonCard(
                          pokemon: pokemon,
                          onFavoriteTap: () {
                            final notifier = ref.read(
                              favoriteProvider.notifier,
                            );
                            if (isFavorite) {
                              notifier.removePokemon(pokemon);
                            } else {
                              notifier.addPokemon(pokemon);
                            }
                          },
                          isFavorite: isFavorite,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
