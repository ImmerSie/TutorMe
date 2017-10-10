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
    
    // Fields to maintain tutor data, and retrieve it
    private String filePath;
    private Tutors tutors;
    
    // Fields to search for a tutor by parameters
    private String searchedBy;
    private String searchedVal;
    
    public TutorApplication() {}

    public TutorApplication(String filePath, Tutors tutors) {
        super();
        this.filePath = filePath;
        this.tutors = tutors;
    }
    
    /**
     * Adds a tutor to the XML data
     * 
     * @param tutor The tutor to be added to the XML
     * @throws JAXBException Marshalling exception
     * @throws IOException File not found
     */
    public void addTutor(Tutor tutor) throws JAXBException, IOException {
        tutors.addUser(tutor);
        saveTutors();
    }
    
    /**
     * Reads the XML file into the field
     * 
     * @param filePath The location of the XML file
     * @throws JAXBException Marshalling exception
     * @throws IOException File reading exception
     */
    public void setFilePath(String filePath) throws JAXBException, IOException {

        // Create the unmarshaller
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath = filePath;
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        tutors = (Tutors) u.unmarshal(fin); 		
        fin.close();
    }
    
    /**
     * Saves the tutor data into the XML file
     * 
     * @throws JAXBException Marshalling exception
     * @throws IOException File not found
     */
    public void saveTutors() throws JAXBException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
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
    
    public void clearSearch(String searchFilepath) throws JAXBException, IOException{
        Tutors searchedTutors = new Tutors();
        JAXBContext jc = JAXBContext.newInstance(Tutors.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(searchFilepath);
        m.marshal(searchedTutors, fout);
        fout.close();
    }
    
    public void searchTutors(String searchFilepath, String searchBy, String searchVal) throws JAXBException, IOException{
        this.searchedBy = searchBy;
        this.searchedVal = searchVal;
        clearSearch(searchFilepath);
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
    
    public Tutors getTutorsByEmail(String email){
        Tutors tutors = new Tutors();
        for(Tutor b : this.tutors.getList()){
            if(b.getEmail().equals(email)){
                tutors.getList().add(b);
            }
        }
        return tutors;
    }
    
    public void updateTutor(String email, String name, String password, String dob) throws JAXBException, IOException{
        Tutor tutor = getTutorFromEmail(email);
        tutor.setName(name);
        tutor.setPassword(password);
        tutor.setBirthday(dob);
        saveTutors();
     }
    
    public void cancelTutorsByEmail(ArrayList<String> tutorEmail) throws JAXBException, IOException{
        for(Tutor t : tutors.getList()){
            if(t.getEmail().equals(tutorEmail)){
                t.setStatus("available");
            }
        }
        saveTutors();
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
    

    public Tutors getTutorsByStatus(String status){
        Tutors tutors = new Tutors();
        for(Tutor b : this.tutors.getList()){
            if(b.getStatus().equals(status)){
                tutors.getList().add(b);
            }
        }
        return tutors;
    }
     
    public void setTutors(Tutors tutors) {
        this.tutors = tutors;
    }

}

