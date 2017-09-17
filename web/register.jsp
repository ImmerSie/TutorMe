<%-- 
    Document   : register
    Created on : Jul 28, 2017, 11:49:55 AM
    Author     : yeekim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tutor Me! - Register</title>
    </head>
    <body>

        <h1>Register your Tutor Me! account.</h1>


        <form action="welcome.jsp" method="POST">
            <table>

                <tr> 
                    <td>Full Name:</td> 
                    <td><input type="text" name="name"></td> 
                </tr>
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
                </tr>

                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>
                
                <tr> 
                    <td>Date of Birth:</td> 
                    <td><input type="text" name="birthday" default="DD-MM-YYYY"></td>
                </tr>
                <tr>
                    <td>User Type:</td> 
                    <td><select name="userType">
                            <option value="student">Student</option>
                            <option value="tutor">Tutor</option>
 
                        </select></td>
                </tr>
                <tr> 
                    <td>Subject</td> 
                    <td><select name="subject">
                            <option value="tutorsOnly">Tutors Only</option>
                            <option value="WSD">WSD</option>
                            <option value="USP">USP</option>
                            <option value="SEP">SEP</option>
                            <option value="AppProg">AppProg</option>
                            <option value="MobileApp">MobileApp</option>
 
                        </select></td>
                    
                </tr>
                <tr>
                    <td></td> 
                    <td><input type="submit" value="Register" name="Register"></td> 
                </tr>
            </table>
        </form>




    </body>



</html>
