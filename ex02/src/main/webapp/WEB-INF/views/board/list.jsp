<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Tables</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Board List Page
                        <button type="button" id="regBtn" class="btn btn-xs pull-right">Register New Board</button>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>#번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>수정일</th>
                            </tr>
                            </thead>

                            <c:forEach items="${list}" var="board">
                                <tr>
                                    <td><c:out value="${board.bno}"/></td>
                                    <td>
                                        <a href='/board/get?bno=<c:out value="${board.bno}"/>'>
                                            <c:out value="${board.title}"/>
                                        </a>
                                    </td>
                                    <td><c:out value="${board.writer}"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                                </tr>
                            </c:forEach>
                        </table>

                        <div class="pull-right">
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button previous">
                                        <a href="${pageMaker.startPage-1}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach var="num" begin="${pageMaker.startPage}" end ="${pageMaker.endPage}">
                                    <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}">
                                        <a href="${num}">${num}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${pageMaker.next}">
                                    <li class="paginate_button next">
                                        <a href="${pageMaker.endPage +1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                            <%-- end Pagination--%>

                        <form id="actionForm" action="/board/list" method="get">
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                        </form>


                    <%--   Modal추가   --%>
                     <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                         <div class="modal-dialog">
                             <div class="modal-content">
                                 <div class="modal-header">
                                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                     <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                 </div>

                                 <div class="modal-body">처리가 완료되었습니다.</div>
                                 <div class="modal-footer">
                                     <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                     <button type="button" class="btn btn-primary">Save changes</button>
                                 </div>
                             </div>
                    <%--     /.modal-content    --%>
                         </div>
                <%--    /.modal-dialog     --%>
                     </div>
            <%--      /.modal         --%>

                    </div>
                    <!-- /.end panel-body -->
                </div>
                <!-- /. end panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
    <%--  rttr.addFlashAttribute("result", board.getBno());의 result사용 --> 생성된 게시물의 번호가 result에 할당  --%>
    <%-- 새로운 게시물의 번호는  addFlashAttribute()로 저장되었기 때문에 한 번도 사용된적이 없다면 값이 할당되지만, 사용자가 '/board/list' 를 호출하거나, 새로고침을 통해서 호출하는 경우는 아무값도 할당x  --%>
    <%--   addFlashAttribute()를 이용해서 일회성으로만 데이터를 사용할 수 있으므로, 이를 이용해서 경고창이나 모달창 등을 보여주는 방식으로 처리할 수 있음  --%>
    $(document).ready(
        function (){
        var result = '<c:out value="${result}"/>';

        // Modal창 띄우기
        checkModal(result);

        history.replaceState({}, null,null);

        function checkModal(result){
            if (result ===''||history.state){
                return;
            }
            if (parseInt(result) > 0){
                $(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다.");
            }
            $("#myModal").modal("show");
        }

        // 버튼 클릭시 게시글 등록 폼으로 이동
        $("#regBtn").on("click", function (){
            self.location = "/board/register";
        });

        var actionForm = $("#actionForm");
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault(); // javaScript에서는 <a>태그를 클릭해도 페이지 이동이 없도록 preventDefault()처리
            console.log('click');
            actionForm.find("input[name='pageNum']").val($(this).attr("href")); // <form>태그 내의 pageNum 값은 href속성으로 변경
            actionForm.submit(); // actionForm 자체를 submit()
        });

    });
</script>

