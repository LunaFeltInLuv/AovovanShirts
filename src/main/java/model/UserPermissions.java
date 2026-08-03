package model;

public class UserPermissions {
    private int roleId;
    private int permissionId;

    public UserPermissions() {
    }

    public UserPermissions(int roleId, int permissionId) {
        this.roleId = roleId;
        this.permissionId = permissionId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(int permissionId) {
        this.permissionId = permissionId;
    }

    @Override
    public String toString() {
        return "UserPermissions{" +
                "roleId=" + roleId +
                ", permissionId=" + permissionId +
                '}';
    }
}
