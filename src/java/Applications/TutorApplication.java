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
    private String searchedBy;
    private String searchedVal;
    
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
    /*public void updateXML(Tutors tutors, String filePath) throws Exception {
        this.tutors = tutors;
        this.filePath2 = filePath;
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        
      //  File f = new File()
        
        FileOutputStream fout = new FileOutputStream(filePath2);
        m.marshal(tutors, fout);
        fout.close();
            
    }*/
    
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
    
    private Tutors getTutorByStatus(String status){
        Tutors searchTutors = new Tutors();
        for(Tutor t : tutors.getList()){
            if(t.getStatus().toLowerCase().equals(status.toLowerCase())){
                searchTutors.addUser(t);
            }
        }
        return searchTutors;
    }
    
    private Tutors getTutorsByName(String name){
        Tutors searchTutors = new Tutors();
        for(Tutor t : tutors.getList()){
            if(t.getName().toLowerCase().contains(name.toLowerCase())){
                searchTutors.addUser(t);
            }
        }
        return searchTutors;
    }
    
    private Tutors getTutorsBySubject(String subject){
        Tutors searchTutors = new Tutors();
        for(Tutor t : tutors.getList()){
            if(t.getSubject().toLowerCase().contains(subject.toLowerCase())){
                searchTutors.addUser(t);
            }
        }
        return searchTutors;
    }
    
    public void searchTutors(String searchFilepath, String searchBy, String searchVal) throws JAXBException, IOException{
        this.searchedBy = searchBy;
        this.searchedVal = searchVal;
        Tutors searchTutors = null;
        if(searchBy.equals("searchSubject")){
            searchTutors = getTutorsBySubject(searchVal);
        }
        else if(searchBy.equals("searchName")){
            searchTutors = getTutorsByName(searchVal);
        }
        else{
            searchTutors = getTutorByStatus(searchVal);
        }
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(searchFilepath);
        m.marshal(searchTutors, fout);
        fout.close();
    }
    
    public boolean checkCorrectSearch(String searchedFilepath, String by, String val) throws Exception{
        Tutors searchedTutors = getAllSearchedTutors(searchedFilepath);
        if(by.equals("searchName") && searchedTutors.getList().get(0).getName().toLowerCase().contains(val.toLowerCase())){
            return true;
        }
        else if(by.equals("searchSubject") && searchedTutors.getList().get(0).getSubject().toLowerCase().contains(val.toLowerCase())){
            return true;
        }
        else if(by.equals("searchStatus") && searchedTutors.getList().get(0).getStatus().toLowerCase().equals(val.toLowerCase())){
            return true;
        }
        else{
            return false;
        }
    }
    
    public Tutors getAllSearchedTutors(String searchedFilepath) throws Exception{
       // Create the unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Unmarshaller u = jc.createUnmarshaller();
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(searchedFilepath);
        Tutors searchedTutors = (Tutors) u.unmarshal(fin); 
        fin.close();
        return searchedTutors;
    }
    
    public Tutor getTutorFromEmail(String email){
        for(Tutor t : getTutors().getList()){
            if(t.getEmail().equals(email)){
                return t;
            }
        }
        return null;
    }
    
     public Tutor getTutorFromID(String name){
        for(Tutor t : getTutors().getList()){
            if(t.getName().toLowerCase().contains(name.toLowerCase())){
                return t;
            }
        }
        return null;
    }
    
    public ArrayList<Tutor> getTutorBySubject(String subject){
        ArrayList<Tutor> tutorList = new ArrayList<Tutor>();
        for(Tutor t : this.tutors.getList()){
            if(t.getSubject().toLowerCase().equals(subject.toLowerCase()) && t.getStatus().toLowerCase().equals("available")){
                tutorList.add(t);
            }
        }
        return tutorList;
    }
    
    /*public ArrayList<Tutor> getTutorByStatus(String status){
        ArrayList<Tutor> tutorList = new ArrayList<Tutor>();
        for(Tutor t : this.tutors.getList()){
            if(t.getStatus().toLowerCase().equals(status.toLowerCase())){
                tutorList.add(t);
            }
        }
        return tutorList;
    }*/

    public Tutors getTutorsByStatus(String status){
        Tutors tutors = new Tutors();
        for(Tutor b : this.tutors.getList()){
            if(b.getStatus().equals(status)){
                tutors.getList().add(b);
            }
        }
        return tutors;
    }
     
     /*public Tutors getAvailableTutors(){
        Tutors tutors = new Tutors();
        for(Tutor b : this.tutors.getList()){
            if(b.getStatus().equals("available")){
                tutors.getList().add(b);
            }
        }
        return tutors;
    }*/
     
     
    public void setTutors(Tutors tutors) {
        this.tutors = tutors;
    }

}

