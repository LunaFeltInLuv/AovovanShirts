package utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectDB {

    private static final String URL = "jdbc:sqlserver://localhost:1433;"
            + "databaseName=aovovan_db;"
            + "encrypt=true;"
            + "trustServerCertificate=true";

    private static final String USER = "sa";
    private static final String PASSWORD = "1234";

    public static Connection getConnect() {

        try {

            Class.forName(
                    "com.microsoft.sqlserver.jdbc.SQLServerDriver");

            Connection conn = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD);

            System.out.println("Kết nối thành công");

            return conn;

        } catch (Exception e) {

            System.out.println("Kết nối thất bại");

            e.printStackTrace();

            return null;
        }
    }
}
