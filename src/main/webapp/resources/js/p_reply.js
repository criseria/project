console.log("reply Module......");

var replyService = (function(){
	
	// 데이터 삽입
	function add(reply, callback, error){
		$.ajax({
			type : 'post',
			url : '/reply/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 데이터 목록
	function getList(param, callback, error){
		var pno = param.pno;
		var page = param.page || 1;
		
		$.ajax({
			type : 'get',
			url : '/reply/pages/' + pno + '/' + page + '.json',
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글 삭제
	function remove(rno, callback, error){
		$.ajax({
			type : 'delete',
			url : '/reply/' + rno,
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글 수정
	function update(reply, callback, error){
		$.ajax({
			type : 'put',
			url : '/reply/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(rno, callback, error){
		$.ajax({
			type : 'get',
			url : '/reply/' + rno + '.json',
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	
	
	return {
			add:add,
			getList:getList,
			remove:remove,
			update:update,
			get:get
			};

})();
