<%-- 
    Document   : login
    Created on : Sep 10, 2017, 9:21:22 PM
    Author     : Mango
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tutor Me!-Login</title>
    </head>
<body>
        <h1>Login</h1>
        <form action="loginAction.jsp" method="POST">
             <table>
                
                <tr>
                    <td>Email:</td> 
                    <td><input type="text" name="email"> </td>
                </tr>
                <tr> 
                    <td>Password:</td> 
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
               <td></td> 
               <td><input type="submit" value="Login" name="Login"></td> 
           
                </tr>
             </table>
        </form>
        
    </body>
</html>
