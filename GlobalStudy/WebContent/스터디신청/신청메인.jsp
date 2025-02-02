<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="MyStudy.MyStudyDAO" %>
    <%@ page import="MyStudy.MyStudyVO" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%!
    //한페이지에 보여줄 게시글 수를 지정함
    int pageSize = 5;
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    %>
    <%
    String pageNum = request.getParameter("pageNum");
    String code = request.getParameter("code");
    
    if(pageNum==null){
    	pageNum="1";
    }
    if(code==null){
    	code="6";
    }
    
    int currentPage = Integer.parseInt(pageNum);
    int start=(currentPage-1)*pageSize+1;
    int end=currentPage*pageSize;
    
    int count = 0;
    int number = 0;
    
    List<MyStudyVO>articleList = null;
    MyStudyDAO dbPro = MyStudyDAO.getInstance();
    count = dbPro.getArticleCount3(code);
  
    if(count>0){
    articleList = dbPro.getArticles3(start, end, code);
    }
    number = count-(currentPage-1)*pageSize;
    %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>스터디신청</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <link href="../css/main.css" rel="stylesheet"/>
        <link href="../css/사이드바.css" rel="stylesheet"/>
        <link href="../css/목록.css" rel="stylesheet">
    </head>
    <body id="page-top">
         <nav class="navbar">
            <div class="navbar_logo">
                <i class="fa-solid fa-award"></i>   
                <a href="../1.메인사이트/main.jsp">LOGO</a>
            </div>
            <ul class="navbar_menu">
                <li><a href="../4.스터디찾기/스터디목록.jsp">스터디찾기</a></li>
                <li><a href="../5.스터디등록/스터디등록.jsp">스터디등록</a></li>
                <li><a href="#">레벨테스트</a></li>
                <li><a href="../7.내스터디/개인정보.jsp">내스터디</a></li>
                <li><a href="#">후기작성</a></li>
            </ul>
            <ul class="navbar_icons">
                <li><a href="/2.로그인/Login.jsp"><ion-icon name="log-in-outline"></ion-icon></a></li>
                <li><a href="/3.회원가입/회원가입.jsp"><i class="fa-solid fa-user"></i></a></li>
            </ul>
    
            <a href="../4.스터디찾기/스터디목록.jsp" class="navbar_toogleBtn">
                <i class="fa-solid fa-bars"></i>
            </a>
        </nav>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
            <a class="navbar-brand js-scroll-trigger" href="../7.내스터디/개인정보.jsp">
                <span class="d-block d-lg-none">언어스터디</span>
                <span class="d-none d-lg-block"><img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="/연습용/img/네즈코.png" alt="..." /></span>
            </a>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link js-scroll-trigger" href="../7.내스터디/개인정보.jsp">개인정보</a></li>
                    <li class="nav-item"><a class="nav-link js-scroll-trigger" href="../스터디정보/정보메인.jsp">스터디정보</a></li>
                    <li class="nav-item"><a class="nav-link js-scroll-trigger" href="../스터디신청/신청메인.jsp">스터디신청</a></li>
                    <li class="nav-item"><a class="nav-link js-scroll-trigger" href="../스터디관리/관리메인.jsp">스터디관리</a></li>
                    <li class="nav-item"><a class="nav-link js-scroll-trigger" href="../스터디후기/후기메인.jsp">후기작성</a></li>
                </ul>
            </div>
        </nav>
        <!-- Page Content-->
        <div class="container-fluid p-0">
            <!-- About-->
            <%if(count==0){
%>
 <section class="resume-section" id="about">
                <div class="resume-section-content">
                    <div class="board_list_wrap">
                        <table class="board_list">
                            <td align="center">
								스터디 신청이 없습니다.
							</td>                   
                        </table>
                        </div>
                    </div>
                </div>
            </section>

<%}else{ %>
            
            <section class="resume-section" id="about">
                <div class="resume-section-content">
                    <div class="board_list_wrap">
                      <form action=""  method="get">
                        <table class="board_list">
                            <caption>게시판 목록</caption>
                            <thead>
                                <tr>
                                    <th>언어</th>
                                    <th class="tit">신청 제목</th>
                                    <th>신청자</th>
                                    <th>신청날짜</th>
                                    <th></th>
                                </tr>
                            </thead>
                                <% for(int i=0;i<articleList.size();i++){
                            	MyStudyVO article = (MyStudyVO)articleList.get(i);			
                            	%>
                                <tr>
                                    <td><%=article.getS_LANNAME() %></td>
                                    <td class="tit"><a href="../스터디신청/신청.jsp?s_JOINCODE=<%=article.getS_JOINCODE()%>&pageNum=<%=currentPage%>">
                                    <%=article.getSj_TITLE() %></a></td>
                                    <td><%=article.getSj_NAME() %></td>
                                    <td><%=article.getSj_DATE() %></td>
                                    <td>
                                   <input type="submit" value="수락" onclick="this.form.action='../스터디신청/신청수락.jsp'" >                                 
                                    <input type="submit" value="거절" onclick="this.form.action='../스터디신청/신청거절.jsp'" >
                                     <input type="hidden" name="s_JOINCODE" value="<%=article.getS_JOINCODE()%>"></td>   
                                        
                                </tr>      
                                                      
                                	<%} %>
                             
                        </table>
                        </form> 
                         <%} %>
                                     <div class="paging">
<%
if(count>0){
	 
	int pageBlock=5;
	int imsi = count%pageSize==0?0:1;
	int pageCount = count/pageSize + imsi;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage+pageBlock -1;
	if(endPage>pageCount) endPage=pageCount;
	
	//이전 블럭, 다음블럭
	if(startPage>pageBlock){
		%>
		<a href="신청메인.jsp?pageNum=<%=startPage-pageBlock%>" class="bt"><</a>
	<%
		}
	for(int i = startPage;i<=endPage;i++){
	%>
	<a href="신청메인.jsp?pageNum=<%=i%>"  class="num">[<%=i%>]</a>
<% 
}
	 %>
		<a href="신청메인.jsp?pageNum=<%=startPage+pageBlock%>class="bt">></a>	
	
	<% 
}
%>
                    </div>
                     
                </div>
            </section>
            
            <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
            <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    </body>
</html>
