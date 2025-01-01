enum CommandEnum{
  create, 
  unknown;
  
  static CommandEnum fromString(String? command) {
    switch (command) {
      case 'create':
        return CommandEnum.create;
      default:
        return CommandEnum.unknown;
    }
  }
}