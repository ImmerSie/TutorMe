/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services.client;

import Models.Tutors;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 *
 * @author Max
 */
public class BookingClient {
    
    private static void studentMenu(BookingSOAP bookingApp, Student student){
        System.out.println("Welcome " + student.getName());
        
        Scanner sc = new Scanner(System.in);
        String selection = "";
        while(!selection.equals("x")){
            System.out.println("Menu - (input)");
            System.out.println("Create Booking - create");
            System.out.println("Cancel Booking - cancel");
            System.out.println("Complete Booking - complete");
            System.out.println("View Bookings - view");
            System.out.println("Exit - x");
            sc = new Scanner(System.in);
            selection = sc.nextLine().toLowerCase().trim();
            
            if(selection.equals("create")){
                System.out.println("Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
                String subject = sc.nextLine().toLowerCase().trim();
                while(!subject.equals("wsd") && !subject.equals("sep") && !subject.equals("udp") && !subject.equals("appprog") && !subject.equals("mobileapp")){
                    if(subject.equals("x")){
                        break;
                    }
                    System.out.println("Did not recognise subject. Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
                    subject = sc.nextLine().toLowerCase().trim();
                }
                if(subject.equals("x")){
                    break;
                }
                System.out.println("Available Tutors for " + subject);
                List<Tutor> tutors = bookingApp.getTutorsFromSubject(subject);
                for(Tutor t : tutors){
                    if(t.getStatus().toLowerCase().equals("available")){
                        System.out.println("Tutor Name: " + t.getName() + " | Tutor Email: " + t.getEmail() + " | Subject: " + t.getSubject() + " | Status: " + t.getStatus());
                    }
                }
                String tutorName = null;
                boolean whileCheck = true;
                while(whileCheck){
                    System.out.println("Please input available tutor name: ");
                    tutorName = sc.nextLine().toLowerCase().trim();
                    if(tutorName.equals("x")){
                        break;
                    }
                    for(Tutor t : tutors){
                        System.out.println(t.getName().toLowerCase());
                        if(t.getName().toLowerCase().equals(tutorName)){
                            bookingApp.createBooking(t, student);
                        }
                        whileCheck = false;
                        break;
                    }
                }
                
            }
            else if(selection.equals("cancel")){
                System.out.println("Please input bookingID: ");
                String bookingIdString = sc.nextLine().toLowerCase().trim();
                int bookingId = Integer.parseInt(bookingIdString);
                bookingApp.cancelBooking(bookingId);
            }
            else if(selection.equals("complete")){
                System.out.println("Please input bookingID: ");
                String bookingIdString = sc.nextLine().toLowerCase().trim();
                int bookingId = Integer.parseInt(bookingIdString);
                bookingApp.completeBooking(bookingId);
            }
            else if(selection.equals("view")){
                Bookings bookings = bookingApp.getBookingsFromStudent(student.getName());
                System.out.println("Bookings");
                for(Booking b : bookings.booking){
                    System.out.print("Booking ID: " + b.getBookingID() + " | Tutor: " + b.getTutorName() + " | Tutor Email: ");
                    System.out.print(b.getTutorEmail() + " | Subject: " + b.getSubject() + " | Student: " + b.getStudentName() + " | Student Email: ");
                    System.out.println(b.getStudentEmail() + " | Status: " + b.getStatus());
                }
            }
            else if(selection.equals("x")){
                break;
            }
            else{
                System.out.println("Please input selection in the form of one word (e.g. 'create')");
            }
        }
    }
    
    private static void tutorMenu(BookingSOAP bookingApp, Tutor tutor){
        System.out.println("Welcome " + tutor.getName());
        Bookings bookings = bookingApp.fetchBookings();
        System.out.println("Bookings");
        for(Booking b : bookings.booking){
            System.out.print("Booking ID: " + b.getBookingID() + " | Tutor: " + b.getTutorName() + " | Tutor Email: ");
            System.out.print(b.getTutorEmail() + " | Subject: " + b.getSubject() + " | Student: " + b.getStudentName() + " | Student Email: ");
            System.out.println(b.getStudentEmail() + " | Status: " + b.getStatus());
        }
    }
    
    public static void main(String[] args) {
        BookingSOAP_Service locator = new BookingSOAP_Service();
        BookingSOAP bookingApp = locator.getBookingSOAPPort();

        Scanner sc = new Scanner(System.in);
        System.out.print("Enter email address: ");
        String email = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        Student student = bookingApp.loginStudent(email, password);
        Tutor tutor = bookingApp.loginTutor(email, password);
        
        while(student == null && tutor == null){
            System.out.println("Incorrect login details.");            
            System.out.print("Enter email address: ");
            email = sc.nextLine();
            System.out.print("Enter password: ");
            password = sc.nextLine();
            student = bookingApp.loginStudent(email, password);
            tutor = bookingApp.loginTutor(email, password);
        }
        
        if(student != null){
            studentMenu(bookingApp, student);
        }
        else {
            tutorMenu(bookingApp, tutor);
        }
    }
}
