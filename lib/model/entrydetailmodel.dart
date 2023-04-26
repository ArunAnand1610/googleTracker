class MovieDetails {
    MovieDetails({
        required this.imName,
        required this.imImage,
        required this.imItemCount,
        required this.imPrice,
        required this.imContentType,
        required this.rights,
        required this.title,
        required this.link,
        required this.id,
        required this.imArtist,
        required this.category,
        required this.imReleaseDate,
    });

    final ImItemCount? imName;
    final List<ImImage> imImage;
    final ImItemCount? imItemCount;
    final ImPrice? imPrice;
    final MovieDetailsImContentType? imContentType;
    final ImItemCount? rights;
    final ImItemCount? title;
    final Link? link;
    final Id? id;
    final ImArtist? imArtist;
    final Category? category;
    final ImReleaseDate? imReleaseDate;

    factory MovieDetails.fromJson(Map<String, dynamic> json){ 
        return MovieDetails(
            imName: json["im:name"] == null ? null : ImItemCount.fromJson(json["im:name"]),
            imImage: json["im:image"] == null ? [] : List<ImImage>.from(json["im:image"]!.map((x) => ImImage.fromJson(x))),
            imItemCount: json["im:itemCount"] == null ? null : ImItemCount.fromJson(json["im:itemCount"]),
            imPrice: json["im:price"] == null ? null : ImPrice.fromJson(json["im:price"]),
            imContentType: json["im:contentType"] == null ? null : MovieDetailsImContentType.fromJson(json["im:contentType"]),
            rights: json["rights"] == null ? null : ImItemCount.fromJson(json["rights"]),
            title: json["title"] == null ? null : ImItemCount.fromJson(json["title"]),
            link: json["link"] == null ? null : Link.fromJson(json["link"]),
            id: json["id"] == null ? null : Id.fromJson(json["id"]),
            imArtist: json["im:artist"] == null ? null : ImArtist.fromJson(json["im:artist"]),
            category: json["category"] == null ? null : Category.fromJson(json["category"]),
            imReleaseDate: json["im:releaseDate"] == null ? null : ImReleaseDate.fromJson(json["im:releaseDate"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "im:name": imName?.toJson(),
        "im:image": imImage.map((x) => x?.toJson()).toList(),
        "im:itemCount": imItemCount?.toJson(),
        "im:price": imPrice?.toJson(),
        "im:contentType": imContentType?.toJson(),
        "rights": rights?.toJson(),
        "title": title?.toJson(),
        "link": link?.toJson(),
        "id": id?.toJson(),
        "im:artist": imArtist?.toJson(),
        "category": category?.toJson(),
        "im:releaseDate": imReleaseDate?.toJson(),
    };

}

class Category {
    Category({
        required this.attributes,
    });

    final CategoryAttributes? attributes;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            attributes: json["attributes"] == null ? null : CategoryAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
    };

}

class CategoryAttributes {
    CategoryAttributes({
        required this.imId,
        required this.term,
        required this.scheme,
        required this.label,
    });

    final String? imId;
    final String? term;
    final String? scheme;
    final String? label;

    factory CategoryAttributes.fromJson(Map<String, dynamic> json){ 
        return CategoryAttributes(
            imId: json["im:id"],
            term: json["term"],
            scheme: json["scheme"],
            label: json["label"],
        );
    }

    Map<String, dynamic> toJson() => {
        "im:id": imId,
        "term": term,
        "scheme": scheme,
        "label": label,
    };

}

class Id {
    Id({
        required this.label,
        required this.attributes,
    });

    final String? label;
    final IdAttributes? attributes;

    factory Id.fromJson(Map<String, dynamic> json){ 
        return Id(
            label: json["label"],
            attributes: json["attributes"] == null ? null : IdAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "attributes": attributes?.toJson(),
    };

}

class IdAttributes {
    IdAttributes({
        required this.imId,
    });

    final String? imId;

    factory IdAttributes.fromJson(Map<String, dynamic> json){ 
        return IdAttributes(
            imId: json["im:id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "im:id": imId,
    };

}

class ImArtist {
    ImArtist({
        required this.label,
        required this.attributes,
    });

    final String? label;
    final ImArtistAttributes? attributes;

    factory ImArtist.fromJson(Map<String, dynamic> json){ 
        return ImArtist(
            label: json["label"],
            attributes: json["attributes"] == null ? null : ImArtistAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "attributes": attributes?.toJson(),
    };

}

class ImArtistAttributes {
    ImArtistAttributes({
        required this.href,
    });

    final String? href;

    factory ImArtistAttributes.fromJson(Map<String, dynamic> json){ 
        return ImArtistAttributes(
            href: json["href"],
        );
    }

    Map<String, dynamic> toJson() => {
        "href": href,
    };

}

class MovieDetailsImContentType {
    MovieDetailsImContentType({
        required this.imContentType,
        required this.attributes,
    });

    final ImContentTypeImContentType? imContentType;
    final ImContentTypeAttributes? attributes;

    factory MovieDetailsImContentType.fromJson(Map<String, dynamic> json){ 
        return MovieDetailsImContentType(
            imContentType: json["im:contentType"] == null ? null : ImContentTypeImContentType.fromJson(json["im:contentType"]),
            attributes: json["attributes"] == null ? null : ImContentTypeAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "im:contentType": imContentType?.toJson(),
        "attributes": attributes?.toJson(),
    };

}

class ImContentTypeAttributes {
    ImContentTypeAttributes({
        required this.term,
        required this.label,
    });

    final String? term;
    final String? label;

    factory ImContentTypeAttributes.fromJson(Map<String, dynamic> json){ 
        return ImContentTypeAttributes(
            term: json["term"],
            label: json["label"],
        );
    }

    Map<String, dynamic> toJson() => {
        "term": term,
        "label": label,
    };

}

class ImContentTypeImContentType {
    ImContentTypeImContentType({
        required this.attributes,
    });

    final ImContentTypeAttributes? attributes;

    factory ImContentTypeImContentType.fromJson(Map<String, dynamic> json){ 
        return ImContentTypeImContentType(
            attributes: json["attributes"] == null ? null : ImContentTypeAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
    };

}

class ImImage {
    ImImage({
        required this.label,
        required this.attributes,
    });

    final String? label;
    final ImImageAttributes? attributes;

    factory ImImage.fromJson(Map<String, dynamic> json){ 
        return ImImage(
            label: json["label"],
            attributes: json["attributes"] == null ? null : ImImageAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "attributes": attributes?.toJson(),
    };

}

class ImImageAttributes {
    ImImageAttributes({
        required this.height,
    });

    final String? height;

    factory ImImageAttributes.fromJson(Map<String, dynamic> json){ 
        return ImImageAttributes(
            height: json["height"],
        );
    }

    Map<String, dynamic> toJson() => {
        "height": height,
    };

}

class ImItemCount {
    ImItemCount({
        required this.label,
    });

    final String? label;

    factory ImItemCount.fromJson(Map<String, dynamic> json){ 
        return ImItemCount(
            label: json["label"],
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
    };

}

class ImPrice {
    ImPrice({
        required this.label,
        required this.attributes,
    });

    final String? label;
    final ImPriceAttributes? attributes;

    factory ImPrice.fromJson(Map<String, dynamic> json){ 
        return ImPrice(
            label: json["label"],
            attributes: json["attributes"] == null ? null : ImPriceAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label,
        "attributes": attributes?.toJson(),
    };

}

class ImPriceAttributes {
    ImPriceAttributes({
        required this.amount,
        required this.currency,
    });

    final String? amount;
    final String? currency;

    factory ImPriceAttributes.fromJson(Map<String, dynamic> json){ 
        return ImPriceAttributes(
            amount: json["amount"],
            currency: json["currency"],
        );
    }

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
    };

}

class ImReleaseDate {
    ImReleaseDate({
        required this.label,
        required this.attributes,
    });

    final DateTime? label;
    final ImItemCount? attributes;

    factory ImReleaseDate.fromJson(Map<String, dynamic> json){ 
        return ImReleaseDate(
            label: DateTime.tryParse(json["label"] ?? ""),
            attributes: json["attributes"] == null ? null : ImItemCount.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "label": label?.toIso8601String(),
        "attributes": attributes?.toJson(),
    };

}

class Link {
    Link({
        required this.attributes,
    });

    final LinkAttributes? attributes;

    factory Link.fromJson(Map<String, dynamic> json){ 
        return Link(
            attributes: json["attributes"] == null ? null : LinkAttributes.fromJson(json["attributes"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
    };

}

class LinkAttributes {
    LinkAttributes({
        required this.rel,
        required this.type,
        required this.href,
    });

    final String? rel;
    final String? type;
    final String? href;

    factory LinkAttributes.fromJson(Map<String, dynamic> json){ 
        return LinkAttributes(
            rel: json["rel"],
            type: json["type"],
            href: json["href"],
        );
    }

    Map<String, dynamic> toJson() => {
        "rel": rel,
        "type": type,
        "href": href,
    };

}
