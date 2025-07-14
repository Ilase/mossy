enum AuthType { none, basic, oauth1, bearer, jwtBearer, digestAuth, oauth2 }

class Collection {
  AuthType authType;
  Collection({
    this.authType = AuthType.none,
  });
}
