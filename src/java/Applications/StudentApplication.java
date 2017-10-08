/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Applications;

/**
 *
 * @author Mango
 */

import Models.Students;
import Models.Student;
import java.io.*;
import javax.xml.bind.*;


public class StudentApplication implements Serializable{
     private String filePath;
    private Students students;
    
     public StudentApplication() {}

    public StudentApplication(String filePath, Students students) {
        super();
        this.filePath = filePath;
        this.students = students;
    }
    
     public void setFilePath(String filePath) throws Exception {

        // Create the unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Students.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath = filePath;
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        students = (Students) u.unmarshal(fin); 		
        fin.close();
    }
     
      public void addStudent(Student student) throws Exception{
         students.addUser(student);
            saveStudents();
    }
      
      /*
    public void updateXML(Students students, String filePath) throws Exception {
        this.students = students;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Students.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(students, fout);
        fout.close();
    }
*/
    
    // to be used from the welcome.jsp page
    public void saveStudents() throws JAXBException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Students.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(students, fout);
        fout.close();
    }

    public Students getStudents() {
        return students;
    }

    public void setStudents(Students students) {
        this.students = students;
    }
    
     public Student getStudentByName(String name){
        for(Student s : getStudents().getList()){
            if(s.getName().equals(name)){
                return s;
            }
        }
        return null;
    }

}
