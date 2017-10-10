/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services.client;


import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class consumes the BookingSOAP web service, offering a CLI to perform functions
 * 
 * @author Max
 */
public class BookingClient {
    // Either a logged in student, or null
    private static Student student;
    
    // Either a logged in tutor, or null
    private static Tutor tutor;
    
    // Scanner object to read in user input
    private static Scanner sc;
    
    // The BookingSOAP web service to access methods
    private static BookingSOAP bookingApp;
    
    /**
     * Allows a student to be authenticated
     */
    private static void loginStudent(){
        // Initial user input (no error message required)
        System.out.print("Enter email address: ");
        String email = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        student = bookingApp.loginStudent(email, password);
        
        // Loops until correct user input is entered, and student is logged in
        while(student == null){
            System.out.println("Incorrect login details (must be a student).");            
            System.out.print("Enter email address: ");
            email = sc.nextLine();
            System.out.print("Enter password: ");
            password = sc.nextLine();
            student = bookingApp.loginStudent(email, password);
        }
    }
    
    /**
     * Allows a tutor to be authenticated
     */
    private static void loginTutor(){
        // Initial user input (no error message required)
        System.out.print("Enter email address: ");
        String email = sc.nextLine();
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        tutor = bookingApp.loginTutor(email, password);
        
        // Loops until tutor is authenticated
        while(tutor == null){
            System.out.println("Incorrect login details.");            
            System.out.print("Enter email address: ");
            email = sc.nextLine();
            System.out.print("Enter password: ");
            password = sc.nextLine();
            tutor = bookingApp.loginTutor(email, password);
        }
    }
    
