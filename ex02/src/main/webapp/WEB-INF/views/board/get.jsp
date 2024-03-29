<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class = "page-header">Board Read</h1>
    </div>
    <%--  /.col-lg-12 --%>
</div>
<%--  /.row  --%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Board Read Page</div>
            <%--  /.panel-heading     --%>

            <div class="panel-body">

                <div class = "form-group">
                    <label>Bno</label>
                    <input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly">
                </div>

                <div class = "form-group">
                    <label>Title</label>
                    <input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
                </div>

                <div class = "form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly">
                </div>

                <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                <button data-oper="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>

                <form id="operForm" action="/board/modify" method="get">
<%--                    사용자가 수정 버튼을 누르는 경우에는 bno값을 같이 전달--%>
                    <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                    <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                    <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                    <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>

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
    $(document).ready(function (){
        var operForm = $("#operForm");

        $("button[data-oper = 'modify']").on("click", function (e){
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper = 'list']").on("click", function (e){
            operForm.find("#bno").remove(); // list로 이동하는 경우에는 아무데이터도 필요하지 않으므로 bno지움 , submit을 통해서 리스트 페이지로 이동
            operForm.attr("action", "/board/list");
            operForm.submit();
        });
    });
</script>