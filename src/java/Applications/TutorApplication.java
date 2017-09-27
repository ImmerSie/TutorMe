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

import Models.Tutor;
import Models.Tutors;
import java.io.*;
import java.util.ArrayList;
import javax.xml.bind.*;


public class TutorApplication implements Serializable{
    
    
    private String filePath2;
    private Tutors tutors;
    
     public TutorApplication() {}

    public TutorApplication(String filePath, Tutors tutors) {
        super();
        this.filePath2 = filePath;
        this.tutors = tutors;
    }
    
     public void setFilePath(String filePath) throws Exception {

        // Create the unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath2 = filePath;
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        tutors = (Tutors) u.unmarshal(fin); 		
        fin.close();
    }
    public void updateXML(Tutors tutors, String filePath) throws Exception {
        this.tutors = tutors;
        this.filePath2 = filePath;
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
      //  File f = new File()
        
        FileOutputStream fout = new FileOutputStream(filePath2);
        m.marshal(tutors, fout);
        fout.close();
            
    }
    
    // to be used from the welcome.jsp page
    public void saveTutors() throws JAXBException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath2);
        m.marshal(tutors, fout);
        fout.close();
    }

    public Tutors getTutors() {
        return tutors;
    }
    
    public Tutor getTutorFromID(String name){
        for(Tutor t : getTutors().getList()){
            if(t.getName().equals(name)){
                return t;
            }
        }
        return null;
    }
    
    public ArrayList<Tutor> getTutorBySubject(String subject){
        ArrayList<Tutor> tutorList = new ArrayList<Tutor>();
        for(Tutor t : this.tutors.getList()){
            if(t.getSubject().toLowerCase().equals(subject.toLowerCase())){
                tutorList.add(t);
            }
        }
        return tutorList;
    }

    public void setTutors(Tutors tutors) {
        this.tutors = tutors;
    }

}

