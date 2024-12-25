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
<title>달력</title>

<body>
<div class="form-group">
 	<div id="calendar-container" style="width: 80%; height: 600px; margin: 0 auto;">
    	<div id="calendar"></div>
	</div>
</div>
</body>
<!-- Modal -->
		<!-- addSchedule 모달창 :: 일정 등록 -->
		<div class="modal fade" id="addSchedule" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">신규 사내일정 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<!-- 모달 일정 등록폼 -->
				<form id="addScheduleForm" action="${pageContext.request.contextPath}/groupware/schedule/scheduleList" method="post">
					<div class="modal-body">
						<div class="row mb-5">
							<label for="inputEmail" class="col-sm-4 col-form-label">시작날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="startDate" name="startDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">종료날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="endDate" name="endDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정제목</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="text" class="form-control" id="title" name="title">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정종류</label>
							<div class="col-sm-8 scheduleModalDiv">
							<label for="meetingRadio">
								<input class="form-check-input" type="radio" name="type" value="1" id="meetingRadio" checked> 개인
							</label>&nbsp;&nbsp;&nbsp;
							<label for="festivalRadio">
								<input class="form-check-input" type="radio" name="type" value="2" id="festivalRadio"> 팀
							</label>&nbsp;&nbsp;&nbsp;
							<div class="col-sm-8 scheduleModalDiv" id="teamMembersDiv" style="display: none;">
							    <select class="form-control" id="teamMembers" name="teamMembers[]" multiple>
							        <option value="member1">팀원 1</option>
							        <option value="member2">팀원 2</option>
							        <option value="member3">팀원 3</option>
							        <option value="member4">팀원 4</option>
							    </select>
							    <small>Ctrl 또는 Shift 키를 사용하여 여러 명 선택 가능합니다.</small>
							</div>
							<!-- <label for="inspectionRadio">
								<input class="form-check-input" type="radio" name="type" value="3" id="inspectionRadio"> 점검
							</label>  -->
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정내용</label>
							<div class="col-sm-8">
								<textarea rows="3" maxlength="100" class="col-sm-12" id="addContent" name="content" placeholder="100자 이하 작성" style="height: 150px"></textarea>
								(<span id="chatHelper">0</span>/100)
							</div>
						</div>
					</div>
					
					<!-- 모달 일정 취소/등록버튼 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button id="addScheduleBtn" type="submit" class="btn btn-primary">Save</button>
					</div>
				</form>
			</div></div>
		</div>
		<!-- End addSchedule Modal-->
 <!-- 캘린더API  -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    let calendarEl = document.getElementById('calendar');

    let calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth addEventButton',
        },
        customButtons: {
            addEventButton: {
                text: "신규일정추가",
                click: function() {
                    $("#addSchedule").modal("show");
                }
            }
        },
        locale: 'ko',
        selectable: true,
        dayMaxEvents: true,
        events: function(response, successCallback, failureCallback) { // 비동기 처리를 위해 콜백 함수 사용
            $.ajax({
                url: "/scheduleCalList",
                method: "GET"
            })
            .done((response) => {
                console.log(response);
                let events = response.map(schedule => ({
                    title: schedule.scheduleTitle,
                    start: schedule.startDate,
                    end: schedule.endDate,
                    backgroundColor: getScheduleColor(schedule.typeNo),
                    borderColor: getScheduleColor(schedule.typeNo),
                    url: `/calendarDetail?scheduleNo=${schedule.scheduleNo}`,
                    allDay: false
                }));
                successCallback(events);
            })
            .fail(() => {
                failureCallback();
            });
        }
    });

    calendar.render();

    function getScheduleColor(typeNo) {
        switch (typeNo) {
            case 1: return '#81bbb2'; // 회의
            case 2: return '#af92e2'; // 행사
            case 3: return '#ffbb57'; // 점검
            default: return '#ffffff';
        }
    }
    
    
    
    const teamRadio = document.getElementById('festivalRadio');
    const personalRadio = document.getElementById('meetingRadio');
    const teamMembersDiv = document.getElementById('teamMembersDiv');

    // 라디오 버튼 변경 이벤트 감지
    document.querySelectorAll('input[name="type"]').forEach(radio => {
        radio.addEventListener('change', function () {
            if (teamRadio.checked) {
                teamMembersDiv.style.display = 'block'; // 팀원 선택 표시
            } else if (personalRadio.checked) {
                teamMembersDiv.style.display = 'none'; // 팀원 선택 숨김
            }
        });
    });
    
});


</script>
</head>
</html>