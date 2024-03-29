<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%--    <script src="https://code.jquery.com/jquery-latest.min.js"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>Insert title here</title>

    <style>
        .uploadResult {
            width=100%;
            background-color: gray;
        }
        .uploadResult ul {
            display:flex;
            flex-flow: row;
            justify-content: center;
            align-items: center;
        }
        .uploadResult ul li {
            list-style: none;
            padding: 10px;
            align-content: center;
            text-align: center;
        }
        .uploadResult ul li img {
            width: 100px;
        }

        .uploadResult ul li span {
            color: white;
        }

        .bigPictureWrapper {
            position: absolute;
            display: none;
            justify-content: center;
            align-items: center;
            top: 0%;
            width: 100%;
            height: 100%;
            background-color: gray;
            z-index: 100;
            background: rgba(255,255,255,0.5);
        }

        .bigPicture {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .bigPicture img {
            width: 600px;
        }
    </style>

</head>
<body>
<h1>Upload with Ajax</h1>
<div class="uploadDiv">
    <input type="file" name="uploadFile" multiple>
</div>
<button id="uploadBtn">Upload</button>

<div class="uploadResult">
    <ul>

    </ul>
</div>

<div class="bigPictureWrapper">
    <div class="bigPicture">
    </div>
</div>

<script>
    function showImage(fileCallPath){
        //alert(fileCallPath);
        $(".bigPictureWrapper").css("display" , "flex").show();
        $(".bigPicture")
            .html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
            .animate({width:'100%' , height:'100%'} , 1000); // animate()를 이용해서 지정된 시간 동안 화면에서 열리는 효과를 처라

        //<div>는 전체 화면을 차지하기 때문에 다시 한번 클릭하면 사라지도록 이벤트 처리
        $(".bigPictureWrapper").on("click" , function (e){
            $(".bigPicture")
                .animate({width: '0%' , height: '0%'}, 1000);
                setTimeout(function(){
                    $(".bigPictureWrapper").hide();
                }, 1000)
        });
    }
</script>


<script>
    $(document).ready(function (){

        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 5242880; // 5MB

        function checkExtension(fileName, fileSize){
            if(fileSize >= maxSize){
                alert("파일 사이즈 초과");
                return false;
            }

            if (regex.test(fileName)){
                alert("해당 종류의 파일은 업로드할 수 없습니다.")
                return false;
            }

            return true;
        }

        var cloneObj = $(".uploadDiv").clone();

        // 파일 이름 출력 & 다운로드 경로 추가
        var uploadResult = $(".uploadResult ul");
        function showUploadFile(uploadResultArr){
            var str = "";
            $(uploadResultArr).each(function (i, obj){
                if (!obj.image){
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid+"_"+obj.fileName);

                    var fileLink = fileCallPath.replace(new RegExp(/\\/g) , "/");

                    str += "<li><div><a href='/download?fileName=" + fileCallPath +"'>"+"<img src='/resources/img/attach.png'>" + obj.fileName + "</a>"
                        + "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>" + "</div></li>"
                } else {
                    // str += "<li>" + obj.fileName + "</li>"
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid+"_" + obj.fileName);

                    // 이미지 첨부파일의 경우 업로드된 경로와 UUID가 붙은 파일의 이름이 필요
                    var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;

                    // 생성된 문자열은 \ 기호 때문에 일반 문자열과는 다르게 처리되므로 "/" 로 변환한 뒤 showImage에 파라미터로 전달
                    originPath = originPath.replace(new RegExp(/\\/g) , "/");
                    str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
                        +"<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>" +"</li>";
                }
            });
            uploadResult.append(str);
        }

        $("#uploadBtn").on("click" , function (e){
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");

            var files = inputFile[0].files;
            console.log(files);

            //add File Data to formData
            for(var i = 0 ; i < files.length; i++){
                if(!checkExtension(files[i].name , files[i].size)){
                    return false
                }
                formData.append("uploadFile", files[i])
            }

            $.ajax({
                url:'/uploadAjaxAction',
                processData : false,
                contentType : false,
                data : formData,
                type : 'POST',
                dataType:'json',
                success : function (result){
                    alert("Uploaded");
                    console.log(result);
                    showUploadFile(result);
                    $(".uploadDiv").html(cloneObj.html());
                }
            }); // $.ajax

        });

        $(".uploadResult").on("click", "span" , function (e){
            var targetFile = $(this).data("file");
            var type = $(this).data("type");
            console.log(targetFile);

            $.ajax({
                url: '/deleteFile',
                data: {fileName : targetFile , type : type},
                dataType: 'POST',
                success : function (result){
                    alert(result);
                }
            }) // $.ajax
        });

    });
</script>

</body>
</html>
