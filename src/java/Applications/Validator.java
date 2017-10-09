/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Applications;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Mango
 */
public class Validator {

    private Pattern pattern;
    private Matcher matcher;

    private String emailPattern = "[a-z]{3,15}";
    private String namePattern = "[a-z]{3,15}";
    private String passwordPattern = "[a-z]{3,15}";


    public Validator(String input) {
        if (input.equals("email")) {
            pattern = Pattern.compile(emailPattern);
        } else if (input.equals("name")) {
            pattern = Pattern.compile(namePattern);
        } else if (input.equals("password")) {
            pattern = Pattern.compile(passwordPattern);
        }
    }

    public boolean validate(final String input) {
        
        matcher = pattern.matcher(input);
        if(matcher!=null){
            return matcher.matches();
        }
        return false;
    }
}
