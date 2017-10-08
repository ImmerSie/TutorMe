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
    public Bookings getUsers(@DefaultValue("0") @QueryParam("bookingID") int bookingID,                                     // Use of DefaultValue in order to use if-statements. 
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
}
