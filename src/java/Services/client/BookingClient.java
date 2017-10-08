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
    
    private static Student loginStudent(BookingSOAP bookingApp){
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter email address: ");
        String email = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        Student student = bookingApp.loginStudent(email, password);
        
        while(student == null){
            System.out.println("Incorrect login details (must be a student).");            
            System.out.print("Enter email address: ");
            email = sc.nextLine();
            System.out.print("Enter password: ");
            password = sc.nextLine();
            student = bookingApp.loginStudent(email, password);
        }
        return student;
    }
    
    private static Tutor loginTutor(BookingSOAP bookingApp){
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter email address: ");
        String email = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        Tutor tutor = bookingApp.loginTutor(email, password);
        
        while(tutor == null){
            System.out.println("Incorrect login details.");            
            System.out.print("Enter email address: ");
            email = sc.nextLine();
            System.out.print("Enter password: ");
            password = sc.nextLine();
            tutor = bookingApp.loginTutor(email, password);
        }
        return tutor;
    }
    
    private static void printBookings(Bookings bookings){
        if(bookings.getBooking().size() > 0){
            System.out.println("Bookings");
            for(Booking b : bookings.booking){
                System.out.print("Booking ID: " + b.getBookingID() + " | Tutor: " + b.getTutorName() + " | Tutor Email: ");
                System.out.print(b.getTutorEmail() + " | Subject: " + b.getSubject() + " | Student: " + b.getStudentName() + " | Student Email: ");
                System.out.println(b.getStudentEmail() + " | Status: " + b.getStatus());
            }
        }
        else{
            System.out.println("No bookings found");
        }
    }
    
    private static void createBooking(BookingSOAP bookingApp, Student student){
        Scanner sc = new Scanner(System.in);
        System.out.println("Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
        String subject = sc.nextLine().toLowerCase().trim();
        while(!subject.equals("wsd") && !subject.equals("sep") && !subject.equals("udp") && !subject.equals("appprog") && !subject.equals("mobileapp")){
            if(subject.equals("x")){
                return;
            }
            System.out.println("Did not recognise subject. Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
            subject = sc.nextLine().toLowerCase().trim();
        }
        System.out.println("Available Tutors for " + subject);
        List<Tutor> tutors = bookingApp.getTutorsFromSubject(subject);
        for(Tutor t : tutors){
            if(t.getStatus().toLowerCase().equals("available")){
                System.out.println("Tutor Name: " + t.getName() + " | Tutor Email: " + t.getEmail() + " | Subject: " + t.getSubject() + " | Status: " + t.getStatus());
            }
        }
        String tutorEmail = null;
        boolean whileCheck = true;
        while(whileCheck){
            System.out.println("Please input available tutor email: ");
            tutorEmail = sc.nextLine().toLowerCase().trim();
            if(tutorEmail.equals("x")){
                break;
            }
            for(Tutor t : tutors){
                System.out.println(t.getName().toLowerCase());
                if(t.getEmail().toLowerCase().equals(tutorEmail)){
                    bookingApp.createBooking(t, student);
                    System.out.println("Booking created!");
                }
                whileCheck = false;
                break;
            }
        }
    }
    
    private static void completeBooking(BookingSOAP bookingApp, Tutor tutor){
        Bookings bookings = bookingApp.getBookingsFromTutor(tutor.getEmail());
        printBookings(bookings);
        Scanner sc = new Scanner(System.in);
        System.out.println("Please input bookingID: ");
        String bookingIdString = sc.nextLine().toLowerCase().trim();
        int bookingId = Integer.parseInt(bookingIdString);
        bookingApp.completeBooking(bookingId);
    }
    
    private static void viewBookings(BookingSOAP bookingApp){
        Scanner sc = new Scanner(System.in);
        System.out.println("Search by:");
        System.out.println("1: bookingID");
        System.out.println("2: student email");
        System.out.println("3: subject name");
        System.out.println("4: booking status");
        System.out.println("5: get all");
        int searchBy = sc.nextInt();
        sc.nextLine();
        
        while(searchBy > 5 && searchBy < 1){
            System.out.println("Search by:");
            System.out.println("1: bookingID");
            System.out.println("2: student email");
            System.out.println("3: subject name");
            System.out.println("4: booking status");
            System.out.println("5: get all");
            searchBy = sc.nextInt();
            sc.nextLine();
        }
        String searchVal = "";
        if(searchBy != 5){
            System.out.print("Search: ");
            searchVal = sc.nextLine();
        }
        
        Bookings bookings = bookingApp.getBookings(searchBy, searchVal);
        printBookings(bookings);
        
    }
    
    
    private static void studentMenu(BookingSOAP bookingApp){
        System.out.println("Welcome!");
        Student student = null;
        Tutor tutor = null;
        Scanner sc = new Scanner(System.in);
        String selection = "";
        OUTER:
        while (!selection.equals("x")) {
            System.out.println("");
            System.out.println("");
            System.out.println("Menu - (input)");
            System.out.println("Create Booking - create");
            System.out.println("Cancel Booking - cancel");
            System.out.println("Complete Booking - complete");
            System.out.println("View Bookings - view");
            if(student != null || tutor != null){
                System.out.println("Logout User - logout");
            }
            System.out.println("Exit - x");
            selection = sc.nextLine().toLowerCase().trim();
            switch (selection) {
                case "create":
                    if(student == null){
                        student = loginStudent(bookingApp);
                    }   if(student != null){
                        createBooking(bookingApp, student);
                    }
                    else{
                        System.out.println("Student credentials incorrect");
                    }   
                    break;
                    
                case "cancel":
                    System.out.print("Enter email address: ");
                    String email = sc.nextLine();
                    System.out.print("Enter password: ");
                    String password = sc.nextLine();
                    Bookings bookings = null;
                    if(tutor == null && student == null){
                        tutor = bookingApp.loginTutor(email, password);
                        student = bookingApp.loginStudent(email, password);
                    }
                    if(tutor != null){
                        bookings = bookingApp.getBookingsFromTutor(tutor.getEmail());
                    }
                    else if(student != null){
                        bookings = bookingApp.getBookingsFromStudent(student.getEmail());
                    }
                    else{
                        System.out.println("Incorrect credentials");
                        break;
                    }
                    
                    printBookings(bookings);
                    System.out.println("Please input bookingID: ");
                    String bookingIdString = sc.nextLine().toLowerCase().trim();
                    int bookingId = Integer.parseInt(bookingIdString);
                    bookingApp.cancelBooking(bookingId);
                    break;
                    
                case "complete":
                    if(tutor == null){
                        tutor = loginTutor(bookingApp);
                    }   if(tutor != null){
                        completeBooking(bookingApp, tutor);
                    }
                    else{
                        System.out.println("Tutor credentials incorrect");
                    }   
                    break;
                    
                case "view":
                    viewBookings(bookingApp);
                    break;
                    
                case "logout":
                    student = null;
                    tutor = null;
                    System.out.println("Logged out!");
                    break;
                    
                case "x":
                    break OUTER;
                    
                default:
                    System.out.println("Please input selection in the form of one word (e.g. 'create')");
                    break;
            }
        }
    }
    
    public static void main(String[] args) {
        BookingSOAP_Service locator = new BookingSOAP_Service();
        BookingSOAP bookingApp = locator.getBookingSOAPPort();

        studentMenu(bookingApp);
    }
}
