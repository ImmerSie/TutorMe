/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Applications.BookingApplication;
import Applications.StudentApplication;
import Applications.TutorApplication;
import Models.Booking;
import Models.Bookings;
import Models.Student;
import Models.Students;
import Models.Tutor;
import Models.Tutors;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.servlet.ServletContext;
import javax.xml.bind.JAXBException;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

/**
 * Acts as a SOAP service (to be consumed by SOAP clients) to access the 
 * system functionalities
 * 
 * @author Max
 */
@WebService(serviceName = "BookingSOAP")
public class BookingSOAP {

    /**
     * Current context of the system
     */
    @Resource
    private WebServiceContext context;
    
    /**
     * Retrieves the current instance (or generates one) of the Student Application
     * 
     * @return The instance of the StudentApplication
     */
    private StudentApplication getStudentApp(){
        // Current context of the system
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        // Gets an instance of StudentApplication (or generates one)
        synchronized (application) {
            StudentApplication studentApp = (StudentApplication)application.getAttribute("studentApp");
            if (studentApp == null) {
                studentApp = new StudentApplication();
                   try {
                       studentApp.setFilePath(application.getRealPath("WEB-INF/students.xml"));
                   } catch (Exception ex) {
                       Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
                   }
                application.setAttribute("studentApp", studentApp);
                }
            return studentApp;
        }
    }
    
    /**
     * Retrieves the current instance (or generates one) of the Tutor Application
     * 
     * @return The retrieved instance of the TutorApplication
     */
    private TutorApplication getTutorApp(){
        // Current context of the system
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        // Retrieves or generates instance of TutorApplication
        synchronized (application) {
            TutorApplication tutorApp = (TutorApplication)application.getAttribute("tutorApp");
            if (tutorApp == null) {
                tutorApp = new TutorApplication();
                   try {
                       tutorApp.setFilePath(application.getRealPath("WEB-INF/tutors.xml"));
                   } catch (Exception ex) {
                       Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
                   }
                application.setAttribute("tutorApp", tutorApp);
                }
            return tutorApp;
        }
    }
    
    /**
     * Retrieves the current instance (or generates one) of the Booking Application
     * 
     * @return The current instance of the BookingApplication
     */
    private BookingApplication getBookingApp(){
        // Current application context
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
        
        // Retrieves or generates an instance of the BookingApplication
        synchronized (application) {
            BookingApplication bookingApp = (BookingApplication)application.getAttribute("bookingApp");
            if (bookingApp == null) {
                bookingApp = new BookingApplication();
                   try {
                       bookingApp.setFilePath(application.getRealPath("WEB-INF/bookings.xml"));
                   } catch (Exception ex) {
                       Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
                   }
                application.setAttribute("bookingApp", bookingApp);
                }
            return bookingApp;
        }
    }
    
    /**
     * Gets all students in the application
     * 
     * @return Object representing a list of all students
     */
    private Students fetchStudents(){
        return getStudentApp().getStudents();
    }
    
    /**
     * Gets all tutors in the application
     * 
     * @return Object representing a list of all tutors
     */
    private Tutors fetchTutors(){
        return getTutorApp().getTutors();
    }
    
    /**
     * Retrieves all tutors who match the given subject
     * 
     * @param subject A string representing a searched subject
     * @return All the tutors who are assigned to that subject
     */
    @WebMethod
    public ArrayList<Tutor> getTutorsFromSubject(String subject){
        return getTutorApp().getTutorBySubject(subject);
    }

    /**
     * When given search parameters, gets all the bookings who match those parameters
     * 
     * @param searchBy What parameter is being searched by (subject, status, name)
     * @param searchVal The value of the search (WSD, available, ryan)
     * @return An object representing all the bookings who matched the search parameters
     */
    @WebMethod
    public Bookings getBookings(int searchBy, String searchVal){
        // Instatiate necessary variables
        BookingApplication bookingApp = getBookingApp();
        Bookings bookings = null;
        
        // Calls different methods depending on what the search parameter is
        switch(searchBy){
            // Searching by bookingID
            case 1 : 
                bookings = bookingApp.getBookingsByID(Integer.parseInt(searchVal));
                break;
                
            // Searching by student email
            case 2 :
                bookings = bookingApp.getBookingsByStudentEmail(searchVal);
                break;
                
            // Searching by subject name
            case 3 :
                bookings = bookingApp.getBookingsBySubject(searchVal);
                break;
                
            // Searching by booking status
            case 4 :
                bookings = bookingApp.getBookingsByStatus(searchVal);
                break;
                
            // No parameters; retrieves all booking records
            default :
                bookings = bookingApp.getBookings();
                break;
        }
        
        return bookings;
    }
    
