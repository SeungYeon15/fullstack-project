<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/ssi/ssi_poll.jsp" %>
<jsp:useBean id="dto" class="poll.PollDTO"/>
<jsp:setProperty name="dto" property="*"/>
<jsp:useBean id="idto" class="poll.PollitemDTO"/>
<jsp:setProperty name="idto" property="*" />
<jsp:useBean id="service" class="poll.PollService"/>
<%
int parent = Integer.parseInt(request.getParameter("parent"));
//조회수 증가
service.upViewcnt(parent);
//데이터 조회
Vector<PollitemDTO> list = service.readQuestion(parent);
Vector<PollitemDTO> itemlist = service.readPollItem(list);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
function vote(e) {
	let itemno = document.getElementById(e.getAttribute('id')).getAttribute('id');
	
	let nowType = document.getElementById(itemno).value; //설문유형 확인
	
	let items = document.getElementsByName(itemno); 
 	let btnCheck = false; //버튼이 하나 이상 체크되었는지 확인
 	
	if (nowType == 1 ||  nowType==2){
		let parent = document.getElementById(itemno).name;
		itemno = itemno + "-" + nowType;
		let anwser = document.getElementById(itemno).value; 
		if(anwser.trim()==""){
			alert("답변을 입력하세요.");
		}else{
			let xhr = new XMLHttpRequest();
			let url = "ajax_type12.jsp?parents="+parent+"&nowPage="+nowType+"&anwser="+anwser;
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
					//전송 성공
					alert("투표 성공");
				}
			}
		}
	}else{
		let parent = "";
	 	items.forEach((node) => {
	 		if(node.checked){
	 			parent = parent + node.value + "-"; 
	 			btnCheck = true;
			}
		})
		
		if(!btnCheck){
			alert("항목을 선택하세요.");
		}else{
			let xhr = new XMLHttpRequest();
			let url = "ajax_type34.jsp?parents="+parent;
			xhr.open("GET", url, true);
			xhr.send();
			xhr.onreadystatechange = function() {
				if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
					//전송 성공
					alert("투표 성공");
				}
			}
		}
	}
}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container mt-5">
		<% if(list.size() == 0) { %>
		<h3>응답할 설문이 없습니다.</h3>
		<%
		}else{
			int cnt = 0;
			int eloof = 0;
			for(int i=0; i<list.size(); i++){
				int sloof = 0;
				PollitemDTO ldto = list.get(i);
				PollitemDTO itdto = itemlist.get(cnt);
				sloof = cnt;
				int sloofParent = itdto.getParent();
				for(int j=cnt; j<itemlist.size(); j++){
					//자식 항목 몇 개인지 구하기
					PollitemDTO tempItdto = itemlist.get(j);
					if (sloofParent == tempItdto.getParent()){
						eloof ++;
					}
				}
				cnt = eloof;
		%>
		<ul class="list-group shadow-sm mt-5">
			<li class="list-group-item list-group-item-secondary">
				<h3><%=ldto.getQuestion() %></h3>
			</li>
			<li class="list-group-item">

			<% if(itdto.getType() == 1) { %>
				<input type="text" id="<%= "item-"+i+"-"+ itdto.getType() %>" class="form-control shadow-sm">
			<% }else if(itdto.getType() == 2) { %>
				<textarea id="<%= "item-"+i+"-"+ itdto.getType() %>" class="form-control shadow-sm" rows=8></textarea>
			<% }else if(itdto.getType() == 3) { %>
				<% 
				for(int j=sloof; j<eloof; j++){ 
					PollitemDTO temp = itemlist.get(j);
				%>
				<div class="form-check">
			      	<input type="radio" class="form-check-input" id="<%= "item-"+ i %>" name="<%= "item-"+i %>" value="<%= temp.getNum()%>">
			      	<label class="form-check-label" for="<%= "item-"+i %>"><%= temp.getContent() %></label>
			    </div>
			    <% 
			    } //for end 
			    %>
			<% }else if(itdto.getType() == 4) { %>
				<% 
				for(int j=sloof; j<eloof; j++){ 
					PollitemDTO temp = itemlist.get(j);
				%>
				<div class="form-check">
			      	<input type="checkbox" class="form-check-input" id="<%= "item-"+i %>" name="<%= "item-"+i %>" value="<%= temp.getNum() %>">
			      	<label class="form-check-label" for="<%= "item-"+i %>"><%= temp.getContent() %></label>
			    </div>
			    <% 
			    } //for end 
			    %>
			<% 
			} //if end 
			%> 
		
			</li>
		</ul>
		<div class="column mt-3 mb-5">
			<!-- name: parent, value: type -->
			<button class="btn btn-dark px-4" id="<%= "item-"+ i %>" name="<%=itdto.getParent() %>"  value="<%=itdto.getType() %>" onclick="vote(this)">투표</button>
			<!-- <button class="btn btn-dark px-4" id="<%= "item-"+ i %>" onclick="result(this)">결과</button> -->
		</div>
		<%
			} //for end
		} //if end
		%>
	</div>
	
	<jsp:include page="/menu/bottom.jsp" />
</body>
</html>