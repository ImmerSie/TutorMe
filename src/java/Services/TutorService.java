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
    public Tutors getUsers() throws IOException, Exception {

        return getTutorApp().getAvailableTutors();
    }

    @Path("tutors/tutor/email/{email}")
    @GET
    @Produces("application/xml")
    public Tutor getTutorByEmail(@PathParam("email") String email) throws JAXBException, IOException, Exception {
       return getTutorApp().getTutorFromEmail(email);
    }
    
    @Path("tutors/tutor/status/{status}")
    @GET
    @Produces(MediaType.APPLICATION_XML)
    public Tutors getTutorsByStatus(@PathParam("status") String status) throws JAXBException, IOException, Exception {
       return getTutorApp().getTutorsByStatus(status);
    }





}
