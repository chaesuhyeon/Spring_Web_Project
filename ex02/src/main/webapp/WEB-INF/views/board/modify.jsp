<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class = "page-header">Board Modify</h1>
    </div>
    <%--  /.col-lg-12 --%>
</div>
<%--  /.row  --%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Modify Page</div>
            <%--  /.panel-heading     --%>

            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <div class = "form-group">
                        <label>Bno</label>
                        <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
                    </div>

                    <div class = "form-group">
                        <label>Title</label>
                        <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
                    </div>

                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name="content" ><c:out value="${board.content}"/></textarea>
                    </div>

                    <div class = "form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>RegDate</label>
                        <input class="form-control" name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>Update Date</label>
                        <input class="form-control" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
                    </div>

                    <button type="submit" data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                    <button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                    <button type="submit" data-oper="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>
                </form>
            </div>
            <%--     end panel body      --%>
        </div>
        <%--   end panel body     --%>
    </div>
    <%--  end panel  --%>
</div>
<%-- /.row --%>

<script type="text/javascript">
    <%--  rttr.addFlashAttribute("result", board.getBno());의 result사용 --> 생성된 게시물의 번호가 result에 할당  --%>
    <%-- 새로운 게시물의 번호는  addFlashAttribute()로 저장되었기 때문에 한 번도 사용된적이 없다면 값이 할당되지만, 사용자가 '/board/list' 를 호출하거나, 새로고침을 통해서 호출하는 경우는 아무값도 할당x  --%>
    <%--   addFlashAttribute()를 이용해서 일회성으로만 데이터를 사용할 수 있으므로, 이를 이용해서 경고창이나 모달창 등을 보여주는 방식으로 처리할 수 있음  --%>
    $(document).ready( function (){
        var formObj = $("form");
        $('button').on("click", function (e){
            e.preventDefault();

            var operation = $(this).data("oper");
            console.log(operation);

            if(operation === 'remove'){
                formObj.attr("action" , "/board/remove");
            } else if(operation ==='list'){
                // 클릭한 버튼이 List인 경우 action 속성과 method 속성 변경
                formObj.attr("action", "/board/list").attr("method", "get");
                formObj.empty(); // 리스트로의 이동은 아무런 파라미터가 없기 때문에 <form>태그의 모든 내용은 삭제한 상태에서 submit()진행
            }
            formObj.submit();
        });

    });
</script>