    /**
     * Gets all of a students associated bookings
     * 
     * @param student A student object, to filter the bookings
     * @return An object representing a collection of all the bookings for that student
     */
    @WebMethod
    public Bookings getBookingsFromStudent(String student){
        return getBookingApp().getBookingsByStudent(student);
    }
    
    /**
     * Gets all of a tutors associated bookings
     * 
     * @param tutor A tutor object, to filter the bookings
     * @return An object representing a collection of all the bookings for that tutor
     */
    @WebMethod
    public Bookings getBookingsFromTutor(String tutor){
        return getBookingApp().getBookingsByTutor(tutor);
    }

    /**
     * Performs a login for a student, using standard login credentials
     * 
     * @param email The email of the student
     * @param password The password of the student
     * @return A student that has both email and password
     */
    @WebMethod
    public Student loginStudent(String email, String password){
        return fetchStudents().login(email, password);
    }
    
    /**
     * Performs a login for a tutor, using standard login credentials
     * 
     * @param email The email of the tutor
     * @param password The password of the tutor
     * @return A tutor that has both email and password
     */
    @WebMethod
    public Tutor loginTutor(String email, String password){
        return fetchTutors().login(email, password);
    }
    
    /**
     * Updates a students account information
     * 
     * @param email The email of the student (unchanging field, used to identify the student)
     * @param name The new name of the student
     * @param password The new password of the student
     * @param dob The new date of birth of the student
     * @throws JAXBException Marshalling exception, from StudentApplication
     * @throws IOException  Filepath exception, from StudentApplication
     */
    @WebMethod
    public void updateStudent(String email, String name, String password, String dob) throws JAXBException, IOException{
        getStudentApp().updateStudent(email, name, password, dob);
    }
    
    /**
     * Updates a tutors account information
     * 
     * @param email The email of the tutor (unchanging field, used to identify the tutor)
     * @param name The new name of the tutor
     * @param password The new password of the tutor
     * @param dob The new date of birth of the tutor
     * @throws JAXBException Marshalling exception, from TutorApplication
     * @throws IOException Filepath exception, from TutorApplication
     */
    @WebMethod
    public void updateTutor(String email, String name, String password, String dob) throws JAXBException, IOException{
        getTutorApp().updateTutor(email, name, password, dob);
    }
    
    /**
     * Cancels a student account, cancelling all their active bookings
     * 
     * @param student The student whose account is being cancelled
     * @throws JAXBException Marshalling exception, from StudentApplication
     * @throws IOException Filepath exception, from StudentApplication
     */
    @WebMethod
    public void cancelStudentAccount(Student student) throws JAXBException, IOException{
        getStudentApp().getStudents().removeUser(student);
        ArrayList<String> cancelledTutors = getBookingApp().cancelBookingsByStudentEmail(student.getEmail());
        getTutorApp().cancelTutorsByEmail(cancelledTutors);
        getStudentApp().saveStudents();
    }
    
    /**
     * Cancels a tutors account, cancelling all their active bookings
     * 
     * @param tutor The tutor whose account is being cancelled
     * @throws JAXBException Marshalling exception, from TutorApplication
     * @throws IOException Filepath exception, from TutorApplication
     */
    @WebMethod
    public void cancelTutorAccount(Tutor tutor) throws JAXBException, IOException{
        getTutorApp().getTutors().removeUser(tutor);
        getBookingApp().cancelBookingsByTutor(tutor);
        getTutorApp().saveTutors();
    }
    
    /**
     * Creates a booking record, with the associated tutor and student
     * 
     * @param tutor The tutor being booked
     * @param student The student doing the booking
     */
    @WebMethod
    public void createBooking(Tutor tutor, Student student){
        getBookingApp().createBooking(tutor, student);
        tutor.setStatus("unavailable");
        try {
            getTutorApp().saveTutors();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Sets a booking records status to cancelled, making the tutor available again
     * 
     * @param bookingId The identifier for the record being cancelled
     */
    @WebMethod
    public void cancelBooking(int bookingId){
        // Cancels booking
        getBookingApp().cancelBooking(bookingId);
        Booking booking = getBookingApp().getBookingByID(bookingId);
        
        // Resets tutors status
        Tutor tutor = getTutorApp().getTutorFromID(booking.getTutorName());
        tutor.setStatus("available");
        try {
            getTutorApp().saveTutors();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    /**
     * Completes a booking, resetting the tutor status to available
     * 
     * @param bookingId The identifier for the booking record
     */
    @WebMethod
    public void completeBooking(int bookingId){
        // Completes the booking
        getBookingApp().completeBooking(bookingId);
        Booking booking = getBookingApp().getBookingByID(bookingId);
        
        // Resets the tutor status
        Tutor tutor = getTutorApp().getTutorFromID(booking.getTutorName());
        tutor.setStatus("available");
        try {
            getTutorApp().saveTutors();
        } catch (JAXBException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(BookingSOAP.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}