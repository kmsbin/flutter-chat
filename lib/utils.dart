class Utils {
  static String wsConnectionUriBuilder({required String name, required String id}) {
    return "wss://golchat.herokuapp.com/ws/$name/$id";
  }
}
