public class PalindromeApex{
    public static void checkPalindrome(String str) {
        String original = str.toLowerCase();
        String reversed = original.reverse(); 
        
        if (original == reversed) {
            System.debug(str + ' is a palindrome.');
        } else {
            System.debug(str + ' is not a palindrome.');
        }
    }
}