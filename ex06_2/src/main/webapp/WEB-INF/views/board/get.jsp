<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

                <sec:authentication property="principal" var="pinfo"/>

                    <sec:authorize access="isAuthenticated()">
                        <c:if test="${pinfo.username eq board.writer}">
                            <button data-oper="modify" class="btn btn-default">Modify</button>
                        </c:if>
                    </sec:authorize>

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

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply

                <sec:authorize access="isAuthenticated()"><!-- 로그인한 사용자만이 버튼 보이게 -->
                    <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
                </sec:authorize>

            </div>
            <div class="panel-body">
                <ul class="chat">
                    <li class="left clearfix" data-rno="'12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2018-01-01 13:13</small>
                            </div>
                            <p>Good job!</p>
                        </div>
                    </li>
                <%--  end reply   --%>
                </ul>
                <!-- /.panel .chat-panel -->
            </div>
            <div class="panel-footer">

            </div>
        </div>
    </div>
    <!-- ./ end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply!!!"/>
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer"/>
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name='replyDate' />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="modalModBtn" class="btn btn-warning">Modify</button>
                <button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
                <button id="modalCloseBtn" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="modalRegisterBtn" class="btn btn-primary" data-dismiss="modal">Register</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
    $(document).ready(function (){
        // console.log("===================")
        // console.log("JS TEST")
        var bnoValue = '<c:out value="${board.bno}"/>'
        var replyUL = $(".chat");

        showList(1);

        // showList함수는 파라미터로 전달되는 page변수를 이용해서 원하는 댓글 페이지를 가져오게 함
        function showList(page){ // 페이지 번호를 파라미터로 받도록 설계
            console.log("show list " + page);

            replyService.getList({bno : bnoValue, page : page|| 1 }, function(replyCnt, list) {
                console.log("replyCnt : " + replyCnt);
                console.log("list : " + list);
                console.log(list)

                if(page == -1) {
                    pageNum = Math.ceil(replyCnt/10.0);
                    showList(pageNum);
                    return;
                }
                var str="";
                if(list == null || list.length==0){
                    //replyUL.html("");
                    return;
                }

                for (var i = 0, len = list.length || 0; i < len; i++) {
                    str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
                    str +="  <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                    str +="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
                    str +="    <p>"+list[i].reply+"</p></div></li>";
                }

                replyUL.html(str);
                showReplyPage(replyCnt);
            }); // end function
        } // end show List
        var modal = $(".modal");
        var modalInputReply = modal.find("input[name='reply']");
        var modalInputReplyer = modal.find("input[name='replyer']");
        var modalInputReplyDate = modal.find("input[name='replyDate']");

        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");

        var replyer = null;

        <sec:authorize access="isAuthenticated()">
        replyer = '<sec:authentication property="principal.username"/>';
        </sec:authorize>

        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";

        $("#addReplyBtn").on("click", function (e){
            modal.find("input").val("");
            modal.find("input[name='replyer']").val(replyer);
            modalInputReplyDate.closest("div").hide();
            modal.find("button[id != 'modalCloseBtn']").hide();

            modalRegisterBtn.show();
            $(".modal").modal("show");

        });

        // Ajax spring security header... (beforeSend를 이용하는 방법도 있음)
        // ajaxSend를 이용한 코드는 모든 Ajax 전송 시 CSRF 토큰을 같이 전송하도록 세팅되기 때문에 매번 Ajax 사용시 beforeSend를 호출해야하는 번거로움을 줄일 수 있음
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });

        modalRegisterBtn.on("click", function (e){
            var reply = {
                reply : modalInputReply.val(),
                replyer : modalInputReplyer.val(),
                bno : bnoValue
            };

            replyService.add(reply, function (result){
                alert(result);
                modal.find("input").val("");
                modal.modal("hide");
                showList(-1); // 사용자가 새로운 댓글을 추가하면 showList(-1)을 호출해서 우선 전체 댓글의 숫자를 파악함
            });
        });

        modalModBtn.on("click" , function (e){
            var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
            replyService.update(reply, function (result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

        modalRemoveBtn.on("click", function (e){
            var rno = modal.data("rno");
            replyService.remove(rno, function (result){
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            });
        });

        // <ul> 태그의 클래스 'chat'을 이용해서 이벤트를 걸고 실제 이벤트 대상은 <li>태그가 되도록 함
        $(".chat").on("click", "li", function(e) {
            var rno = $(this).data("rno");

            replyService.get(rno, function(reply){
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
                modal.data("rno", reply.rno);

                modal.find("button[id != 'modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            });

        });


        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");

        function showReplyPage(replyCnt){

            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;

            var prev = startNum != 1;
            var next = false;

            if(endNum * 10 >= replyCnt){
                endNum = Math.ceil(replyCnt/10.0);
            }

            if(endNum * 10 < replyCnt){
                next = true;
            }

            var str = "<ul class='pagination pull-right'>";

            if(prev){
                str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
            }

            for(var i = startNum ; i <= endNum; i++){

                var active = pageNum == i? "active":"";

                str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
            }

            if(next){
                str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log(str);

            replyPageFooter.html(str);
        }

        replyPageFooter.on("click", "li a", function(e){
            e.preventDefault(); // a태그의 기본 동작 제한
            console.log("page click");

            var targetPageNum = $(this).attr("href"); // a태그의 href 속성값 가져오기

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);

        });



        //for replyService add test
        // replyService.add(
        //     {reply:"JS Test" , replyer:"tester" , bno:bnoValue},
        //     function (result){
        //         alert("RESULT:" + result);
        //     }
        // );

        // replyService.getList(
        //     {bno:bnoValue , page:1}, function (list){
        //         for(var i=0, len=list.length||0; i<len; i++){
        //             console.log(list[i]);
        //         }
        //     }
        // );

        // replyService.remove(35, function (count){
        //     console.log(count);
        //     if(count === "success"){
        //         alert("REMOVED");
        //         }
        //     }, function (err){
        //     alert("ERROR.....");
        //     });

        // replyService.update({
        //     rno :22,
        //     bno: bnoValue,
        //     reply : "Modified Reply...."
        // }, function (result){
        //     alert("수정 완료...");
        // });

        // replyService.get(36, function (data){
        //     console.log(data);
        // })
    }) ;
</script>

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