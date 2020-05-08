//  This file was automatically generated and should not be edited.

import Apollo

/// API namespace
public enum API {
  public enum Currency: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case usd
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "USD": self = .usd
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .usd: return "USD"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: Currency, rhs: Currency) -> Bool {
      switch (lhs, rhs) {
        case (.usd, .usd): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }
  }

  public enum ListNewListingError: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case unauthenticated
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "Unauthenticated": self = .unauthenticated
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .unauthenticated: return "Unauthenticated"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: ListNewListingError, rhs: ListNewListingError) -> Bool {
      switch (lhs, rhs) {
        case (.unauthenticated, .unauthenticated): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }
  }

  public enum UpdateListingError: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case listingDoesNotExist
    case unauthorized
    case unauthenticated
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "ListingDoesNotExist": self = .listingDoesNotExist
        case "Unauthorized": self = .unauthorized
        case "Unauthenticated": self = .unauthenticated
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .listingDoesNotExist: return "ListingDoesNotExist"
        case .unauthorized: return "Unauthorized"
        case .unauthenticated: return "Unauthenticated"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: UpdateListingError, rhs: UpdateListingError) -> Bool {
      switch (lhs, rhs) {
        case (.listingDoesNotExist, .listingDoesNotExist): return true
        case (.unauthorized, .unauthorized): return true
        case (.unauthenticated, .unauthenticated): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }
  }

  public final class CreateMarketplaceListingMutation: GraphQLMutation {
    public let operationDefinition =
      "mutation CreateMarketplaceListing($name: ListingName!, $description: ListingDescription!, $photo: Base64ListingPhoto!, $priceCurrency: Currency!, $priceAmount: PriceAmount!) {\n  listNewListing(name: $name, description: $description, photo: $photo, priceCurrency: $priceCurrency, priceAmount: $priceAmount) {\n    __typename\n    listing {\n      __typename\n      id\n      name\n      description\n      photo\n      price {\n        __typename\n        currency\n        amount\n      }\n      listedAt\n      seller {\n        __typename\n        id\n        emailAddress\n        username\n        firstName\n        lastName\n        profilePicture\n      }\n    }\n    error\n  }\n}"

    public var name: String
    public var description: String
    public var photo: String
    public var priceCurrency: Currency
    public var priceAmount: String

    public init(name: String, description: String, photo: String, priceCurrency: Currency, priceAmount: String) {
      self.name = name
      self.description = description
      self.photo = photo
      self.priceCurrency = priceCurrency
      self.priceAmount = priceAmount
    }

    public var variables: GraphQLMap? {
      return ["name": name, "description": description, "photo": photo, "priceCurrency": priceCurrency, "priceAmount": priceAmount]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes = ["Mutation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("listNewListing", arguments: ["name": GraphQLVariable("name"), "description": GraphQLVariable("description"), "photo": GraphQLVariable("photo"), "priceCurrency": GraphQLVariable("priceCurrency"), "priceAmount": GraphQLVariable("priceAmount")], type: .nonNull(.object(ListNewListing.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(listNewListing: ListNewListing) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "listNewListing": listNewListing.resultMap])
      }

      /// list new listing
      public var listNewListing: ListNewListing {
        get {
          return ListNewListing(unsafeResultMap: resultMap["listNewListing"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "listNewListing")
        }
      }

      public struct ListNewListing: GraphQLSelectionSet {
        public static let possibleTypes = ["ListNewListingResponse"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("listing", type: .object(Listing.selections)),
          GraphQLField("error", type: .scalar(ListNewListingError.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(listing: Listing? = nil, error: ListNewListingError? = nil) {
          self.init(unsafeResultMap: ["__typename": "ListNewListingResponse", "listing": listing.flatMap { (value: Listing) -> ResultMap in value.resultMap }, "error": error])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// the created listing
        public var listing: Listing? {
          get {
            return (resultMap["listing"] as? ResultMap).flatMap { Listing(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listing")
          }
        }

        /// error that happend during listing listing
        public var error: ListNewListingError? {
          get {
            return resultMap["error"] as? ListNewListingError
          }
          set {
            resultMap.updateValue(newValue, forKey: "error")
          }
        }

        public struct Listing: GraphQLSelectionSet {
          public static let possibleTypes = ["Listing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("photo", type: .nonNull(.scalar(String.self))),
            GraphQLField("price", type: .nonNull(.object(Price.selections))),
            GraphQLField("listedAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("seller", type: .nonNull(.object(Seller.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String, description: String, photo: String, price: Price, listedAt: String, seller: Seller) {
            self.init(unsafeResultMap: ["__typename": "Listing", "id": id, "name": name, "description": description, "photo": photo, "price": price.resultMap, "listedAt": listedAt, "seller": seller.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var description: String {
            get {
              return resultMap["description"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          public var photo: String {
            get {
              return resultMap["photo"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "photo")
            }
          }

          public var price: Price {
            get {
              return Price(unsafeResultMap: resultMap["price"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "price")
            }
          }

          public var listedAt: String {
            get {
              return resultMap["listedAt"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "listedAt")
            }
          }

          public var seller: Seller {
            get {
              return Seller(unsafeResultMap: resultMap["seller"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "seller")
            }
          }

          public struct Price: GraphQLSelectionSet {
            public static let possibleTypes = ["Price"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("currency", type: .nonNull(.scalar(Currency.self))),
              GraphQLField("amount", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(currency: Currency, amount: String) {
              self.init(unsafeResultMap: ["__typename": "Price", "currency": currency, "amount": amount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var currency: Currency {
              get {
                return resultMap["currency"]! as! Currency
              }
              set {
                resultMap.updateValue(newValue, forKey: "currency")
              }
            }

            public var amount: String {
              get {
                return resultMap["amount"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "amount")
              }
            }
          }

          public struct Seller: GraphQLSelectionSet {
            public static let possibleTypes = ["Seller"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
              GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
              GraphQLField("username", type: .nonNull(.scalar(String.self))),
              GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
              GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
              GraphQLField("profilePicture", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: String, emailAddress: String, username: String, firstName: String, lastName: String, profilePicture: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Seller", "id": id, "emailAddress": emailAddress, "username": username, "firstName": firstName, "lastName": lastName, "profilePicture": profilePicture])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: String {
              get {
                return resultMap["id"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var emailAddress: String {
              get {
                return resultMap["emailAddress"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "emailAddress")
              }
            }

            public var username: String {
              get {
                return resultMap["username"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "username")
              }
            }

            public var firstName: String {
              get {
                return resultMap["firstName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "firstName")
              }
            }

            public var lastName: String {
              get {
                return resultMap["lastName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "lastName")
              }
            }

            public var profilePicture: String? {
              get {
                return resultMap["profilePicture"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "profilePicture")
              }
            }
          }
        }
      }
    }
  }

  public final class MarketplaceListingsQuery: GraphQLQuery {
    public let operationDefinition =
      "query MarketplaceListings($fromId: ListingID, $count: Int!) {\n  listings(start: $fromId, next: $count) {\n    __typename\n    id\n    name\n    description\n    photo\n    price {\n      __typename\n      currency\n      amount\n    }\n    listedAt\n    seller {\n      __typename\n      id\n      emailAddress\n      username\n      firstName\n      lastName\n      profilePicture\n    }\n  }\n}"

    public var fromId: String?
    public var count: Int

    public init(fromId: String? = nil, count: Int) {
      self.fromId = fromId
      self.count = count
    }

    public var variables: GraphQLMap? {
      return ["fromId": fromId, "count": count]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes = ["Query"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("listings", arguments: ["start": GraphQLVariable("fromId"), "next": GraphQLVariable("count")], type: .nonNull(.list(.nonNull(.object(Listing.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(listings: [Listing]) {
        self.init(unsafeResultMap: ["__typename": "Query", "listings": listings.map { (value: Listing) -> ResultMap in value.resultMap }])
      }

      /// get all listings
      public var listings: [Listing] {
        get {
          return (resultMap["listings"] as! [ResultMap]).map { (value: ResultMap) -> Listing in Listing(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Listing) -> ResultMap in value.resultMap }, forKey: "listings")
        }
      }

      public struct Listing: GraphQLSelectionSet {
        public static let possibleTypes = ["Listing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("photo", type: .nonNull(.scalar(String.self))),
          GraphQLField("price", type: .nonNull(.object(Price.selections))),
          GraphQLField("listedAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("seller", type: .nonNull(.object(Seller.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, name: String, description: String, photo: String, price: Price, listedAt: String, seller: Seller) {
          self.init(unsafeResultMap: ["__typename": "Listing", "id": id, "name": name, "description": description, "photo": photo, "price": price.resultMap, "listedAt": listedAt, "seller": seller.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var description: String {
          get {
            return resultMap["description"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var photo: String {
          get {
            return resultMap["photo"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "photo")
          }
        }

        public var price: Price {
          get {
            return Price(unsafeResultMap: resultMap["price"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "price")
          }
        }

        public var listedAt: String {
          get {
            return resultMap["listedAt"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listedAt")
          }
        }

        public var seller: Seller {
          get {
            return Seller(unsafeResultMap: resultMap["seller"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "seller")
          }
        }

        public struct Price: GraphQLSelectionSet {
          public static let possibleTypes = ["Price"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("currency", type: .nonNull(.scalar(Currency.self))),
            GraphQLField("amount", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(currency: Currency, amount: String) {
            self.init(unsafeResultMap: ["__typename": "Price", "currency": currency, "amount": amount])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var currency: Currency {
            get {
              return resultMap["currency"]! as! Currency
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }

          public var amount: String {
            get {
              return resultMap["amount"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "amount")
            }
          }
        }

        public struct Seller: GraphQLSelectionSet {
          public static let possibleTypes = ["Seller"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("profilePicture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, emailAddress: String, username: String, firstName: String, lastName: String, profilePicture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Seller", "id": id, "emailAddress": emailAddress, "username": username, "firstName": firstName, "lastName": lastName, "profilePicture": profilePicture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var emailAddress: String {
            get {
              return resultMap["emailAddress"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "emailAddress")
            }
          }

          public var username: String {
            get {
              return resultMap["username"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "username")
            }
          }

          public var firstName: String {
            get {
              return resultMap["firstName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String {
            get {
              return resultMap["lastName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var profilePicture: String? {
            get {
              return resultMap["profilePicture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "profilePicture")
            }
          }
        }
      }
    }
  }

  public final class EditMarketplaceListingMutation: GraphQLMutation {
    public let operationDefinition =
      "mutation EditMarketplaceListing($id: ListingID!, $name: ListingName!, $description: ListingDescription!, $photo: Base64ListingPhoto!, $priceCurrency: Currency!, $priceAmount: PriceAmount!) {\n  updateListing(input: {id: $id, name: $name, description: $description, photo: $photo, priceCurrency: $priceCurrency, priceAmount: $priceAmount}) {\n    __typename\n    listing {\n      __typename\n      id\n      name\n      description\n      photo\n      price {\n        __typename\n        currency\n        amount\n      }\n      listedAt\n      seller {\n        __typename\n        id\n        emailAddress\n        username\n        firstName\n        lastName\n        profilePicture\n      }\n    }\n    error\n  }\n}"

    public var id: String
    public var name: String
    public var description: String
    public var photo: String
    public var priceCurrency: Currency
    public var priceAmount: String

    public init(id: String, name: String, description: String, photo: String, priceCurrency: Currency, priceAmount: String) {
      self.id = id
      self.name = name
      self.description = description
      self.photo = photo
      self.priceCurrency = priceCurrency
      self.priceAmount = priceAmount
    }

    public var variables: GraphQLMap? {
      return ["id": id, "name": name, "description": description, "photo": photo, "priceCurrency": priceCurrency, "priceAmount": priceAmount]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes = ["Mutation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("updateListing", arguments: ["input": ["id": GraphQLVariable("id"), "name": GraphQLVariable("name"), "description": GraphQLVariable("description"), "photo": GraphQLVariable("photo"), "priceCurrency": GraphQLVariable("priceCurrency"), "priceAmount": GraphQLVariable("priceAmount")]], type: .nonNull(.object(UpdateListing.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(updateListing: UpdateListing) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "updateListing": updateListing.resultMap])
      }

      /// update a listing
      public var updateListing: UpdateListing {
        get {
          return UpdateListing(unsafeResultMap: resultMap["updateListing"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "updateListing")
        }
      }

      public struct UpdateListing: GraphQLSelectionSet {
        public static let possibleTypes = ["UpdateListingResponse"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("listing", type: .object(Listing.selections)),
          GraphQLField("error", type: .scalar(UpdateListingError.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(listing: Listing? = nil, error: UpdateListingError? = nil) {
          self.init(unsafeResultMap: ["__typename": "UpdateListingResponse", "listing": listing.flatMap { (value: Listing) -> ResultMap in value.resultMap }, "error": error])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var listing: Listing? {
          get {
            return (resultMap["listing"] as? ResultMap).flatMap { Listing(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listing")
          }
        }

        public var error: UpdateListingError? {
          get {
            return resultMap["error"] as? UpdateListingError
          }
          set {
            resultMap.updateValue(newValue, forKey: "error")
          }
        }

        public struct Listing: GraphQLSelectionSet {
          public static let possibleTypes = ["Listing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .nonNull(.scalar(String.self))),
            GraphQLField("photo", type: .nonNull(.scalar(String.self))),
            GraphQLField("price", type: .nonNull(.object(Price.selections))),
            GraphQLField("listedAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("seller", type: .nonNull(.object(Seller.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, name: String, description: String, photo: String, price: Price, listedAt: String, seller: Seller) {
            self.init(unsafeResultMap: ["__typename": "Listing", "id": id, "name": name, "description": description, "photo": photo, "price": price.resultMap, "listedAt": listedAt, "seller": seller.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var description: String {
            get {
              return resultMap["description"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          public var photo: String {
            get {
              return resultMap["photo"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "photo")
            }
          }

          public var price: Price {
            get {
              return Price(unsafeResultMap: resultMap["price"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "price")
            }
          }

          public var listedAt: String {
            get {
              return resultMap["listedAt"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "listedAt")
            }
          }

          public var seller: Seller {
            get {
              return Seller(unsafeResultMap: resultMap["seller"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "seller")
            }
          }

          public struct Price: GraphQLSelectionSet {
            public static let possibleTypes = ["Price"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("currency", type: .nonNull(.scalar(Currency.self))),
              GraphQLField("amount", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(currency: Currency, amount: String) {
              self.init(unsafeResultMap: ["__typename": "Price", "currency": currency, "amount": amount])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var currency: Currency {
              get {
                return resultMap["currency"]! as! Currency
              }
              set {
                resultMap.updateValue(newValue, forKey: "currency")
              }
            }

            public var amount: String {
              get {
                return resultMap["amount"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "amount")
              }
            }
          }

          public struct Seller: GraphQLSelectionSet {
            public static let possibleTypes = ["Seller"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
              GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
              GraphQLField("username", type: .nonNull(.scalar(String.self))),
              GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
              GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
              GraphQLField("profilePicture", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: String, emailAddress: String, username: String, firstName: String, lastName: String, profilePicture: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Seller", "id": id, "emailAddress": emailAddress, "username": username, "firstName": firstName, "lastName": lastName, "profilePicture": profilePicture])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: String {
              get {
                return resultMap["id"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var emailAddress: String {
              get {
                return resultMap["emailAddress"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "emailAddress")
              }
            }

            public var username: String {
              get {
                return resultMap["username"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "username")
              }
            }

            public var firstName: String {
              get {
                return resultMap["firstName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "firstName")
              }
            }

            public var lastName: String {
              get {
                return resultMap["lastName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "lastName")
              }
            }

            public var profilePicture: String? {
              get {
                return resultMap["profilePicture"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "profilePicture")
              }
            }
          }
        }
      }
    }
  }
}