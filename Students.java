
import java.util.*;
import java.io.Serializable;
import javax.xml.bind.annotation.*;
 
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="students")
public class Students implements Serializable {
    @XmlElement(name="student")
    private ArrayList<Student> list = new ArrayList<Student>();

    public ArrayList<Student> getList() {
        return list;
    }
    
    public void addUser(Student student) {
      
        list.add(student);
    }
    
    public Student getUser(String email) {
        for (Student student : list) {
            if (student.getEmail().equals(email)) {
                return student;
            }
        }
        return null;
    }

    public void removeUser(Student student) {
        list.remove(student);
    }
    public Student login(String email, String password) {
        // For each user in the list...
        for (Student student : list) {
            if (student.getEmail().equals(email) && student.getPassword().equals(password))
                return student; // Login correct. Return this user.
        }
        return null; // Login incorrect. Return null.
    }
}