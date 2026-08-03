package model;

import java.security.Timestamp;

public class Carts {
    private int Id;
    private int userId;
    private Timestamp createAt;
    private Timestamp updateAt;

    public Carts() {
    }

    public Carts(int id, int userId, Timestamp createAt, Timestamp updateAt) {
        Id = id;
        this.userId = userId;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "Carts{" +
                "Id=" + Id +
                ", userId=" + userId +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                '}';
    }
}
