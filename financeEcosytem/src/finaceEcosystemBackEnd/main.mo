
type User = {
  username : Text;
  password : Text;
  balance : Nat;
};

actor class Wallet {
  var users : HashMap.Text<User> = HashMap<Text, User>();

  public shared(msg) func signUp(username : Text, password : Text) : async () {
    if (!users.contains(username)) {
      let newUser = {username = username; password = password; balance = 0};
      users.put(username, newUser);
      msg.reply("User signed up successfully!");
    } else {
      msg.reply("Username already exists. Please choose a different username.");
    }
  };

  public shared(msg) func login(username : Text, password : Text) : async User {
    if (users.contains(username) && users.get(username).password == password) {
      msg.reply("User logged in successfully!");
      return users.get(username);
    } else {
      msg.reply("Invalid username or password.");
      return {username = ""; password = ""; balance = 0};
    }
  };
};
