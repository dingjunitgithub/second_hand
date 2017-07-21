
package com.second_hand.util;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author kela
 * 
 */
public class StringUtil {
	
	public static boolean notNull(String rs){
		if(rs != null && rs != "null" && rs != "" && !"".equals(rs) && !"null".equals(rs)){
			return true;
		}
		return false;
	}
	
	//过滤字符串空格
	public static String filterStringByBlanks(String str){
		if(str == null || "".equals(str) || "null".equals(str)){
			return null;
		}else {
			str = str.trim();
			str = str.replaceAll(" {2,}", " ");
		}
		
		return str;
	}
	//转换为%E4%BD%A0形式
    public static String toGB2312String(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 0 && c <= 255) {
                sb.append(c);
            } else {
                byte[] b;
                try {
                    b = String.valueOf(c).getBytes("gb2312");
                } catch (Exception ex) {
                    System.out.println(ex);
                    b = new byte[0];
                }
                for (int j = 0; j < b.length; j++) {
                    int k = b[j];
                    if (k < 0)
                        k += 256;
                    sb.append("%" + Integer.toHexString(k).toUpperCase());
                }
            }
        }
        return sb.toString();
    }
    
    public static String toUtf8String(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 0 && c <= 255) {
                sb.append(c);
            } else {
                byte[] b;
                try {
                    b = String.valueOf(c).getBytes("utf-8");
                } catch (Exception ex) {
                    System.out.println(ex);
                    b = new byte[0];
                }
                for (int j = 0; j < b.length; j++) {
                    int k = b[j];
                    if (k < 0)
                        k += 256;
                    sb.append("%" + Integer.toHexString(k).toUpperCase());
                }
            }
        }
        return sb.toString();
    }

    //将%E4%BD%A0转换为汉字 
    public static String unescape(String s) {
        StringBuffer sbuf = new StringBuffer();
        int l = s.length();
        int ch = -1;
        int b, sumb = 0;
        for (int i = 0, more = -1; i < l; i++) {
            /* Get next byte b from URL segment s */
            switch (ch = s.charAt(i)) {
            case '%':
                ch = s.charAt(++i);
                int hb = (Character.isDigit((char) ch) ? ch - '0'
                        : 10 + Character.toLowerCase((char) ch) - 'a') & 0xF;
                ch = s.charAt(++i);
                int lb = (Character.isDigit((char) ch) ? ch - '0'
                        : 10 + Character.toLowerCase((char) ch) - 'a') & 0xF;
                b = (hb << 4) | lb;
                break;
            case '+':
                b = ' ';
                break;
            default:
                b = ch;
            }
            /* Decode byte b as UTF-8, sumb collects incomplete chars */
            if ((b & 0xc0) == 0x80) { // 10xxxxxx (continuation byte)   
                sumb = (sumb << 6) | (b & 0x3f); // Add 6 bits to sumb   
                if (--more == 0)
                    sbuf.append((char) sumb); // Add char to sbuf   
            } else if ((b & 0x80) == 0x00) { // 0xxxxxxx (yields 7 bits)   
                sbuf.append((char) b); // Store in sbuf   
            } else if ((b & 0xe0) == 0xc0) { // 110xxxxx (yields 5 bits)   
                sumb = b & 0x1f;
                more = 1; // Expect 1 more byte   
            } else if ((b & 0xf0) == 0xe0) { // 1110xxxx (yields 4 bits)   
                sumb = b & 0x0f;
                more = 2; // Expect 2 more bytes   
            } else if ((b & 0xf8) == 0xf0) { // 11110xxx (yields 3 bits)   
                sumb = b & 0x07;
                more = 3; // Expect 3 more bytes   
            } else if ((b & 0xfc) == 0xf8) { // 111110xx (yields 2 bits)   
                sumb = b & 0x03;
                more = 4; // Expect 4 more bytes   
            } else /*if ((b & 0xfe) == 0xfc)*/{ // 1111110x (yields 1 bit)   
                sumb = b & 0x01;
                more = 5; // Expect 5 more bytes   
            }
            /* We don't test if the UTF-8 encoding is well-formed */
        }
        return sbuf.toString();
    }

	public static String numberToChinese(String num) {

		String  returnStr = "";
		
		String[] arrUnit = { "", "十", "百", "千", "万" }; // 计量单位
		String[] arrNum = { "", "一", "二", "三", "四", "五", "六", "七", "八", "九" }; // 大写数字
		String[] strNum = num.split("|");

		int nNumCount = strNum.length - 2;
		for (int i = 0; i < strNum.length; i++) {
			if (strNum[i] != null && !"".equals(strNum[i])) {
				int n = Integer.parseInt(strNum[i]);
				switch (n) {
				case 0:
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					break;
				case 1:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 2:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 3:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 4:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 5:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 6:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 7:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 8:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				case 9:
					returnStr = returnStr + arrNum[n] + "" + arrUnit[nNumCount--];
					//System.out.print(arrNum[n] + "" + arrUnit[nNumCount--]);
					break;
				}
			}
		}
		return returnStr;
	}
	
	public static String replacePattern(String text, String repl, String with) {
		String input = text;
		
		Pattern pattern = Pattern.compile(repl);
		Matcher matcher = pattern.matcher(input);	
		while (matcher.find()) {
			String patternStr = matcher.group();
			input = StringUtil.replace(input, patternStr, with, -1);
		}
		return input;
		
	}
	
	
	/**
     * <p>Replaces a String with another String inside a larger String, once.</p>
     * <p/>
     * <p>A <code>null</code> reference passed to this method is a no-op.</p>
     * <p/>
     * <pre>
     * StringUtils.replaceOnce(null, *, *)        = null
     * StringUtils.replaceOnce("", *, *)          = ""
     * StringUtils.replaceOnce("any", null, *)    = "any"
     * StringUtils.replaceOnce("any", *, null)    = "any"
     * StringUtils.replaceOnce("any", "", *)      = "any"
     * StringUtils.replaceOnce("aba", "a", null)  = "aba"
     * StringUtils.replaceOnce("aba", "a", "")    = "ba"
     * StringUtils.replaceOnce("aba", "a", "z")   = "zba"
     * </pre>
     *
     * @param text text to search and replace in, may be null
     * @param repl the String to search for, may be null
     * @param with the String to replace with, may be null
     * @return the text with any replacements processed,
     *         <code>null</code> if null String input
     */
    public static String replaceOnce(String text, String repl, String with) {
        return replace(text, repl, with, 1);
    }
    
	 /**
     * <p>Replaces a String with another String inside a larger String,
     * for the first <code>max</code> values of the search String.</p>
     * <p/>
     * <p>A <code>null</code> reference passed to this method is a no-op.</p>
     * <p/>
     * <pre>
     * StringUtils.replace(null, *, *, *)         = null
     * StringUtils.replace("", *, *, *)           = ""
     * StringUtils.replace("any", null, *, *)     = "any"
     * StringUtils.replace("any", *, null, *)     = "any"
     * StringUtils.replace("any", "", *, *)       = "any"
     * StringUtils.replace("any", *, *, 0)        = "any"
     * StringUtils.replace("abaa", "a", null, -1) = "abaa"
     * StringUtils.replace("abaa", "a", "", -1)   = "b"
     * StringUtils.replace("abaa", "a", "z", 0)   = "abaa"
     * StringUtils.replace("abaa", "a", "z", 1)   = "zbaa"
     * StringUtils.replace("abaa", "a", "z", 2)   = "zbza"
     * StringUtils.replace("abaa", "a", "z", -1)  = "zbzz"
     * </pre>
     *
     * @param text text to search and replace in, may be null
     * @param repl the String to search for, may be null
     * @param with the String to replace with, may be null
     * @param max  maximum number of values to replace, or <code>-1</code> if no maximum
     * @return the text with any replacements processed,
     *         <code>null</code> if null String input
     */
    public static String replace(String text, String repl, String with, int max) {
        if (isNULL(text) || isNULL(repl) || with == null || max == 0) {
            return text;
        }
        int start = 0;
        int end = text.indexOf(repl, start);
        if (end == -1) {
            return text;
        }
        int replLength = repl.length();
        int increase = with.length() - replLength;
        increase = (increase < 0 ? 0 : increase);
        increase *= (max < 0 ? 16 : (max > 64 ? 64 : max));
        StringBuilder buf = new StringBuilder(text.length() + increase);
        while (end != -1) {
            buf.append(text.substring(start, end)).append(with);
            start = end + replLength;
            if (--max == 0) {
                break;
            }
            end = text.indexOf(repl, start);
        }
        buf.append(text.substring(start));
        return buf.toString();
    }
    
    
    /*
     * 判断是否为空
     */
    public static boolean isNULL(String value) {
        return value == null || "".equals(value) || value.length() < 1 || "null".equals(value);
    }
    
	public static void main(String args[]) {
		System.out.println(StringUtil.numberToChinese("12"));
	}
	
	public static String getRandomString(int length) { //length表示生成字符串的长度  
	    String base = "abcdefghijklmnopqrstuvwxyz0123456789";     
	    Random random = new Random();     
	    StringBuffer sb = new StringBuffer();     
	    for (int i = 0; i < length; i++) {     
	        int number = random.nextInt(base.length());     
	        sb.append(base.charAt(number));     
	    }     
	    return sb.toString();     
	 } 

}
