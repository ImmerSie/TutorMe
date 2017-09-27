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
 *
 * @author Max
 */
@WebService(serviceName = "BookingSOAP")
public class BookingSOAP {

    @Resource
    private WebServiceContext context;
    
    private StudentApplication getStudentApp(){
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
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
    
    private TutorApplication getTutorApp(){
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
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
    
    private BookingApplication getBookingApp(){
        ServletContext application = (ServletContext)context.getMessageContext().get(MessageContext.SERVLET_CONTEXT);
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
    
    private Students fetchStudents(){
        return getStudentApp().getStudents();
    }
    
    private Tutors fetchTutors(){
        return getTutorApp().getTutors();
    }
    
    @WebMethod
    public ArrayList<Tutor> getTutorsFromSubject(String subject){
        return getTutorApp().getTutorBySubject(subject);
    }
    
    @WebMethod
    public Bookings fetchBookings(){
        return getBookingApp().getBookings();
    }
    
    @WebMethod
    public Bookings getBookingsFromStudent(String student){
        return getBookingApp().getBookingsByStudent(student);
    }
    
    @WebMethod
    public Bookings getBookingsFromTutor(String tutor){
        return getBookingApp().getBookingsByTutor(tutor);
    }

    @WebMethod
    public Student loginStudent(String email, String password){
        return fetchStudents().login(email, password);
    }
    
    @WebMethod
    public Tutor loginTutor(String email, String password){
        return fetchTutors().login(email, password);
    }
    
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
    
    @WebMethod
    public void cancelBooking(int bookingId){
        getBookingApp().cancelBooking(bookingId);
        Booking booking = getBookingApp().getBookingByID(bookingId);
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
    
    @WebMethod
    public void completeBooking(int bookingId){
        getBookingApp().completeBooking(bookingId);
        Booking booking = getBookingApp().getBookingByID(bookingId);
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
