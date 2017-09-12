
import java.util.*;
import java.io.Serializable;
import javax.xml.bind.annotation.*;
 
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="tutors")
public class Tutors implements Serializable {
    @XmlElement(name="tutor")
    private ArrayList<Tutor> list = new ArrayList<Tutor>();

    public ArrayList<Tutor> getList() {
        return list;
    }
    
    public void addUser(Tutor tutor) {
      
        list.add(tutor);
    }
    
    public Tutor getUser(String email) {
        for (Tutor tutor : list) {
            if (tutor.getEmail().equals(email)) {
                return tutor;
            }
        }
        return null;
    }

    public void removeUser(Tutor tutor) {
        list.remove(tutor);
    }
    public Tutor login(String email, String password) {
        // For each user in the list...
        for (Tutor tutor : list) {
            if (tutor.getEmail().equals(email) && tutor.getPassword().equals(password))
                return tutor; // Login correct. Return this user.
        }
        return null; // Login incorrect. Return null.
    }
}