public class BasicValidation {
    public static Integer counter = 1;
    public static string correctPassword = 'cloud_metic_solution';
    
    public static void attemptPassword(string userPassword){
		string ans = '';
        ans = checkPasswordAttempt(userPassword);
        system.debug(ans);
        ans = checkPasswordAttempt(userPassword);
        system.debug(ans);
        ans = checkPasswordAttempt(userPassword);
        system.debug(ans);
    }
    public static string checkPasswordAttempt(string userPassword){
        if(correctPassword != userPassword){
            counter++;
            if(counter>3){
                return 'account locked maximum limit reached';
            }
            else{
                return 'failure';
            }
        }
        return 'success';
    }
}