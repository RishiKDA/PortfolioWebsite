import org.mindrot.jbcrypt.BCrypt;
public class BcryptTest {
    public static void main(String[] args) {
        String hash = "$2a$12$K5J5fvCxIQUJf1z2pT7Y4OVH0O5jG3Xk8lPyRwNq6EsBdYtMaZuWa";
        String pwd = "Admin@123";
        System.out.println(BCrypt.checkpw(pwd, hash));
    }
}
