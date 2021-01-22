$(function(){
	setTimeout(function(){
		setInterval(function(){contentjs();}, 3000)
	}, 2000);
});

var contentjs = function(){
	if ($("div[action-type='feed_list_item']").length > 0) {
   		$("div[action-type='feed_list_item']").each(function(){
		    if ($(this).find(".sandy_info").length > 0) {
			    return;
		    }
                    mid = $(this).attr("mid");
                    action_data = $(this).find(".media_box").children(0).attr("action-data");
                    myRe = /id%3D(\d+)&/g;
                    tmparr = myRe.exec(action_data);
                    if ((tmparr instanceof Array) && tmparr.length > 1) {
                        $(this).find(".WB_info").append("<span  class='sandy_info' onclick='copyitem("+mid+")'>"+mid + "</span> <span onclick='copyitem(" + tmparr[1] + ")'>" + tmparr[1]+"</span>");
                    } else {
			tbinfo = $(this).attr("tbinfo");
                        myRe = /ouid\=(\d+)/g;
			tmparr = myRe.exec(tbinfo);
                        if ((tmparr instanceof Array) && tmparr.length > 1) {
                              uid = tmparr[1];
			      $(this).find(".WB_info").append("<span class='sandy_info'>"+mid + " " + uid+"</span>");
			}
		    }
	});
    } else if ($("div[node-type='feed_list']").length > 0) {
   	$("div[node-type='feed_list']").children().each(function(){
		if ($(this).find(".sandy_info").length > 0) {
                            return;
                }
		mid = $(this).attr("mid");
		tbinfo = $(this).attr("tbinfo");
		myRe = /ouid\=(\d+)/g;
		tmparr = myRe.exec(tbinfo);
		if ((tmparr instanceof Array) && tmparr.length > 1) {
		    uid = tmparr[1];
		    $(this).find(".WB_info").append("<span class='sandy_info'>"+mid + " " + uid+"</span>");
		}
    	});
    }
}
