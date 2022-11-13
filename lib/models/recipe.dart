class Recipe {
  const Recipe({
    required this.label,
    required this.imageUrl,
  });

  final String label;
  final String imageUrl;

  // TODO: Add servings and ingredients here

  static List<Recipe> samples = [
    const Recipe(
      label: 'Spaghetti and Meatballs',
      imageUrl: 'assets/images/2126711929_ef763de2b3_w.jpg',
    ),
    const Recipe(
      label: 'Tomato Soup',
      imageUrl: 'assets/images/27729023535_a57606c1be.jpg',
    ),
    const Recipe(
      label: 'Grilled Cheese',
      imageUrl: 'assets/images/3187380632_5056654a19_b.jpg',
    ),
    const Recipe(
      label: 'Chocolate Chip Cookies',
      imageUrl: 'assets/images/15992102771_b92f4cc00a_b.jpg',
    ),
    const Recipe(
      label: 'Taco Salad',
      imageUrl: 'assets/images/8533381643_a31a99e8a6_c.jpg',
    ),
    const Recipe(
      label: 'Hawaiian Pizza',
      imageUrl: 'assets/images/15452035777_294cefced5_c.jpg',
    ),
  ];
}

// TODO: Add Ingredient() here
