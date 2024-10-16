package com.project.springboot.dao;

public class BoardPage
{
	/* List.jsp에서 전달해준 인수를 아래 매개변수를 통해 받는다. */
	public static String pagingStr(int totalCount, int pageSize, int blockPage,
            int pageNum, String reqUrl, String searchField, String searchWord) 
	{      
		// 페이지 바로가기 링크를 저장할 문자열 변수 생성
    	 String pagingStr = "";
		 String pageitem = "page-item";
	     String hash = "#";
	     String pageling = "page-link";
        
    	// 전체 페이지 수를 계산한다.
        int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));
        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1; 
        
        /*
	     	pageTemp가 1이 아닐때만, 즉 첫번째 블럭이 아닐때만 이전블럭
	     	바로가기 링크를 화면에 출력한다.
	     */
        if (pageTemp != 1) {
            pagingStr += "<li class=\" "+ pageitem +" \"><a href=\""+ reqUrl  + "?pageNum=" + 1;
            
            if(searchWord != null) {
            	pagingStr += "&searchField=" + searchField + "&searchWord="+ searchWord ;
            }
            
            pagingStr += "\" class=\""+ pageling +"\">&laquo;</a></li>";
            pagingStr += "<li class=\" "+ pageitem +" \"><a href=\""+ reqUrl  + "?pageNum=" + (pageTemp - 1);
            		
            if(searchWord != null) {
            	pagingStr += "&searchField=" + searchField + "&searchWord="+ searchWord ;
            }		
            
            pagingStr += "\" class=\""+ pageling +"\">&lt;</a></li>";
        }

        /*
	     	각 페이지 번호로 바로가기 링크 출력
	     	앞에서 계산한 pageTemp를 blockPage만큼 반복해서 출력한다.
	     	이때 1씩 증가시켜준다. 즉 한블럭당 5페이지를 출력한다.
	     */
        
        int blockCount = 1;
        while (blockCount <= blockPage && pageTemp <= totalPages) {
        	// 만약 현재페이지라면 링크를 걸지 않는다.
            if (pageTemp == pageNum) {
            	pagingStr += "<li class=\" "  + pageitem + " active" +" \"><a href=\" "+ hash +" \" class= \" " + pageling + " \">"+ pageTemp +"</a></li>";
            } else {
            	// 현재페이지가 아닌 경우에만 링크를 추가한다.
                pagingStr += "<li class=\" "  + pageitem  +" \"><a href=\" "+ reqUrl + "?pageNum=" + pageTemp ;
               
                if(searchWord != null) {
                	pagingStr += "&searchField=" + searchField + "&searchWord="+ searchWord ;
                }
                		
                 pagingStr += " \" class= \" " + pageling + " \">"+ pageTemp +"</a></li>";
            }
            // 반복하면서 1씩 증가시켜 순차적인 페이지번호를 출력한다.
            pageTemp++;
            blockCount++;
        }
        
        // 다음페이지 블럭 바로가기 링크 추가
        // 마지막 페이지가 아닌 경우에만 다음 블럭을 출력한다.
        if (pageTemp <= totalPages) {
            
            pagingStr += "<li class=\" "+ pageitem +" \"><a href=\""+ reqUrl  + "?pageNum=" + pageTemp ;
            
            if(searchWord != null) {
            	pagingStr += "&searchField=" + searchField + "&searchWord="+ searchWord ;
            }
            		
            		
            pagingStr += "\" class=\""+ pageling +"\">&gt;</a></li>";
            pagingStr += "<li class=\" "+ pageitem +" \"><a href=\""+ reqUrl  + "?pageNum=" + totalPages;
            
			 if(searchWord != null) {
	         	pagingStr += "&searchField=" + searchField + "&searchWord="+ searchWord ;
	         }		
            		
			 pagingStr +="\" class=\""+ pageling +"\">&raquo;</a></li>";
        }
        
        return pagingStr;
    }
}
