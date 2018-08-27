package kh.sns.util;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component
public class HashTagUtil {
	
	public List<String> extractHashTag(String contents) {

		// _ 는 태그에 포함되는것 같음
		// Pattern p = Pattern.compile("\\#([0-9a-zA-Z가-힣_]*)");
		Pattern p = Pattern.compile("#[^#\\s,;<>. ]+");	// 2018-08-24 프론트엔드 정규식과 통합
		// /(#[^#\s,;<>. ]+)/gi;  
		Matcher m = p.matcher(contents);
		String extractHashTag = null;
		
		List<String> list = new ArrayList<>();

		while(m.find()) {
		
			extractHashTag = specialCharacterReplace(m.group());

			if(extractHashTag != null && !extractHashTag.equals("#")) {
				list.add(extractHashTag.replace("#", "").replace(" ", ""));				
			}
		}
		
		// 테스트
		list.forEach(System.out::println);		
		list = new ArrayList<>(new HashSet<String>(list));
		
		return list;
	}

	public String specialCharacterReplace(String str) {
		str = StringUtils.replace(str, "-+=!@#$%^&*()[]{}|\\;:'\"<>,.?/~`） ", "");

		if(str.length() < 1) {
			return null;
		}

		return str;
	}

}
