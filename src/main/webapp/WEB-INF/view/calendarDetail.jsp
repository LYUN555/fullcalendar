<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<meta charset="UTF-8">
<body>


	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>사내 일정 상세 및 수정</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/empMain">Home</a></li>
	      <li class="breadcrumb-item"><a href="/scheduleList">Schedule</a></li>
          <li class="breadcrumb-item active">Schedule Detail & Edit</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
		<div class="row justify-content-center"><div class="col-lg-6">

			<div class="card"><div class="card-body">
				<h5 class="card-title">Schedule Detail & Edit</h5>
				
				
				<!-- 상세보기 -->
				<form id="modScheduleForm" action="${pageContext.request.contextPath}/scheduleDetail" method="post">
					<input type="hidden" value="1" name="scheduleNo">
					
	                <div class="row mb-3">
						<label for="inputEmail3" class="col-sm-2 col-form-label">시작날짜</label>
						<div class="col-sm-10">
							<input type="datetime-local" class="form-control" id="modStartDate" name="startDate" value="">
						</div>
	                </div>
	                
					<div class="row mb-3">
						<label for="inputEmail3" class="col-sm-2 col-form-label">종료날짜</label>
						<div class="col-sm-10">
							<input type="datetime-local" class="form-control" id="modEndDate" name="endDate" value="">
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">일정제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="modTitle" name="title" value="">
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">일정종류</label>
						<div class="col-sm-10">
							<label for="meetingRadio">
								<input class="form-check-input" type="radio" name="type" value="1" id="meetingRadio"> 회의
							</label>
							
							&nbsp;&nbsp;&nbsp;
							
							<label for="festivalRadio">
								<input class="form-check-input" type="radio" name="type" value="2" id="festivalRadio"> 행사
							</label>
							
							&nbsp;&nbsp;&nbsp;
							
							<label for="inspectionRadio">
								<input class="form-check-input" type="radio" name="type" value="3" id="inspectionRadio"> 점검
							</label>
						</div>
	                </div>
	                
	                <div class="row mb-3">
	                	<label for="inputPassword3" class="col-sm-2 col-form-label">일정내용</label>
	                	<div class="col-sm-10">
	                		<textarea rows="3" maxlength="100" class="col-sm-12" 
	                					id="modContent" name="content" style="height: 150px"></textarea>
							(<span id="chatHelper">0</span>/100)
	                	</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="" style="background: #d9dce1;" readonly>
						</div>
					</div>
	                
	                <div class="text-center">
	                	<!-- 수정 버튼 -->
	                	<button type="submit" class="btn btn-primary" id="modScheduleBtn">Edit</button>
	                	<!-- 삭제 버튼 -->
	                	<a class="btn btn-primary" id="DelScheduleBtn" href="/scheduleRemove">
	                		Delete
	                	</a>
	                	<!-- 전페이지로 이동 버튼 -->
	                	<button type="button" onclick="history.back()" class="btn btn-secondary">Close</button>
	                </div>
				</form>
			</div></div>
		</div></div>    
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- type분류에 맞는 checked 추가 / 키보드 이벤트 발생 / 유효성 검사  -->
	<script>
		/* type 값에 맞게 checked 추가해주기
		if(${s.type eq '회의'}){
			console.log('회의!');
			$('#meetingRadio').attr('checked', true);
			
		}else if(${s.type eq '행사'}){
			console.log('행사!');
			$('#festivalRadio').attr('checked', true);
			
		}else if(${s.type eq '점검'}){
			console.log('점검!');
			$('#inspectionRadio').attr('checked', true);
			
		}
		 */
		
		/* 키보드 이벤트 발생 
	 	$('#modContent').keyup(function() {
			console.log('키보드 이벤트 확인');
			
			let cnt = $('#modContent').val().length;
			//console.log('키보드 이벤트 확인 cnt-> ', cnt);
			
			// 100글자 이상일경우 문자열 자르기
			if(cnt > 100){
				console.log('100이상 작성으로 substr실행');
				cnt = 100;
				$('#modContent').val($('#modContent').val().substr(0, 100));
			}
			
			// cnt수 사용자에게 보여주기
			$('#chatHelper').html(cnt);
			
		});
		*/
		
		일정 수정 유효성 검사
		$('#modScheduleBtn').click(function() {
			
			// 시작 날짜 유효성 검사
			if($('#modStartDate').val().length < 1){
				console.log('시작날짜 유효성검사');
				
				alert('시작날짜를 입력해주세요');
				$('#modStartDate').focus();
				return false; 
			}
			
			// 종료 날짜 유효성 검사
			if($('#modEndDate').val().length < 1){
				console.log('종료날짜 유효성검사');
				
				alert('종료날짜를 입력해주세요');
				$('#modEndDate').focus();
				return false; 
			}
			
			// 제목 유효성 검사
			if($('#modTitle').val().length < 1){
				console.log('제목 유효성검사');
				
				alert('제목을 입력해주세요');
				$('#modTitle').focus();
				return false; 
			}
			
			// 내용 유효성 검사
			if($('#modContent').val().length < 1){
				console.log('내용 유효성검사');
				
				alert('일정내용을 입력해주세요');
				$('#modContent').focus();
				return false; 
			}
			
			// 유효성 검사 완료시 Form 보내기
			modScheduleBtn.submit();
		}); 
	</script>
</body>
</html>