import org.mindrot.jbcrypt.BCrypt;
public class BcryptHash {
    public static void main(String[] args) {
        String pwd = "Admin@1234";
        System.out.println(BCrypt.hashpw(pwd, BCrypt.gensalt(12)));
    }
}
