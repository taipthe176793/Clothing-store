package DAL;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    protected Connection connect;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://"+serverName+":"+portNumber+";databaseName="+dbName;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connect = DriverManager.getConnection(url, userID, password);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private final String serverName = "localhost";
    private final String dbName = "Online_Clothing_Store";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "123";
    
}
