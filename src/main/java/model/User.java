package model;

import java.sql.Timestamp;

public class User {
    private int id;
    private String username;
    private String password_hash;
    private String name;
    private String phone;
    private String email;
    private String profilePictureURL;
    private String address;
    private Boolean isActive = true;
    private Timestamp createAt;
    private Timestamp updateAt;

    public User() {
    }

    public User(String username, String password_hash, String name, String phone, String email, String profilePictureURL, String address, Boolean isActive, Timestamp createAt, Timestamp updateAt) {
        this.username = username;
        this.password_hash = password_hash;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.profilePictureURL = profilePictureURL;
        this.address = address;
        this.isActive = isActive;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public User(int id, String username, String password_hash, String name, String phone, String email, String profilePictureURL, String address, Boolean isActive, Timestamp createAt, Timestamp updateAt) {
        this.id = id;
        this.username = username;
        this.password_hash = password_hash;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.profilePictureURL = profilePictureURL;
        this.address = address;
        this.isActive = isActive;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getProfilePictureURL() {
        return profilePictureURL;
    }

    public void setProfilePictureURL(String profilePictureURL) {
        this.profilePictureURL = profilePictureURL;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Boolean getActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
        isActive = active;
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
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password_hash='" + password_hash + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", profilePictureURL='" + profilePictureURL + '\'' +
                ", address='" + address + '\'' +
                ", isActive=" + isActive +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                '}';
    }
}
