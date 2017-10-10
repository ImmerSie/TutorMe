/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Applications;

import Models.Booking;
import Models.Bookings;
import Models.Student;
import Models.Tutor;
import Models.Tutors;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

/**
 *
 * @author Max
 */
public class BookingApplication {
    
    // The path to the XML file that holds the booking data
    private String filePath;
    
    // All bookings held in the XML file
    private Bookings bookings;
    
    public BookingApplication() {}

    public BookingApplication(String filePath, Bookings bookings) {
        super();
        this.filePath = filePath;
        this.bookings = bookings;
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
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath = filePath;
        // Now unmarshal the object from the file
        FileInputStream fin = new FileInputStream(filePath);
        bookings = (Bookings) u.unmarshal(fin); 		
        fin.close();
    }
    
    /*public void updateXML(Bookings bookings, String filePath) throws Exception {
        this.bookings = bookings;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(bookings, fout);
        fout.close();
    }*/
    
    /**
     * Saves the booking data to the bookings.xml file
     * 
     * @throws JAXBException Marshalling exception
     * @throws IOException File not found
     */
    public void saveBookings() throws JAXBException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Bookings.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(bookings, fout);
        fout.close();
    }

    public Bookings getBookings() {
        return bookings;
    }
    
    /**
     * Retrieves a booking record from the bookingID
     * 
     * @param id The ID of the booking record to be retrieved
     * @return The Booking record that has that ID
     */
    public Booking getBookingByID(int id){
        for(Booking b : bookings.getList()){
            if(b.getBookingID() == id){
                return b;
            }
        }
        return null;
    }
    
    /*
    public Bookings getBookingsByID(int id){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getBookingID() == id){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    } */
    
    
    /*public Bookings getBookingsByStudents(String student){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentName() == student){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }*/
    
    /**
     * Gets all the bookings associated with a student's name
     * 
     * @param student The name of the student
     * @return All the bookings made by that student
     */
    public Bookings getBookingsByStudent(String student){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentEmail().equals(student)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    /**
     * Gets the bookings associated with a students email address
     * 
     * @param email The email of the student
     * @return The bookings made by that student
     */
    public Bookings getBookingsByStudentEmail(String email){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStudentEmail().equals(email)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    /**
     * Gets all the bookings made for a specific subject
     * 
     * @param subject The subject being used as a filter
     * @return All the bookings made in that subject
     */
    public Bookings getBookingsBySubject(String subject){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getSubject().equals(subject)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    /**
     * Gets all bookings of a certain status
     * 
     * @param status The status being used as a filter
     * @return All the bookings of that status
     */
    public Bookings getBookingsByStatus(String status){
        Bookings studentBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getStatus().equals(status)){
                studentBookings.getList().add(b);
            }
        }
        return studentBookings;
    }
    
    /**
     * Gets all bookings made with a tutor
     * 
     * @param tutor The tutor's email address
     * @return The bookings associated with a tutor
     */
    /*public Bookings getBookingsByTutor(String tutor){
        Bookings tutorBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getTutorEmail().equals(tutor)){
                tutorBookings.getList().add(b);
            }
        }
        return tutorBookings;
    }*/
    
    /**
     * Gets all bookings made with a tutor
     * 
     * @param tutor The tutor's email address
     * @return The bookings associated with a tutor
     */
    public Bookings getBookingsByTutorEmail(String email){
        Bookings tutorBookings = new Bookings();
        for(Booking b : bookings.getList()){
            if(b.getTutorEmail().equals(email)){
                tutorBookings.getList().add(b);
            }
        }
        return tutorBookings;
    }

    public void setBookings(Bookings bookings) {
        this.bookings = bookings;
    }
    
    /**
     * Generates a unique booking ID
     * @return a unique ID for a booking
     */
    public int getNewBookingID(){
        if(getBookings().getList().size() > 0){
            int max = 0;
            for(Booking b : getBookings().getList()){
                if(b.getBookingID() > max){
                    max = b.getBookingID();
                }
            }
            return max + 1;
        }
        else{
            return 1;
        }
    }
    
    /**
     * Creates a new booking with a tutor, by a student
     * 
     * @param tutor The tutor being booked
     * @param student The student doing the booking
     */
    public void createBooking(Tutor tutor, Student student){
        // Gets necessary fields for the booking
        int bookingID = getNewBookingID();
        String tutName = tutor.getName();
        String tutEmail = tutor.getEmail();
        String subject = tutor.getSubject();
        String stuName = student.getName();
        String stuEmail = student.getEmail();
        String status = "active";
        
        // Creates new booking object
        Booking booking = new Booking(bookingID, tutName, tutEmail, subject, stuName, stuEmail, status);
        
        // Makes tutor unavailable
        tutor.setStatus("unavailable");
        getBookings().addBooking(booking);
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Cancels a booking
     * 
     * @param bookingId The identifier of the booking record
     */
    public void cancelBooking(int bookingId){
        Booking booking = getBookingByID(bookingId);
        booking.setStatus("canceled");
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    
    /**
     * Cancels all bookings associate with an email, returning a list of the associated tutors
     * 
     * @param email The students email
     * @return The tutors who need to be set to available
     * @throws JAXBException Marshalling exception
     * @throws IOException File not found exception
     */
    public ArrayList<String> cancelBookingsByStudentEmail(String email) throws JAXBException, IOException{
        // Gets necessary fields
        Bookings bookings = getBookingsByStudentEmail(email);
        ArrayList<String> cancelledTutors = new ArrayList<String>();
        Tutor tutor = null;
        
        // Iterates through bookings, cancelling relevant ones
        if (bookings.getList() != null) {
            for (Booking b : bookings.getList()) {
                b.setStatus("cancelled");
                cancelledTutors.add(b.getTutorEmail());
            }
        }
        saveBookings();
        return cancelledTutors;
    }
    
    /**
     * Cancels all bookings associated with a tutor
     * 
     * @param tutor The tutor whose bookings need to be cancelled
     * @throws JAXBException Marshalling exception
     * @throws IOException File not found exception
     */
    public void cancelBookingsByTutor(Tutor tutor) throws JAXBException, IOException{
        Bookings bookings = getBookingsByTutorEmail(tutor.getEmail());
        if (bookings.getList() != null) {
            for (Booking b : bookings.getList()) {
                b.setStatus("cancelled");
            }
        }
        saveBookings();
    }
    
    /**
     * Completes a booking record
     * 
     * @param bookingId The identifier of the record being set to complete
     */
    public void completeBooking(int bookingId){
        Booking booking = getBookingByID(bookingId);
        booking.setStatus("completed");
        try {
            saveBookings();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingApplication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
