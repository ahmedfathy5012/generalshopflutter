class UnProcessedEntity implements Exception{
  @override
  String toString() {
    // TODO: implement toString
    return "Missing Fields";
  }

}

class LoginFailed implements Exception{
  @override
  String toString() {
    // TODO: implement toString
    return "Credentials Rejected";
  }
}

class RedirectionFound implements  Exception{
  @override
  String toString() {
    // TODO: implement toString
    return "Too Many Redirection.";
  }
}

class ResourceNotFound implements Exception{


  String messag;

  ResourceNotFound(this.messag);



  @override
  String toString(){
    return "Resource ${this.messag} Not Fount" ;
  }
}


class NoInternetConnection implements Exception{
  @override
  String toString() {
    // TODO: implement toString
    return "No Internet connection avaliable";
  }
}


class PropertyIsRequired implements Exception{
  String field;
  PropertyIsRequired(this.field);
  @override
  String toString() {
    // TODO: implement toString
     return 'Property ${this.field} Is Required';
  }
}