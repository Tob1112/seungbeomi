import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class Md5Encrypt {

    public static void main(String[] args) {

        String str = "roue!garcon";

        StringBuilder sb = new StringBuilder();

        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(str.getBytes());
            byte[] md5encrypt = md5.digest();

            for (int i=0; i < md5encrypt.length; i++) {
                sb.append(Integer.toHexString((int)md5encrypt[i] & 0xFF));
            }

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        System.out.println(sb);
    }
}


