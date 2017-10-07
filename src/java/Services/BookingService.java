/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;
import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBException;
import java.io.*;
import Applications.*;
import Models.*; 

/**
 *
 * @author Mango
 */

@Path("/bookingApp")

public class BookingService {
    
 @Context
 private ServletContext application;
 
 private BookingApplication getBookingApp() throws JAXBException, IOException, Exception {

  synchronized (application) {
   BookingApplication bookingApp = (BookingApplication)application.getAttribute("bookingApp");
   if (bookingApp == null) {
    bookingApp = new BookingApplication();
    bookingApp.setFilePath(application.getRealPath("WEB-INF/bookings.xml"));
    application.setAttribute("bookingApp", bookingApp);
   }
   return bookingApp;
  }
 }
 
 
 
  @Path("bookings")
    @GET
    @Produces("application/xml")
    public Bookings getUsers(@DefaultValue("0") @QueryParam("bookingID") int bookingID, 
            @DefaultValue("0") @QueryParam("studentEmail") String studentEmail, 
            @DefaultValue("0") @QueryParam("subject") String subject,
            @DefaultValue("0") @QueryParam("status") String status) throws IOException, Exception {
       
            if(bookingID!=0){
               return getBookingApp().getBookingsByID(bookingID);
            }
            
            if(!studentEmail.equals("0")){
                 return getBookingApp().getBookingsByStudentEmail(studentEmail);
            }
            
            if(!subject.equals("0")){
                 return getBookingApp().getBookingsBySubject(subject);
            }
            
            if(!status.equals("0")){
                 return getBookingApp().getBookingsByStatus(status);
            }
            return getBookingApp().getBookings();          
    }
    
    /*
    @Path("bookings/booking/bookingID/{bookingID}")
    @GET
    @Produces("application/xml")
    public Booking getBookingByID(@PathParam("bookingID") int bookingID) throws JAXBException, IOException, Exception{
        return getBookingApp().getBookingByID(bookingID);
    }
    
    @Path("bookings/booking/studentEmail/{studentEmail}")
    @GET
    @Produces("application/xml")
    public Bookings getBookingsByEmail(@PathParam("studentEmail") String studentEmail) throws JAXBException, IOException, Exception{
        //return getBookingApp().getBookings().getBookingByEmail(studentEmail);
        return getBookingApp().getBookingsByStudentEmail(studentEmail);
    }
    
    @Path("bookings/booking/subject/{subject}")
    @GET
    @Produces("application/xml")
    public Bookings getBookingsBySubject(@PathParam("subject") String subject) throws JAXBException, IOException, Exception{
       // return getBookingApp().getBookings().getBookingBySubject(subject);
       return getBookingApp().getBookingsBySubject(subject);
    }
    
    @Path("bookings/booking/status/{status}")
    @GET
    @Produces("application/xml")
    public Bookings getBookingsByStatus(@PathParam("status") String status) throws JAXBException, IOException, Exception{
      //  return getBookingApp().getBookings().getBookingByStatus(status);
      return getBookingApp().getBookingsByStatus(status);
    }
    
  
    
  // Use QueryParam for the ?    Paramters can be usedin any order with Queryparam. 
    */
}
