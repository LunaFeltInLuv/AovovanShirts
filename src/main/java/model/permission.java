package model;
import java.util.Objects;

public class Permission {
    private int id;
    private String name;
    private String description;


    public Permission() {
    }
    
    public Permission(String name, String description) {
        this.name = name;
        this.description = description;
    }


    public Permission(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }



    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Permission id(int id) {
        setId(id);
        return this;
    }

    public Permission name(String name) {
        setName(name);
        return this;
    }

    public Permission description(String description) {
        setDescription(description);
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Permission)) {
            return false;
        }
        Permission permission = (Permission) o;
        return id == permission.id && Objects.equals(name, permission.name) && Objects.equals(description, permission.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, description);
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            "}";
    }
    
}
