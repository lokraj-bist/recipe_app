  class cmodel{
    int? id;
    String? categoryName;
    String? image;
    String? creationAt;
    String? updatedAt;

    cmodel({
     required this.id,
     required this.categoryName,
      required this.image,
      required this.creationAt,
      required this.updatedAt

  });

    cmodel.fromJson(Map<String,dynamic> json){
      id = json['id'];
      categoryName = json['attributes']['categoryName'];
      image = json['image'];
      creationAt = json['creationAt'];
      updatedAt = json['updatedAt'];

    }

    static List<cmodel> categoryFromSnapshot(List snapshot){
      return snapshot.map((category){
        return cmodel.fromJson(category);

      }).toList();
    }

  }

