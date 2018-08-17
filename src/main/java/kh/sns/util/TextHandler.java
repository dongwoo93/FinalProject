package kh.sns.util;

import org.springframework.stereotype.Component;

@Component
public class TextHandler {
	
	public String underscoreName(String originalName) {
		char[] charList = originalName.toCharArray();
		String outputName = null;
		for(int i = 0; i < charList.length; i++) {
			if(Character.isUpperCase(charList[i])) {
				outputName += ("_" + String.valueOf(charList[i]+32));
			} else {
				outputName += charList[i]; 
			}
		}
		
		return outputName;
	}

}
