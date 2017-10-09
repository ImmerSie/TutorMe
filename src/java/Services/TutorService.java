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
@Path("/tutorApp")

public class TutorService {

    @Context
    private ServletContext application;

    private TutorApplication getTutorApp() throws JAXBException, IOException, Exception {

        synchronized (application) {
            TutorApplication tutorApp = (TutorApplication) application.getAttribute("tutorApp");
            if (tutorApp == null) {
                tutorApp = new TutorApplication();
                tutorApp.setFilePath(application.getRealPath("WEB-INF/tutors.xml"));
                application.setAttribute("tutorApp", tutorApp);
            }
            return tutorApp;
        }
    }

    @Path("tutors")
    @GET
    @Produces("application/xml")
    public Tutors getUsers( @DefaultValue("0") @QueryParam("email") String email,                               // Use of DefaultValue in order to use if-statements. 
            @DefaultValue("0") @QueryParam("status") String status) throws IOException, Exception {

        if(!email.equals("0")){
                 return getTutorApp().getTutorsByEmail(email);
            }
            
            if(!status.equals("0")){
                 return getTutorApp().getTutorsByStatus(status);
            }
        return getTutorApp().getTutors();   
    }
}
