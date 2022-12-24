import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/data/models/models.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  //1
  static const _databaseName = 'MyRecipes.db';
  static const _databaseVersion = 1;
  //2
  static const recipeTable = 'Recipe';
  static const ingredientTable = 'Ingredient';
  static const recipeId = 'recipeId';
  static const ingredientId = 'ingredientId';

  //3
  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  // 4
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //5
  static var lock = Lock();

  // only have a single app-wide reference to the database
  // 6
  static Database? _database;

  // SQL code to create the database table
  // 1
  Future _onCreate(Database db, int version) async {
    //Create Recipe Table
    await db.execute('''
CREATE TABLE $recipeTable (
  $recipeId INTEGER PRIMARY KEY,
  label TEXT,
  image TEXT,
  url TEXT,
  calories REAL,
  totalWeight REAL,
  totalTime REAL
)''');

//Create Ingredient Table
    await db.execute('''
CREATE TABLE $ingredientTable (
  $ingredientId INTEGER PRIMARY KEY,
  $recipeId INTEGER,
  name TEXT,
  weight REAL
)
''');
  }

// This opens the database if it exists || creates it if it doesn't exist.
  //1
  Future<Database> _initDatabase() async {
    //2
    final documentsDirectory = await getApplicationDocumentsDirectory();
    //3
    final path = join(documentsDirectory.path, _databaseName);

    //4
    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  //1
  Future<Database> get database async {
    if (_database != null) return _database!;

    await lock.synchronized(
      () async {
        if (_database == null) {
          _database = await _initDatabase();
          _streamDatabase = BriteDatabase(_database!);
        }
      },
    );
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    final recipes = <Recipe>[];
    for (final recipeMap in recipeList) {
      recipes.add(Recipe.fromJson(recipeMap));
    }
    return recipes;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    final ingredients = <Ingredient>[];
    for (final ingredientMap in ingredientList) {
      ingredients.add(Ingredient.fromJson(ingredientMap));
    }
    return ingredients;
  }

  Future<List<Recipe>> findAllRecipes() async {
    final db = await instance.streamDatabase;
    final recipeList = await db.query(recipeTable);
    final recipes = parseRecipes(recipeList);
    return recipes;
  }

  Stream<List<Recipe>> watchAllRecipes() async* {
    final db = await instance.streamDatabase;
    yield* db.createQuery(recipeTable).mapToList((row) => Recipe.fromJson(row));
  }

  Stream<List<Ingredient>> watchAllIngredients() async* {
    final db = await instance.streamDatabase;
    yield* db
        .createQuery(ingredientTable)
        .mapToList((row) => Ingredient.fromJson(row));
  }

  Future<Recipe> findRecipeById(int id) async {
    final db = await instance.streamDatabase;
    final recipeList = await db.query(
      recipeTable,
      where: 'id = $id',
    );
    final recipes = parseRecipes(recipeList);
    return recipes.first;
  }

  Future<List<Ingredient>> findAllIngredients() async {
    final db = await instance.streamDatabase;
    final ingredientList = await db.query(ingredientTable);
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

  Future<List<Ingredient>> findRecipeIngredients(int recipeId) async {
    final db = await instance.streamDatabase;
    final ingredientList = await db.query(
      ingredientTable,
      where: '${DatabaseHelper.recipeId} = $recipeId',
    );
    final ingredients = parseIngredients(ingredientList);
    return ingredients;
  }

// 1
  Future<int> _insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;
    // 2
    return db.insert(
      table,
      row,
    );
  }

  Future<int> insertRecipe(Recipe recipe) {
    // 3
    return _insert(
      recipeTable,
      recipe.toJson(),
    );
  }

  Future<int> insertIngredient(Ingredient ingredient) {
    // 4
    return _insert(
      ingredientTable,
      ingredient.toJson(),
    );
  }

// 1
  Future<int> _delete(String table, String columnId, int id) async {
    final db = await instance.streamDatabase;
    // 2
    return db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteRecipe(Recipe recipe) async {
    // 3
    if (recipe.id != null) {
      return _delete(
        recipeTable,
        recipeId,
        recipe.id!,
      );
    } else {
      return Future.value(-1);
    }
  }

  Future<int> deleteIngredient(Ingredient ingredient) async {
    if (ingredient.id != null) {
      return _delete(
        ingredientTable,
        ingredientId,
        ingredient.id!,
      );
    } else {
      return Future.value(-1);
    }
  }

  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    // 4
    for (final ingredient in ingredients) {
      if (ingredient.id != null) {
        _delete(
          ingredientTable,
          ingredientId,
          ingredient.id!,
        );
      }
    }
    return Future.value();
  }

  Future<int> deleteRecipeIngredients(int id) async {
    final db = await instance.streamDatabase;
    // 5
    return db.delete(
      ingredientTable,
      where: '$recipeId = ?',
      whereArgs: [id],
    );
  }

  void close() {
    _streamDatabase.close();
  }
}