    /**
     * Outputs to the console the details of the booking records in the Bookings object
     * 
     * @param bookings A collection of bookings
     */
    private static void printBookings(Bookings bookings){
        // Checks to ensure there is at least 1 booking
        if(bookings.getBooking().size() > 0){
            System.out.println("Bookings");
            
            // Loops through each booking record, printing details
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
    
    /**
     * Creates a booking record, using the logged in student and an input tutor email
     */
    private static void createBooking(){
        // Gets what subject the student wants to create a booking in
        System.out.println("Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
        String subject = sc.nextLine().toLowerCase().trim();
        while(!subject.equals("wsd") && !subject.equals("sep") && !subject.equals("udp") && !subject.equals("appprog") && !subject.equals("mobileapp")){
            // Cancels creation of booking
            if(subject.equals("x")){
                return;
            }
            System.out.println("Did not recognise subject. Please input subject: (WSD, SEP, UDP, AppProg, MobileApp)");
            subject = sc.nextLine().toLowerCase().trim();
        }
        
        // Prints out tutor details for the input subject
        System.out.println("Available Tutors for " + subject);
        List<Tutor> tutors = bookingApp.getTutorsFromSubject(subject);
        for(Tutor t : tutors){
            if(t.getStatus().toLowerCase().equals("available")){
                System.out.println("Tutor Name: " + t.getName() + " | Tutor Email: " + t.getEmail() + " | Subject: " + t.getSubject() + " | Status: " + t.getStatus());
            }
        }
        
        // Asks for a tutor email to be booked
        String tutorEmail = null;
        boolean whileCheck = true;
        while(whileCheck){
            System.out.println("Please input available tutor email: ");
            tutorEmail = sc.nextLine().toLowerCase().trim();
            
            // Cancels creation of booking
            if(tutorEmail.equals("x")){
                break;
            }
            
            // Creates booking if tutor email is valid
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
    
    /**
     * Allows a user to cancel a booking, from an input bookingID
     */
    private static void cancelBooking(){
        // Gets the bookings for the user
        Bookings bookings = null;
        if(tutor != null){
            bookings = bookingApp.getBookingsFromTutor(tutor.getEmail());
        }
        else if(student != null){
            bookings = bookingApp.getBookingsFromStudent(student.getEmail());
        }
        else {
            System.out.println("You must be logged in!");
            return;
        }
        
        // Prints the users bookings
        printBookings(bookings);
        
        // User inputs the booking ID to be cancelled
        System.out.println("Please input bookingID: ");
        int bookingId = sc.nextInt();
        sc.nextLine();
        
        // Completes booking
        bookingApp.cancelBooking(bookingId);
    }
    
    /**
     * Prints the logged in tutors bookings, and lets the tutor input a bookingID,
     * and completes the booking that has that ID.
     */
    private static void completeBooking(){
        // Prints the tutors bookings
        Bookings bookings = bookingApp.getBookingsFromTutor(tutor.getEmail());
        printBookings(bookings);
        
        // Tutor inputs the booking ID to be completed
        System.out.println("Please input bookingID: ");
        String bookingIdString = sc.nextLine().toLowerCase().trim();
        int bookingId = Integer.parseInt(bookingIdString);
        
        // Completes booking
        bookingApp.completeBooking(bookingId);
    }
    
    /**
     * Allows a user to view the bookings according to input parameters
     */
    private static void viewBookings(){
        // Indicates what the search parameter is
        System.out.println("Search by:");
        System.out.println("1: bookingID");
        System.out.println("2: student email");
        System.out.println("3: subject name");
        System.out.println("4: booking status");
        System.out.println("5: get all");
        int searchBy = sc.nextInt();
        sc.nextLine();
        
        // Loops until valid input is entered
        while(searchBy > 5 && searchBy < 1){
            System.out.println("Must enter a number between 1 and 5");
            System.out.println("Search by:");
            System.out.println("1: bookingID");
            System.out.println("2: student email");
            System.out.println("3: subject name");
            System.out.println("4: booking status");
            System.out.println("5: get all");
            searchBy = sc.nextInt();
            sc.nextLine();
        }
        
        // The value which is being searched by (e.g. student@email.com)
        String searchVal = "";
        if(searchBy != 5){
            System.out.print("Search: ");
            searchVal = sc.nextLine();
        }
        
        // Retrieves and prints bookings according to the search parameter and input value
        Bookings bookings = bookingApp.getBookings(searchBy, searchVal);
        printBookings(bookings);
        
    }
    
    /**
     * Allows user to perform functions related to their account
     */
    private static void updateAccount(){
        // User detail fields
        String name = null;
        String email = null;
        String password = null;
        String dob = null;
        
        // Sets details fields according to the logged in user
        if(tutor != null){
            name = tutor.getName();
            email = tutor.getEmail();
            password = tutor.getPassword();
            dob = tutor.getBirthday();
        }
        else if(student != null){
            name = student.getName();
            email = student.getEmail();
            password = student.getPassword();
            dob = student.getBirthday();
        }
        
        // Displays menu for performing account functions
        int selection = -1;
        while(selection != 0){
            System.out.println("Menu");
            System.out.println("1: Name");
            System.out.println("2: Password");
            System.out.println("3: Date of Birth");
            System.out.println("4: Cancel Account");
            System.out.println("5: Print Account");
            System.out.println("0: Save");
            
            // Gets a user input
            selection = sc.nextInt();
            sc.nextLine();
            
            // Chooses actions based on the user input
            switch (selection) {
                // Change name
                case 1:
                    System.out.print("Enter new name: ");
                    name = sc.nextLine();
                    break;
                
                // Change password
                case 2:
                    System.out.print("Enter new password: ");
                    password = sc.nextLine();
                    break;
                
                // Change DOB
                case 3:
                    System.out.print("Enter new date of birth: ");
                    dob = sc.nextLine();
                    break;
                
                // Cancel account
                case 4:
                    if(student != null){
                        try {
                            bookingApp.cancelStudentAccount(student);
                        } catch (IOException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (JAXBException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    else if(tutor != null){
                        try {
                            bookingApp.cancelTutorAccount(tutor);
                        } catch (IOException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (JAXBException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    break;
                    
                // View account
                case 5:
                    System.out.print("Name: " + name);
                    System.out.print("Email: " + email);
                    System.out.print("Password: " + password);
                    System.out.print("Date of Birth: " + dob);
                    break;
                   
                // Save/Exit
                case 0:
                    if(tutor != null){
                        try {
                            bookingApp.updateTutor(email, name, password, dob);
                        } catch (IOException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (JAXBException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    else if(student != null){
                        try {
                            bookingApp.updateStudent(email, name, password, dob);
                        } catch (IOException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        } catch (JAXBException_Exception ex) {
                            Logger.getLogger(BookingClient.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                   break;
                    
                default:
                    System.out.println("Please input selection in the form of a number between 0 and 4");
                    break;
            }
        }
    }
    
    /**
     * Prints out the menu for user actions and allows the user to select 1
     */
    private static void studentMenu(){
        System.out.println("Welcome!");
        int selection = -1;
        OUTER:
        while (selection != 0) {
            // Instructions for user
            System.out.println("");
            System.out.println("");
            System.out.println("Menu");
            System.out.println("1: Create Booking");
            System.out.println("2: Cancel Booking");
            System.out.println("3: Complete Booking");
            System.out.println("4: View Bookings");
            if(student != null || tutor != null){
                System.out.println("5: Logout User");
            }
            else{
                System.out.println("5: Login User");
            }
            System.out.println("6: View Account");
            System.out.println("0: Exit");
            
            // Gets a user input
            selection = sc.nextInt();
            sc.nextLine();
            
            // Chooses actions based on the user input
            switch (selection) {
                // Create a booking
                case 1:
                    if(student == null){
                        loginStudent();
                    }   
                    if(student != null){
                        createBooking();
                    }
                    else{
                        System.out.println("Student credentials incorrect");
                    }   
                    break;
                
                // Cancel a booking
                case 2:
                    Bookings bookings = null;
                    if(tutor == null && student == null){
                        System.out.print("Enter email address: ");
                        String email = sc.nextLine();
                        System.out.print("Enter password: ");
                        String password = sc.nextLine();
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
                    
                    // Display bookings for user to select booking from ID
                    printBookings(bookings);
                    System.out.println("Please input bookingID: ");
                    int bookingId = sc.nextInt();
                    
                    // Cancel based on booking ID
                    bookingApp.cancelBooking(bookingId);
                    break;
                
                // Complete booking
                case 3:
                    if(tutor == null){
                        loginTutor();
                    }   
                    if(tutor != null){
                        completeBooking();
                    }
                    else{
                        System.out.println("Tutor credentials incorrect");
                    }   
                    break;
                
                // View bookings
                case 4:
                    viewBookings();
                    break;
                
                // Login or logout depending on user state
                case 5:
                    // Login a user
                    if(student == null && tutor == null){
                        System.out.print("Enter email address: ");
                        String email = sc.nextLine();
                        System.out.print("Enter password: ");
                        String password = sc.nextLine();
                        tutor = bookingApp.loginTutor(email, password);
                        student = bookingApp.loginStudent(email, password);
                        if(tutor == null && student == null){
                            System.out.println("User credentials incorrect");
                        }
                    }
                    // Logout a user
                    else{
                        student = null;
                        tutor = null;
                        System.out.println("Logged out!");
                    }
                    break;
                    
                // Peform account functions
                case 6:
                    // Log in if not logged in
                    if(tutor == null && student == null){
                        System.out.print("Enter email address: ");
                        String email = sc.nextLine();
                        System.out.print("Enter password: ");
                        String password = sc.nextLine();
                        tutor = bookingApp.loginTutor(email, password);
                        student = bookingApp.loginStudent(email, password);
                    }
                    
                    // Access account functions
                    if(tutor != null){
                        updateAccount();
                    }
                    else if(student != null){
                        updateAccount();
                    }
                    else{
                        System.out.println("Incorrect credentials");
                        break;
                    }
                    break;
                
                // Exit from the application
                case 0:
                    break OUTER;
                    
                default:
                    System.out.println("Please input selection in the form of a number between 0 and 6");
                    break;
            }
        }
    }
    
    /**
     * Entry method for client
     * @param args Command line arguments
     */
    public static void main(String[] args) {
        // Instantiate the fields
        BookingSOAP_Service locator = new BookingSOAP_Service();
        bookingApp = locator.getBookingSOAPPort();
        sc = new Scanner(System.in);
        student = null;
        tutor = null;
        
        // Begin menu loop
        studentMenu();
    }
}
